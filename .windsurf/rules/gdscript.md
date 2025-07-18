---
trigger: glob
globs: *.gd
---

## **GDScript Code Standards and Best Practices**

### **1. Enforce Static Typing**

- All variables **must have a type known at compile-time**.
- Variables or parameters **must never be dynamically typed** under any circumstances.
- Function parameters must **always** have explicitly declared types — even if it’s just `Variant`.
- This also applies when a default value implies the type — still declare it explicitly.
- All functions must declare their return type.
- Prefer `:=` for type inference, but:

  - If the type is unclear, **declare it explicitly**.
  - If the inferred type is `Variant`, use an explicit `Variant` declaration instead.

- When using methods (engine or custom), check their return type:

  - If it returns `Variant` and you're saving it to a variable, either:

    - Declare the variable as `Variant`, or
    - Cast it using `as`.

After writing the code:

- **Verify all variable types** match what you expect and what's actually returned by expressions.
- Handle `Variant` as described above.

---

### **2. Avoid Redundant Comments**

- Don’t write comments that are obvious from the code or function names.

---

### **3. Avoid Using Dictionary for Temporary State**

**Bad example:**

```gdscript
var state: Dictionary
state["some_var"] = 1
return state["some_var"] + 1
```

**Good example:**

```gdscript
class MyState extends RefCounted:
    var some_var: int = 1

# Usage
state.some_var = 1
return state.some_var + 1
```

---

### **4. Method Validity & Overriding**

- Make sure all methods you use **actually exist**.

  - If they don’t, either:

    - Use existing ones, or
    - **Implement the functionality yourself** (e.g., a private helper).

- When overriding methods (including engine ones), make sure their **signature matches** the parent method exactly.

---

### **5. Code Quality Checks**

- After writing code:

  - Fix all **compilation/linter errors**.
  - If there’s an error you can’t fix, **note it explicitly** and explain.

- Watch out for:

  - **Incorrect override signatures**
  - Return values not matching declared types
  - Common linter issues
  - `weakref()` returns `WeakRef`; `get_ref()` might return `null`

---

### **6. Avoid Unintentional Method Name Collisions**

- Ensure your custom method names don’t unintentionally override methods from:

  - Parent classes (direct or inherited).

- If intentional, ensure the **signature is correct**.

---

### **7. GDScript Notes**

- `weakref()` uses `Variant` as both input and output. Still:

  - Cast to `WeakRef` with `as`, or
  - Declare variable type explicitly.

---

### **8. Function Signature Formatting**

**Bad:**

```gdscript
func my_long_func(param1: Type, param2: Type, param3: Type) -> void:
```

**Good:**

```gdscript
func my_long_func(
    param1: Type,
    param2: Type,
    param3: Type,
) -> void:
```

- Same applies to function calls — if too long, **place each parameter on a new line**.

---

### **9. Trailing Commas**

Use trailing commas:

- In multiline `enum` declarations
- In multiline function signatures
- In multiline function calls

---

### **10. Boolean Expressions**

Use **C-style operators**:

- Allowed: `&&`, `||`, `!`
- Not allowed: `and`, `or`, `not`

---

### **11. Spacing Between Functions**

Use **two blank lines** between functions:

```gdscript
func f1() -> void:
    pass


func f2() -> void:
    pass
```

---

### **12. Don't Comment on Rules Already Described**

- No need to comment on code rules already covered in this guideline.

---

### **13. Linter Issues with New/Renamed Classes**

- If you get a linter error about a non-existent class after renaming or adding one:

  - It’s due to the engine not loading class info quickly enough.
  - **You don’t need to fix it** — just let me know, and I’ll resolve it on my end by refreshing the engine state.

---

### **14. Godot Collection Typing Warning**

- **Do not use collection typing** like `Array[MyScript]` or `Dictionary[MyScript, bool]` if the function **will be used outside the main thread**.
- It may call `get_script()` internally and cause errors.
- In such cases, **omit typing** and add a comment explaining why.

---

### **15. NEVER Mock Data**

- **NEVER** create example scripts/scenes, or readme files of any sort, to explain what you've done. This includes never using mock data in production code. Code you write should explain itself, and any configuration nuances you should tell explicitly in the chat.
