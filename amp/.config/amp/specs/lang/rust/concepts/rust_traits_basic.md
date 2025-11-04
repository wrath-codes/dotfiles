# Rust Traits Basic

Using traits to define shared behavior in Rust.

## Definitions

### Traits

- 💡 So, What Is a Trait?

  Traits are the equivalent of interfaces.
  But traits offer **explicitness, generics, static dispatch, dynamic dispatch**, and **even zero-cost abstractions**.
  A trait in Rust defines shared behavior that types can implement.

#### The Problem: Trait Objects as Return Types

- **all return values must ultimately resolve to the same concrete type**, even when the return type is declared as a trait.

  You might be tempted to write a function like this:

  ```rust
  trait Animal {
      fn speak(&self) -> String;
  }

  fn get_animal(kind: &str) -> dyn Animal {
      if kind == "dog" {
          Dog {}
      } else {
          Cat {}
      }
  }
  ```

  But this won’t compile. Why? Because Rust needs to know the exact size of the return type at compile time, and `dyn Animal` is a trait object, which is unsized. Instead, you need to return a pointer type like `Box<dyn Animal>`:

  ```rust
  fn get_animal(kind: &str) -> Box<dyn Animal> {
      if kind == "dog" {
          Box::new(Dog {})
      } else {
          Box::new(Cat {})
      }
  }
  ```

  Now we’re good! Both `Box::new(Dog {})` and `Box::new(Cat {})` return a value of the same concrete type: `Box<dyn Animal>`.
  But Wait: Same Trait, Different Types?

  Here’s a subtle, but important point: even though Dog and Cat both implement the Animal trait, you cannot return them directly without boxing (or another pointer indirection) because they are different types.

  ```rust
  fn get_animal(kind: &str) -> impl Animal {
      if kind == "dog" {
          Dog {}
      } else {
          Cat {}
      }
  }
  ```

  The above won’t compile, because `impl Trait` means “a single, specific concrete type that implements this trait,” and Dog and Cat are different types. So even though both implement Animal, Rust sees this as inconsistent.

  ✅ If you use `impl Trait`, all branches must return the same type.

  So this would work:

  ```rust
  fn get_animal(kind: &str) -> impl Animal {
      Dog {} // always returns a Dog
  }
  ```

  And this wouldn’t:

  ```rust
  fn get_animal(kind: &str) -> impl Animal {
      if kind == "dog" {
          Dog {}
      } else {
          Cat {}
      }
  }
  ```

  **Recap**: Three Ways to Return Traits

  | Pattern                      | Type             | Concrete Type                           | Required? | Notes                         |
  | ---------------------------- | ---------------- | --------------------------------------- | --------- | ----------------------------- |
  | `fn foo() -> T`              | `T`              | Concrete Type                           | Yes       | Most basic case               |
  | `fn foo() -> impl Trait`     | `impl Trait`     | One concrete type that implements Trait | Yes       | Can’t return different types  |
  | `fn foo() -> Box<dyn Trait>` | `Box<dyn Trait>` | Trait object                            | No        | Good for dynamic polymorphism |

  🎯 **When to Use What?**

  Use `impl Trait` when your function always returns the same concrete type, and you want to hide the actual type.
