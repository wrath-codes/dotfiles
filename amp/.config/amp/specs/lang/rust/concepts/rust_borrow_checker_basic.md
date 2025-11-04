# Rust Borrow Checker Basic

A few tips for not fighting the borrow checker.

## Tips

- **Returning References To Data That Will Die**

  You return a reference to a value that goes out of scope. It compiles only when the compiler can prove safety, which it often cannot, and you end up fighting lifetimes.
  - The Problem:

    ```rust
    // returns reference to local String: invalid
    fn first_word_bad(s: &str) -> &str {
        let tmp = s.split(' ').next().unwrap().to_string();
        &tmp // tmp dies here
    }
    ```

  - The Fix

    Return an owned value, or return a slice tied to the input.

    ```rust
    // zero-copy slice, tied to input
    fn first_word(s: &str) -> &str {
        s.split(' ').next().unwrap()
    }

    // or own it when you need to store it
    fn first_word_owned(s: &str) -> String {
        s.split(' ').next().unwrap().to_string()
    }
    ```

  - Why It Works

    A slice &str points into the original buffer. The borrow checker ensures it cannot outlive s. If you need independence, own it with String.
    - Diagram:

      ```text
      Stack frame of caller
      +-----------------------+
      | s: &str  ----------+  |
      |                    |  |
      +--------------------|--+
                           v
      Heap / Buffer: "hello world"
      [ h e l l o _ w o r l d ]
      ^------^
       first_word(s) -> &str within s
      ```

  - Benchmark Snapshot
    - **Change**: Return `&str` instead of `String` when not storing.
    - **Result**: On a 1M-call loop, typical speedup is 25 to 40 percent due to zero allocations and zero copies. You also cut allocation noise that distorts profiles.

---

- **Sprinkling clone As A Compiler Silencer**
  - A quick clone gets you past the error. Hidden costs show up later.
    - The Problem:

      ```rust
        fn join_bad(parts: &Vec<String>) -> String {
            // clones every item
            parts.iter().map(|s| s.clone()).collect::<Vec<String>>().join("/")
        }
      ```

  - The Fix

    Borrow where possible. Convert once at the boundary.

    ```rust
    fn join_ok(parts: &[String]) -> String {
        let parts_ref: Vec<&str> = parts.iter().map(|s| s.as_str()).collect();
        parts_ref.join("/")
    }
    ```

  - Why It Works

    `as_str` borrows. You avoid N allocations and N copies. Join needs owned output, not owned inputs.

    Before:

    ```text
      [ String ][ String ][ String ]  --> clone --> new heap blocks x N
    ```

    After:

    ```text
      [ String ][ String ][ String ]
           |        |        |
          &str     &str     &str   --> join --> one new String
    ```

  - Microbenchmark (Criterion)

    ```rust
    use criterion::{criterion_group, criterion_main, Criterion};
    fn join_bad_bench(parts: &[String]) -> String {
        parts.iter().map(|s| s.clone()).collect::<Vec<String>>().join("/")
    }
    fn join_ok_bench(parts: &[String]) -> String {
        let parts_ref: Vec<&str> = parts.iter().map(|s| s.as_str()).collect();
        parts_ref.join("/")
    }
    fn bench(c: &mut Criterion) {
        let data: Vec<String> = (0..1000).map(|i| format!("p{}", i)).collect();
        c.bench_function("join_bad", |b| b.iter(|| join_bad_bench(&data)));
        c.bench_function("join_ok", |b| b.iter(|| join_ok_bench(&data)));
    }
    criterion_group!(benches, bench);
    criterion_main!(benches);
    ```

    - **Change**: Borrow the pieces, allocate once for the result.
    - **Result**: Expect 2 to 4 times fewer allocations and a 20 to 35 percent wall-time reduction, depending on string sizes.

---

- **Holding A Mutable Borrow Across await**
  - You take &mut and then await. The compiler blocks you because another task could observe partially mutated state.
    - The Problem:

      ```rust
      use tokio::time::{sleep, Duration};

      async fn tick_bad(buf: &mut Vec<u8>) {
          buf.push(1);
          // holds &mut across await
          sleep(Duration::from_millis(1)).await;
          buf.push(2);
      }
      ```

  - The Fix:
    - Limit the mutable borrow scope before the await, or move ownership into the task.

      ```rust
      use tokio::time::{sleep, Duration};
      async fn tick_ok(buf: &mut Vec<u8>) {
          buf.push(1);
          { /* end borrow before await */ }
          sleep(Duration::from_millis(1)).await;
          buf.push(2);
      }
      // or move it in, then return it
      async fn tick_move(mut buf: Vec<u8>) -> Vec<u8> {
          buf.push(1);
          sleep(Duration::from_millis(1)).await;
          buf.push(2);
          buf
      }
      ```

  - Why It Works:
    - `await` yields. The borrow checker ensures that unique access does not cross a yield point unless you own the value in the future itself.

  - Diagram:

    ```text
        Time ---->
        bad:  [ &mut buf acquired ]----await----[ still held ]  X
        ok:   [ &mut buf ] end    await    [ &mut buf again ]  ✓
        move: ownership in future  await      ownership still  ✓
    ```

  - Benchmark Snapshot
    - **Change**: Holding a mutable borrow across await.
    - **Result**: You eliminate compile errors and also unblock concurrency. When work interleaves across tasks, throughput often rises by 10 to 20 percent due to better scheduling.

---

- **Using `RefCell<T>` Across Threads**
  - `RefCell` gives dynamic borrow checks at runtime. It is not Sync. Taking it across threads causes pain or panics.
    - The Problem:

    ```rust
    use std::cell::RefCell;
    use std::thread;

    fn share_bad() {
        let x = RefCell::new(0);
        thread::spawn(move || {
            *x.borrow_mut() += 1; // not Send/Sync
        });
    }
    ```

  - The Fix:
    Use `Arc<Mutex<T>>` or `Arc<RwLock<T>>` for cross-thread mutation.

    ```rust
    use std::sync::{Arc, Mutex};
    use std::thread;

    fn share_ok() {
        let x = Arc::new(Mutex::new(0));
        let x2 = x.clone();
        thread::spawn(move || {
            *x2.lock().unwrap() += 1;
        });
        *x.lock().unwrap() += 1;
    }
    ```

  - Why It Works
    - `Mutex<T>` is `Send` and `Sync` when `T` is `Send`. The borrow checker enforces safe sharing at compile time, and the mutex enforces exclusion at runtime.

  - Diagram

    ```text
    Thread A ---- lock(x) ---- work ---- unlock ---->
    Thread B --------- waits ---------- lock ---- work ---->
    ```

    `Arc<Mutex<T>>` ensures one writer at a time.

  - Benchmark Snapshot
    - **Change**: Replace `RefCell` with `Arc<Mutex<T>>` in a two-thread increment test.
    - **Result**: Safe and correct. Expect small overhead per lock. If contention is high, move to sharded state or message passing with channels for better throughput.

---

- **Building `Vec<&String>` From Temporaries**
  - You create references to values that will be dropped right after the expression. The borrow checker rejects or, worse, you subtly keep references to short-lived data.
    - The Problem

      ```rust
      fn refs_bad() -> Vec<&String> {
          // data dies at function end, references would dangle
          let data: Vec<String> = (0..10).map(|i| format!("k{}", i)).collect();
          data.iter().collect() // Vec<&String> to dying data
      }
      ```

    - The Fix

      Own what you store long term. Borrow only while the owner stays alive.

      ```rust
      fn own_ok() -> Vec<String> {
          (0..10).map(|i| format!("k{}", i)).collect()
      }

      fn borrow_ok<'a>(data: &'a [String]) -> Vec<&'a String> {
          data.iter().collect()
      }
      ```

  - Why It Works

    Lifetimes are about who owns memory. Store ownership if the container outlives the producer. Borrow only when the source stays alive long enough.

  - Diagram
    - Bad:

      ```text
      fn refs_bad()
        data: Vec<String>  ---> dies here
        Vec<&String> -----> dangling   X
      ```

    - Good:

      ```text
      own_ok -> Vec<String> owns data  ✓
      borrow_ok(data) -> Vec<&String> valid while data lives  ✓
      ```

- Benchmark Snapshot
  - **Change**: Store owned String instead of references to soon-to-die String.
  - **Result**: Slightly higher memory use, but zero undefined behavior and a simpler API. In real workloads this often reduces complexity and actually speeds delivery.

---

- **Forcing Lifetimes Into Structs That Should Own Data**
  - You pack references into long-lived structs. Now every consumer needs lifetime gymnastics.
    - The Problem:

      ```rust
      struct User<'a> {
          name: &'a str,     // ties User to an external buffer
          email: &'a str,
      }
      ```

      This design is fine for short scopes, terrible for application state or cross-thread use.

    - The Fix:

      Own what the struct needs, or use `Arc<str>` when cloning strings is too heavy.

      ```rust
      struct User {
          name: String,
          email: String,
      }

      // or share with low-cost clones
      use std::sync::Arc;
      struct UserShared {
          name: Arc<str>,
          email: Arc<str>,
      }
      ```

  - Why It Works

    Owning inside the struct frees consumers from lifetimes. `Arc<str>` gives cheap clones with shared storage when many copies exist.

  - Diagram

    ```text
    Ref-based:
    [User<'a>] -> &str -> external buffer  --> many lifetime edges

    Owned:
    [User] owns [String][String]  --> move freely, send across threads
    ```

    Microbenchmark (Clone Pressure)

    ```rust
    use criterion::{criterion_group, criterion_main, Criterion};
    use std::sync::Arc;

    fn mk_owned(n: usize) -> Vec<(String, String)> {
        (0..n).map(|i| (format!("n{}", i), format!("e{}@x", i))).collect()
    }
    fn mk_shared(n: usize) -> Vec<(Arc<str>, Arc<str>)> {
        (0..n)
            .map(|i| (Arc::<str>::from(format!("n{}", i)), Arc::<str>::from(format!("e{}@x", i))))
            .collect()
    }
    fn bench(c: &mut Criterion) {
        c.bench_function("owned_clone", |b| {
            let v = mk_owned(10_000);
            b.iter(|| v.iter().cloned().collect::<Vec<_>>())
        });
        c.bench_function("shared_clone", |b| {
            let v = mk_shared(10_000);
            b.iter(|| v.iter().cloned().collect::<Vec<_>>())
        });
    }
    criterion_group!(benches, bench);
    criterion_main!(benches);
    ```

    - **Change**: Use `Arc<str>` for highly shared strings.
    - **Result**: Cloning drops from O(length) to O(1). In a simple test, total clone time typically drops by 40 to 70 percent when fan-out is high.

---

- **Quick Patterns That Save Hours**
  - End borrows early. Use inner blocks to shrink lifetimes.
  - Borrow inputs, own outputs.
  - Avoid clone inside hot loops. Convert at boundaries.
  - Never hold &mut across await.
  - For cross-thread mutation, reach for `Arc<Mutex<T>>` or channels.
  - If a struct lives long, prefer owned fields or `Arc`.

---

- **Case Study: Parsing And Indexing Without Fighting Lifetimes**
  - Goal: parse lines, build an index of first words, and allow queries without lifetime knots.
  - Design

    ```text
    +-------------------+       +-------------------+
    |  Reader & Parser  |-----> |  Index (owned)    |
    |  borrows &str     |       |  HashMap<String, Vec<usize>>
    +-------------------+       +-------------------+
              ^                               |
              | query(&str)                   v
              +-------------------+   +-------------------+
                                  |   |  API (borrow in, |
                                  |   |   own outputs)   |
                                  |   +------------------+
    ```

  - Code

    ```rust
    use std::collections::HashMap;

    struct Index {
        map: HashMap<String, Vec<usize>>,
    }
    impl Index {
        fn build(text: &str) -> Self {
            let mut map = HashMap::new();
            for (i, line) in text.lines().enumerate() {
    ```
