# Chapter 1 — Introduction to Algorithms

**Topics:** Big O Notation · Linear Search · Binary Search

An **algorithm** is a set of instructions for solving a problem.
Many algorithms can solve the same problem, so we need a way to compare them and pick the better one. That's what Big O is for.

---

## Part 1: Big O Notation

### What does Big O measure?

Big O tells you **how the number of operations grows as the input grows**.

It does **not** measure time in seconds, because seconds depend on things that have nothing to do with the algorithm:

- A fast laptop runs the same code faster than an old phone.
- Different languages and compilers have different speeds.
- Other programs running at the same time slow things down.

The number of operations stays the same everywhere, so it's a fair way to compare algorithms.

> Example: searching a list of 100 items takes up to **100 operations** with linear search, whether you run it on a supercomputer or a cheap phone. The seconds change, the operations don't.

### Why this matters in programming

For small inputs, almost any algorithm feels fast. The difference shows up when the input gets big:

- An algorithm that needs `n` operations on 1,000,000 items → 1,000,000 operations.
- An algorithm that needs `log n` operations on the same input → about 20 operations.

So the real question is not _"how fast is my code right now?"_ but _"what happens to my code when the data gets 10x or 1000x bigger?"_
A good solution keeps the number of operations **growing slowly** as the data grows.

### Important rules

1. **Big O describes the worst case.** Linear search _might_ find the item on the first try, but we say it's `O(n)` because in the worst case it checks every item.
2. **Constants are dropped.** `O(2n)` and `O(n + 5)` are both just `O(n)`. What matters is the _shape_ of the growth, not the exact count.
3. **`log` means log base 2** in this book: `log₂ 8 = 3` because `2 × 2 × 2 = 8`. It answers: _"how many times can I cut n in half until I get to 1?"_

---

### Common Big O run times (fastest → slowest)

#### `O(1)` — Constant time

The number of operations **does not change**, no matter how big the input is.

```dart
int getFirst(List<int> list) => list[0]; // 1 operation for 10 items or 10 million
```

---

#### `O(log n)` — Logarithmic time

Each step **cuts the problem in half**. Doubling the input adds only **one** extra step.

```dart
// Binary search — see Part 3
```

---

#### `O(n)` — Linear time

Operations grow **at the same rate** as the input. 10x more data → 10x more operations.

```dart
int sum(List<int> list) {
  var total = 0;
  for (final x in list) {   // runs n times
    total += x;
  }
  return total;
}
```

---

#### `O(n log n)` — Log-linear time

Doing an `O(log n)` amount of work for each of the `n` items. This is the speed of **good sorting algorithms** like Quicksort (Chapter 4) and Merge Sort.

---

#### `O(n²)` — Quadratic time

A loop **inside** a loop over the same data. 10x more data → **100x** more operations.

```dart
void printAllPairs(List<int> list) {
  for (final a in list) {       // n times
    for (final b in list) {     // n times for each a
      print('$a, $b');
    }
  }
}
```

This is the speed of slow sorting algorithms like Selection Sort (Chapter 2).

---

#### `O(n!)` — Factorial time

Trying **every possible order** of the items. It becomes impossible very quickly.

- 5 cities → 120 routes
- 10 cities → 3,628,800 routes
- 20 cities → about 2.4 × 10¹⁸ routes

---

### Comparison table (number of operations)

| n         | O(1) | O(log n) | O(n)      | O(n log n)  | O(n²)             | O(n!)            |
| --------- | ---- | -------- | --------- | ----------- | ----------------- | ---------------- |
| 8         | 1    | 3        | 8         | 24          | 64                | 40,320           |
| 16        | 1    | 4        | 16        | 64          | 256               | ~2.1 × 10¹³      |
| 1,024     | 1    | 10       | 1,024     | 10,240      | 1,048,576         | too big to write |
| 1,000,000 | 1    | ~20      | 1,000,000 | ~20,000,000 | 1,000,000,000,000 | impossible       |

Notice how `O(log n)` barely moves, while `O(n²)` and `O(n!)` explode.

---

## Part 2: Linear (Simple) Search

### The idea

Start at the first item and check each item **one by one** until you find the target or reach the end.

```dart
int? linearSearch(List<int> list, int item) {
  for (var i = 0; i < list.length; i++) {
    if (list[i] == item) return i;
  }
  return null;
}
```

### Big O: `O(n)`

In the worst case (the item is last, or not in the list), you check **all `n` items**.

### Pros and cons

- ✅ Works on **any** list, sorted or not.
- ✅ Very simple.
- ❌ Slow for large lists.

---

## Part 3: Binary Search

### The idea

Think of a game: _"I'm thinking of a number between 1 and 100."_

- Guessing 1, 2, 3, 4... is linear search. It could take **100 guesses**.
- Guessing **50** first and hearing "too high" removes **half** the numbers at once. Then guess 25, then 37... You always need **7 guesses at most**.

Binary search does exactly that: it looks at the **middle** item and throws away the half that can't contain the target.

### Steps

1. Set `low` to the first index and `high` to the last index.
2. Find the middle: `mid = low + (high - low) ~/ 2`.
3. Compare `list[mid]` with the target:
   - **Equal** → found it, return `mid`.
   - **Bigger** than the target → the target must be on the left → `high = mid - 1`.
   - **Smaller** than the target → the target must be on the right → `low = mid + 1`.
4. Repeat while `low <= high`.
5. If `low > high`, the range is empty → the item is not in the list → return `null`.

### Walkthrough

Search for **13** in `[1, 3, 5, 7, 9, 11, 13, 15, 17, 19]`:

| Step | low | high | mid | list[mid] | Decision            |
| ---- | --- | ---- | --- | --------- | ------------------- |
| 1    | 0   | 9    | 4   | 9         | 9 < 13 → go right   |
| 2    | 5   | 9    | 7   | 15        | 15 > 13 → go left   |
| 3    | 5   | 6    | 5   | 11        | 11 < 13 → go right  |
| 4    | 6   | 6    | 6   | 13        | ✅ Found at index 6 |

Binary search: **4 steps**. Linear search would need **7 steps** to reach index 6.

### Why the list MUST be sorted

Binary search throws away half the list based on one comparison. That decision is only correct if **everything on the left is smaller and everything on the right is bigger**.

On an unsorted list, it gives wrong answers. Search for **1** in `[7, 2, 9, 1, 5]`:

| Step | low | high | mid | list[mid] | Decision                |
| ---- | --- | ---- | --- | --------- | ----------------------- |
| 1    | 0   | 4    | 2   | 9         | 9 > 1 → go left         |
| 2    | 0   | 1    | 0   | 7         | 7 > 1 → go left         |
| 3    | 0   | -1   | —   | —         | range empty → `null` ❌ |

But `1` **is** in the list, at index 3. Binary search threw away the right half, where the answer actually was.

### Why it's `O(log n)`

Every step cuts the remaining items in half:

```
1,000,000 → 500,000 → 250,000 → 125,000 → ... → 1
```

The number of halvings needed to get from `n` to 1 is `log₂ n`.
So **doubling the list size adds just one more step**.

### About `mid = low + (high - low) ~/ 2`

**`~/` (integer division):** `7 / 2` gives `3.5` (a double), while `7 ~/ 2` gives `3` (an int).
Indexes must be integers, so `~/` replaces `(x / 2).toInt()`.

**Why not `(low + high) ~/ 2`?**
In languages like Java, `int` can't go above `2,147,483,647`.
If `low = 1,500,000,000` and `high = 2,000,000,000`, then `low + high = 3,500,000,000`,
which is too big. The number "wraps around" and becomes **negative** (overflow),
so `mid` becomes a negative index and the program crashes.

`low + (high - low) ~/ 2` never adds the two big numbers together.
It starts at `low` and moves **half the distance** toward `high`,
so the result is always between `low` and `high` and can't overflow.

Both formulas give the same result mathematically; only the order of operations is different.

> In Dart, `int` is 64-bit on native platforms, so this isn't a real risk here.
> It's still a good habit and a famous interview question. This exact bug existed in
> Java's `Arrays.binarySearch` for years until it was reported in 2006.

### a nice hit from CLAUDE 😍

---

## Linear Search vs Binary Search

| Feature               | Linear Search           | Binary Search                           |
| --------------------- | ----------------------- | --------------------------------------- |
| How it works          | Checks items one by one | Checks the middle, halves the range     |
| Requires sorted list? | ❌ No                   | ✅ Yes                                  |
| Big O (worst case)    | `O(n)`                  | `O(log n)`                              |
| Best case             | 1 step (first item)     | 1 step (middle item)                    |
| Code complexity       | Very simple             | Simple, but easy to get off-by-one bugs |

### Worst-case steps

| List size     | Linear Search | Binary Search |
| ------------- | ------------- | ------------- |
| 100           | 100           | 7             |
| 10,000        | 10,000        | 14            |
| 1,000,000     | 1,000,000     | 20            |
| 4,000,000,000 | 4,000,000,000 | 32            |

(The first three rows match the output of `binary_search.dart`.)

### When to use which?

- **Binary search** → the data is already sorted and you search it many times.
- **Linear search** → the data is unsorted, small, or you only search once. Sorting first costs `O(n log n)`, which is more than a single `O(n)` search.

---

## Key Takeaways

- Big O measures **how the number of operations grows**, not seconds.
- Big O describes the **worst case**, and constants are dropped.
- Order from fastest to slowest: `O(1)` < `O(log n)` < `O(n)` < `O(n log n)` < `O(n²)` < `O(n!)`.
- Binary search is `O(log n)` and linear search is `O(n)`.
- Binary search **only works on sorted lists**.
- The bigger the data, the more the choice of algorithm matters.

## Code

👉 [binary_search.dart](./binary_search.dart)
