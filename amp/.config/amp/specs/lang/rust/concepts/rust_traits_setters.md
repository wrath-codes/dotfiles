# Rust Traits Setters

- [Introduction](#introduction)
- [Guidelines](#guidelines)
<!--toc:end-->

🦀 Rust Tip: Setter Methods in Traits — Power, Pitfalls, and Patterns

## Introduction

Setter methods are sometimes frowned upon in Rust, but they can be useful and idiomatic when applied in the right context.
The guidelines explain when setter methods in traits make sense, and how to use them without violating Rust’s principles of ownership, mutability, and clarity.

## Guidelines

- 🧱 **What Is a Setter in a Trait?**

  A setter is a method that updates internal state. In traits, it’s used to enforce a contract: > "Any type implementing this trait must be able to set this value."

  Here’s a basic setter in a trait:

  ```rust
  trait HasName {
      fn set_name(&mut self, name: String);
  }
  ```

  It says: > "you must let others change the name".

- 🤔 **Why Use a Setter in a Trait?**
  - While Rust favors immutable, minimal, predictable code, there are valid reasons to expose a setter:
    - When defining a **mutable interface** across many types
    - When working with **builder patterns**
    - In **test mocks or simulators** where internal state changes
    - In **UI/state management systems**
    - For **configuration objects** that need to be modified dynamically

  - 💡 Example:
    - A Configurable Plugin
      Let’s say you’re building a plugin system, and each plugin can be given a runtime config:

      ```rust
      trait Configurable {
          fn set_config(&mut self, key: &str, value: String);
      }
      ```

      Now every plugin can receive dynamic updates:

      ```rust
      plugin.set_config("log_level", "debug".to_string());
      ```

- ⚠️ **Pitfalls of Setters**
  - ❌ **1. Overusing Setters = OOP Trap**

    Blindly copying OOP-style setter/getter pairs just for “symmetry” isn’t idiomatic in Rust. Rust prefers exposing simple structs, and often it’s fine to mutate fields directly within the module.

    ```rust
    pub struct User {
        pub name: String,
    }
    ```

    This is fine when the struct is internal or tightly scoped.

  - ❌ **2. Risk of Breaking Invariants**

    Setters can expose too much power. If setting a field requires validation, you need to enforce it in the setter:

    ```rust
    trait AgeAware {
        fn set_age(&mut self, age: u8);
    }

    impl AgeAware for Person {
        fn set_age(&mut self, age: u8) {
            if age > 150 {
                panic!("Unrealistic age");
            }
            self.age = age;
        }
    }
    ```

- ✅ **A Better Pattern: Fluent Setters**

  Instead of void-style setters (`fn set_x(&mut self, val)`), consider fluent ones that return `Self`:

  ```rust
  trait WithConfig {
      fn with_config(self, config: Config) -> Self;
  }
  ```

  This enables chaining and is often more idiomatic in builders:

  ```rust
  let plugin = Plugin::new().with_config(my_config).with_log_level("debug");
  ```

- ✨ **Use Case: Traits in UI Models**

  UI state in Rust (e.g., with egui, dioxus, or yew) often requires reactive state mutation. Traits with setters let components interact uniformly:

  ```rust
  trait Selectable {
      fn set_selected(&mut self, selected: bool);
      fn is_selected(&self) -> bool;
  }
  ```

  Now you can build generic UI widgets that work with anything that implements Selectable.

- 🧪 **Another Use Case: Testable Abstractions**

  If you’re mocking a service or behavior for testing, setters in traits can help set up internal state without leaking internals:

  ```rust
  trait FakeableClock {
      fn set_time(&mut self, time: DateTime<Utc>);
      fn now(&self) -> DateTime<Utc>;
  }
  ```

  This lets you swap out `SystemClock` for `MockClock` in tests.

- 🔐 **Alternative: Builder `Struct`s or `Commands`**

  If you want to avoid mutation in traits, use builder structs or command traits:

  ```rust
  trait Command {
      fn execute(&mut self);
  }
  ```

  Or encapsulate all changes in one method:

  ```rust
  trait Configurable {
      fn configure(&mut self, settings: Config);
  }
  ```

  This limits surface area and keeps things clean.

- 🧼 **Summary: Should You Use Setters in Traits?**
  - ✅ **Yes**, when:
    - You’re designing a mutable API or UI abstraction
    - You want to enable testability or dynamic configuration
    - You’re implementing builder-like patterns
    - The trait expresses “stateful capability”, not just identity

  - ❌ **Avoid** when:
    - You’re just duplicating field access
    - You’re breaking invariants without validation
    - The trait becomes a “god trait” with too many knobs

- 💬 **Final Thoughts**

  Setter methods in traits are not inherently unidiomatic — but they should be used with intent and care. Think of them as a tool for cases where controlled mutability improves clarity and composability.

  As with everything in Rust: lean into ownership, borrowing, and minimal public APIs, but don’t shy away from setters when your domain needs them.
