# AMP (You, the agent)

## **Writing Style**

- Be **brief** and to the **point**.
- Do **NOT** regurgitate information that can easily be gleaned from the code, **EXCEPT** to **guide** the reader to where the code is located.
- **NEVER** use "This isn't..." or "not just..." constructions. State what something **IS** directly.
- **AVOID** defensive writing patterns like:
  - "This isn't X, it's Y" or "Not just X, but Y" → Just say "This is Y"
  - "Not just about X" → State the actual purpose
  - "We're not doing X, we're doing Y" → Just explain what you're doing
- **Any** variation of explaining what something **isn't** before what it **is**

## Workflow

- **NEVER** just start writing code without asking the user for feedback and receiving a **go ahead** / **okay** / **yes** / **proceed** response.
- Always **ASK** the user: `Let's begin with what? Do you want to follow the **PRD**(_Product Requirement Document_) workflow?
- If **so**, proceed the following steps:
  1. Read the [`Create PRD`](./prd/create_prd.md) and follow it's instructions **without** deviating.
  2. Upon completing every step of the PRD creation process, ask the user if we should proceed to the task generation, step.
  3. The task generation process is the same as the one described in the [Task Generation](./prd/generate-tasks.md) document.
  4. There you'll find a step-by-step guide on how to generate a task list from a PRD. That **must** be followed to the teeth.
  5. If there are any questions or uncertainties, ask the user for clarification.
- If **not**, ask the user how to proceed with the conversation, what's the next step, and what to do next.

## **Specs** (Concepts, language specific styles and conventions)

- When working with an specific language we'll always look for the concepts for that language before resourcing to the web.
  - Concepts are always available in the `specs` folder of the agent, under the `./specs/lang/{language}/concepts/` folder, in example:
    - When looking for rust concepts we'll look for the concepts in the `./specs/lang/rust/concepts/` folder.
    - There you'll find conventions for different concepts of the language.
    - Sometimes some concepts will link to other concepts, like:
      - [`Rust Traits`](./specs/lang/rust/concepts/rust_traits.md), links to:
        - [`Rust Traits Advanced`](./specs/lang/rust/concepts/rust_traits_advanced.md)
        - [`Rust Traits Basic`](./specs/lang/rust/concepts/rust_traits_basic.md)
        - [`Rust Traits From Into`](./specs/lang/rust/concepts/rust_traits_from_into.md)
        - [`Rust Traits Getters`](./specs/lang/rust/concepts/rust_traits_getters.md)
        - [`Rust Traits Setters`](./specs/lang/rust/concepts/rust_traits_setters.md)
