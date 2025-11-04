# Rust Traits From Into

Using the From and Into traits to convert between types.

## Definitions

### `From`

- 📦 What is `From`?

  The `From` trait is for infallible conversions — converting one type into another safely.

  Example:

  ```rust
  let s = String::from("hello");
  ```

  Here, `String::from(&str)` creates a new `String` from a string slice.

- ✅ When you implement `From<T>` for `U`, you're telling Rust:

  “I can always convert a `T` into a `U`, and it will never fail."

- 🛠️ Implementing `From` for Your Own Types

  Suppose you have a simple struct:

  ```rust
  struct UserId(u64);
  ```

  You can make it easy to create a `UserId` from a `u64`:

  ```rust
  impl From<u64> for UserId {
      fn from(id: u64) -> Self {
          UserId(id)
      }
  }
  ```

  Now:

  ```rust
  let id = UserId::from(42);
  ```

  - ✅ This creates a clean and predictable conversion path.

### `Into`

- 🎯 What is `Into`?

  The `Into` trait is for fallible conversions — converting one type into another, possibly failing.
  If you can `From<T>` for `U`, then Rust automatically implements `Into<U>` for `T`.

  Example:

  ```rust
  let s: String = "hello".into();
  ```

  ✅ No need to manually implement `Into` — `Into` is automatically derived from `From`!

## Interactions

### 📌 Quick Summary

Implement `From` when you want to convert from one type to another.
Use `Into` when you want the caller to choose what to convert into.

- ✅ Tip: Always implement `From`, not Into, yourself.
  Rust will handle Into automatically!

### ⚡ Real-World Example: Converting Between `Struct`s

- Suppose you have:

  ```rust
  struct User {
      id: u64,
      name: String,
  }

  struct UserDto {
      id: u64,
      name: String,
  }
  ```

  You can implement a conversion easily:

  ```rust
  impl From<User> for UserDto {
      fn from(user: User) -> Self {
          UserDto {
              id: user.id,
              name: user.name,
          }
      }
  }
  ```

  Now you can transform users elegantly:

  ```rust
  let user = User { id: 1, name: "Alice".into() };
  let dto: UserDto = user.into();
  ```

  ✅ Clean, readable, and safe — no manual copying fields everywhere.

### 🛡️ From vs TryFrom

- If a conversion might fail, use `TryFrom` instead.

  Example: parsing integers from strings:

  ```rust
  use std::convert::TryFrom;

  struct PositiveNumber(u32);

  impl TryFrom<i32> for PositiveNumber {
      type Error = &'static str;
      fn try_from(value: i32) -> Result<Self, Self::Error> {
          if value >= 0 {
              Ok(PositiveNumber(value as u32))
          } else {
              Err("Negative numbers not allowed")
          }
      }
  }
  ```

  ✅ Use `TryFrom` when not every input can be safely converted.

## Reasoning

### 🧠 Why `From` and `Into` Are Powerful

- **Encapsulation**: You hide conversion details inside a `trait impl`.
- **Flexibility**: You can chain types cleanly without ugly constructors everywhere.
- **Ergonomics**: Using `.into()` in generic code makes APIs cleaner and easier to use.
- **Consistency**: Users of your types can predictably convert between types without surprises.

### 🎯 Where You’ll See From and Into in the Wild

- `String` conversions: `&str → String`
- Collections: `Vec<T> → Box<[T]>`
- Parsing: Raw types → strongly typed wrappers
- API responses: DTOs ↔ Domain models
- CLI argument parsing libraries (structopt, clap) rely on conversions heavily.

### 🧠 Key Takeaways

- **Implement** `From` — **not** `Into` — for your types.
- **Use** `Into` when calling code **needs** a flexible conversion.
- **Reach** for `TryFrom` when a conversion might fail.
- **Conversions make your APIs easier, safer, and cleaner** without sacrificing Rust’s strictness.
