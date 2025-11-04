# Rust Traits Advanced

Dynamic Dispatch, Trait Objects, and Advanced Patterns

## Guidelines

### 🎭 Static vs Dynamic Dispatch

- ✅ Static Dispatch

  When you use generics with trait bounds (like fn foo<T: Trait>(arg: T)), Rust knows the type at compile time and inlines the method calls. This is fast and zero-cost.

- 🔄 Dynamic Dispatch

  When you use trait objects (like &dyn Trait), Rust doesn’t know the concrete type at compile time. Instead, it uses a vtable — a runtime lookup table — to call the correct method. This adds a tiny runtime cost, but gives you more flexibility.

### 🎭 Enter: Trait Objects

- Trait objects let you group different types under a common interface.

  ```rust
  trait Drawable {
      fn draw(&self);
  }

  struct Circle;

  struct Square;

  impl Drawable for Circle {
      fn draw(&self) {
          println!("Drawing a circle");
      }
  }

  impl Drawable for Square {
      fn draw(&self) {
          println!("Drawing a square");
      }
  }
  ```

- Now you can store both in a collection:

  ```rust
  fn render_scene(objects: Vec<&dyn Drawable>) {
      for obj in objects {
          obj.draw();
      }
  }

  fn main() {
      let circle = Circle;
      let square = Square;
      render_scene(vec![&circle, &square]);
  }
  ```

- This is polymorphism without inheritance!

### 🧩 Boxed Trait Objects

- Sometimes you want to own the trait object — for instance, if your collection is Vec<Box<dyn Drawable>> instead of just references.

  ```rust
  fn render_owned_scene(objects: Vec<Box<dyn Drawable>>) {
      for obj in objects {
          obj.draw();
      }
  }
  ```

- Why Box? Because trait objects are unsized types (?Sized), and Rust needs a heap allocation to store them uniformly.

### 🧠 Trait Inheritance

- Traits can extend other traits, making it easy to compose behaviors.

  ```rust
  trait Named {
      fn name(&self) -> &str;
  }

  trait Describable: Named {
      fn describe(&self) -> String {
          format!("An entity named '{}'", self.name())
      }
  }

  struct Player {
      name: String,
  }

  impl Named for Player {
      fn name(&self) -> &str {
          &self.name
      }
  }

  impl Describable for Player {}
  ```

- Now, Player gets a default describe() based on name().

### 🧱 Step-by-Step Breakdown of the Example

- Define the Named Trait

  ```rust
  trait Named {
      fn name(&self) -> &str;
  }
  ```

- This trait says: “Any type that implements Named must provide a method name() that returns a &str.”

  Define the Describable Trait That Extends Named

  ```rust
  trait Describable: Named {
      fn describe(&self) -> String {
          format!("An entity named '{}'", self.name())
      }
  }
  ```

- Here’s what’s happening:

trait `Describable: Named` means: to implement `Describable`, you must also implement `Named`.
`describe()` is a default method that uses the `name()` method from `Named`.

- So, Describable depends on Named. It’s inheriting behavior in a loose sense.

  Define the Player Struct

  ```rust
  struct Player {
      name: String,
  }
  ```

- A basic struct with one field.

  Implement the Named Trait for Player

  ```rust
  impl Named for Player {
      fn name(&self) -> &str {
          &self.name
      }
  }
  ```

- Now Player satisfies the Named contract — it has a name() method.

  Implement the Describable Trait for Player

  ```rust
  impl Describable for Player {}
  ```

  Wait — this looks empty! That’s okay!

- Rust lets you implement a trait without redefining methods if the trait already provides default implementations. In this case, Describable has a default describe() method, so we get that for free.

### 🔍 The where Clause

- When your generic constraints get long or complex, where helps improve readability:

  ```rust
  fn debug_and_draw<T>(item: &T)
  where
      T: std::fmt::Debug + Drawable,
  {
      println!("{:?}", item);
      item.draw();
  }
  ```

- Cleaner, clearer — especially for functions with multiple trait bounds.

### 🎯 Associated Types vs Generics

- Traits can use associated types instead of generics to make type signatures easier.

  ```rust
  trait Iterator {
      type Item;

      fn next(&mut self) -> Option<Self::Item>;
  }
  ```

- This is why you use `impl Iterator<Item = i32>` in return types, instead of needing `Iterator<T>`.

### ⚙️ Super Advanced: Default Generic Params for Traits

- You can provide default types in traits (a less common but powerful trick):

  ```rust
  trait Logger<T = String> {
      fn log(&self, msg: T);
  }
  ```

- Now types can implement it with a default or override it for other types.

### ⚠️ Trait Object Gotchas

- Some important caveats with trait objects:
  - Only object-safe traits can be used as trait objects. That means:
  - No generic methods
  - No Self: Sized constraints
  - Trait objects are slower than static dispatch — don’t overuse them.
  - Trait objects don’t support methods with generic parameters.

### ✅ Summary

- Conclusion:
  - Use trait objects (`dyn Trait`) for runtime polymorphism.
  - Use static dispatch (generics) for performance.
  - Traits can extend each other to build modular behavior.
  - `Box<dyn Trait>` is used to own trait objects.
  - Use where clauses to make complex generics readable.
  - Learn the boundaries of object safety.
