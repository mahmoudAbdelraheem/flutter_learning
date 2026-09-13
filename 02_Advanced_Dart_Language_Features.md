# 📘 Summary: Advanced Dart Language Features (Phase 2)

> Generics → Sealed Classes → Records → Pattern Matching

---

## 1️⃣ Generics

### The Problem They Solve

Without generics, you'd duplicate the same class for every type:

```dart
class IntBox { final int value; IntBox(this.value); }
class StringBox { final String value; StringBox(this.value); }
```

### The Solution

```dart
class Box<T> {
  final T value;
  Box(this.value);
}

final intBox = Box<int>(5);
final userBox = Box<User>(User(name: 'Ahmed'));
```

`T` is a placeholder for any type, resolved at usage time — fully type-safe (the compiler rejects mismatched types at compile time, not runtime).

### Real-World Use: `Repository<T>` Pattern

```dart
abstract class Repository<T> {
  Future<T> getById(String id);
  Future<List<T>> getAll();
  Future<void> save(T item);
}
```

One shared contract instead of a separate interface per model.

### Generic Methods

```dart
T firstWhereOrDefault<T>(List<T> list, bool Function(T) test, T defaultValue) {
  for (final item in list) {
    if (test(item)) return item;
  }
  return defaultValue;
}
```

### Type Constraints (`extends`)

```dart
class AnimalShelter<T extends Animal> {
  final List<T> animals = [];
}
// AnimalShelter<Dog> ✅   AnimalShelter<String> ❌ compile error
```

### Generics + Freezed (`ApiResponse<T>`)

A generic Freezed wrapper for API responses is a common and correct pattern:

```dart
@Freezed(genericArgumentFactories: true)
class ApiResponse<T> with _$ApiResponse<T> {
  const factory ApiResponse({required T data}) = _ApiResponse<T>;

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) => _$ApiResponseFromJson(json, fromJsonT);
}
```

**Why plain `fromJson` fails on a generic Freezed class:** the generator can't know how to deserialize `T` — it effectively tries `json as T`, which fails at runtime for custom classes (e.g. `Map<String, dynamic> is not a subtype of User`). Adding `@Freezed(genericArgumentFactories: true)` plus a `fromJsonT` callback tells the generator exactly how to convert `T`, instead of guessing.

**Practical note:** if your repositories convert the server JSON directly into the real model (`User.fromJson(json)`) and only wrap it manually afterward (`ApiResponse.success(user)`), you may never need `fromJson` on `ApiResponse<T>` at all — it's just an internal state wrapper, not something deserialized directly from JSON.

---

## 2️⃣ Sealed Classes

### The Problem

A plain enum/flag-based state loses the connection between "status" and "which fields are actually available":

```dart
class ApiState {
  final ApiStatus status;
  final User? data; // nullable, compiler can't guarantee it's set when status == success
}
```

### The Solution

```dart
sealed class ApiState<T> {}
class Loading<T> extends ApiState<T> {}
class Success<T> extends ApiState<T> {
  final T data;
  Success(this.data);
}
class Error<T> extends ApiState<T> {
  final String message;
  Error(this.message);
}
```

```dart
switch (state) {
  Loading() => CircularProgressIndicator(),
  Success(data: final user) => Text(user.name), // no `!`, guaranteed non-null
  Error(message: final msg) => Text('Error: $msg'),
};
```

### Why `sealed` (not just `abstract`)

- `abstract class` allows anyone, anywhere, to add a new subclass — old `switch` statements won't know about it and won't warn you.
- `sealed class` forces all subclasses to live in the **same file**. This lets the compiler know every possible case, enabling **exhaustiveness checking**: if you forget a case in a `switch`, it's a **compile-time error**, not a runtime crash.

### `base` / `interface` / `final` (quick reference)

| Modifier    | Meaning                                                                 |
| ----------- | ----------------------------------------------------------------------- |
| `sealed`    | subclasses must live in the same file; can't be instantiated directly   |
| `final`     | can't be extended or implemented outside the file at all                |
| `base`      | can be extended but not implemented (preserves internal implementation) |
| `interface` | can be implemented but not extended (pure contract)                     |

In everyday app code, `sealed` covers ~95% of use cases (API states, Result types, Failures). The others matter more when designing packages/libraries.

### Freezed States Are Built on This Principle

```dart
@freezed
class UserState with _$UserState {
  const factory UserState.loading() = _Loading;
  const factory UserState.success(User user) = _Success;
  const factory UserState.error(String message) = _Error;
}
```

`when` / `maybeWhen` / `map` / `maybeMap` are Freezed-generated **methods** built on the same sealed-class exhaustiveness principle — `when` (without `maybe`) forces you to handle every case, and missing one is a **compile-time error**, exactly like `switch`. `maybeWhen`/`maybeMap` are the deliberate escape hatch that let you skip cases via `orElse`.

---

## 3️⃣ Records

**Added in Dart 3.0 (May 2023)**, alongside Patterns, Sealed Classes, and Switch Expressions — designed as one cohesive system.

### What a Record Is

A built-in, type-safe way to bundle multiple values together without creating a class:

```dart
var point = (5, 10);       // Positional Record, type (int, int)
print(point.$1);            // 5
print(point.$2);            // 10
```

- Parentheses `( )` define a Record (not `[ ]` or `{ }`)
- Positional fields are accessed via `$1`, `$2`, `$3`... in declared order

### Named Records

```dart
({int min, int max}) getMinMax(List<int> numbers) {
  // ...
  return (min: min, max: max);
}

final result = getMinMax([5, 2, 8, 1, 9]);
print(result.min); // by name, not $1
```

**Important rule:** `$1`/`$2` indices only exist for **positional** fields. Named fields have **no** `$` index at all — access is by name only, even in mixed records:

```dart
(String, {int age}) userInfo = ('Sara', age: 28);
print(userInfo.$1);   // ✅ 'Sara'
print(userInfo.age);  // ✅ 28
print(userInfo.$2);   // ❌ Error — no positional index for the named field
```

### Destructuring

```dart
final (min, max) = getMinMax([5, 2, 8, 1, 9]); // clearer than .$1/.$2
```

### Records in Collections

```dart
List<(String, int)> students = [('Ahmed', 25), ('Sara', 22)];
for (final (name, age) in students) {
  print('$name is $age years old');
}
```

### When to Use a Record vs a Class

| Use a **Record** when...                          | Use a **Class/Freezed** when...                                       |
| ------------------------------------------------- | --------------------------------------------------------------------- |
| Value is temporary, local, used in one place only | The data is a real domain concept (Entity/Model) passed across layers |
| No behavior/methods needed on it                  | Needs methods or extra logic                                          |
| Small number of clearly-meaningful values (2–3)   | Needs serialization (`fromJson`/`toJson`)                             |
| Don't need complex immutability or `copyWith`     | Needs `copyWith`, `==`, `hashCode` out of the box (Freezed)           |

---

## 4️⃣ Pattern Matching

### Destructuring (Lists & Maps)

```dart
final [head, ...rest] = [1, 2, 3, 4, 5]; // head = 1, rest = [2, 3, 4, 5]

final json = {'name': 'Ahmed', 'age': 25};
final {'name': name, 'age': age} = json;
```

### Object Patterns

Matches **and** extracts values from an object in one step:

```dart
switch (point) {
  case Point(x: 0, y: 0): print('Origin');
  case Point(x: 0, y: final y): print('On Y-axis at $y');
  case Point(x: final x, y: final y): print('Point at ($x, $y)');
}
```

### Object Patterns with Sealed Classes

```dart
switch (state) {
  Loading() => 'Loading...',
  Success(data: final user) => 'Hello ${user.name}',
  Error(statusCode: 401) => 'Unauthorized, please login again', // specific value match
  Error(message: final msg) => 'Error: $msg',                    // general fallback
};
```

### Guard Clauses (`when`)

An extra condition checked **after** the pattern matches:

```dart
switch (age) {
  int n when n < 0 => 'Invalid age',
  int n when n < 18 => 'Minor',
  int n when n < 65 => 'Adult',
  int n => 'Senior',
};
```

---

## ⚠️ Critical Rule: Switch Evaluation Order (No Fall-through)

Dart's `switch` (both the classic statement and the modern expression) evaluates cases **top to bottom** and stops at the **first case that fully matches** — pattern matched **and** guard (if any) returns `true`. It does **not** try every case and combine results.

### The Common Mistake

```dart
switch (result) {
  Success(amount: final a) => 'Paid: $a',                       // ❌ too general, placed first
  Success(amount: final a) when a > 1000 => 'Big payment: $a',  // never reached!
  Failed(reason: final r) => 'Failed: $r',
};
```

For `Success(1500)`, this prints **only** `'Paid: 1500.0'`. The first case matches (any `Success`, no guard) and the switch stops immediately — the more specific case below it is never evaluated, even though its condition is also true.

### The Fix: Order From Most Specific → Most General

```dart
switch (result) {
  Success(amount: final a) when a > 1000 => 'Big payment: $a', // specific first
  Success(amount: final a) => 'Paid: $a',                       // general fallback
  Failed(reason: final r) => 'Failed: $r',
};
```

### Decision Table

| Situation                         | Result                                         |
| --------------------------------- | ---------------------------------------------- |
| Pattern matched + no guard        | ✅ Executes this case, stops immediately       |
| Pattern matched + guard → `true`  | ✅ Executes this case, stops immediately       |
| Pattern matched + guard → `false` | ❌ Skips this case entirely, moves to the next |
| Pattern doesn't match             | ❌ Skips this case, moves to the next          |

### Note for Developers Coming From C / Java / JavaScript

Those languages default to **fall-through**: once a case matches, execution continues into the next case(s) unless you explicitly `break`. Dart deliberately avoids this — the classic `switch` statement requires explicit `break`/`return`/`continue` per case, and the modern `switch` expression has no fall-through concept at all. This removes one of the most common historical sources of bugs (a forgotten `break`).

---

## ✅ Key Takeaways From Phase 2

1. Generics give you reusable, type-safe code — but generic Freezed models need `genericArgumentFactories: true` + a `fromJsonT` callback for JSON to work correctly.
2. `sealed` classes force all subclasses into one file, enabling compile-time exhaustiveness checks — this is what makes `switch`/`when` safe against forgotten states.
3. Records are a lightweight, type-safe way to return multiple values — best for short-lived, local data; use a Class/Freezed for real domain models.
4. `$1`/`$2` only apply to positional record fields; named fields are accessed by name only.
5. Pattern matching combines checking and extracting values in a single step, and pairs powerfully with guard clauses (`when`).
6. **`switch` stops at the first fully-matching case** — always order guarded/specific cases before general ones.

---

_Next in the roadmap: (Phase 3) → Memory Management → Flutter Internals & Rendering_
