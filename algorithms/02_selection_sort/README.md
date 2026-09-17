# Chapter 2 — Selection Sort

**Topics:** How Memory Works · Arrays · Linked Lists · Selection Sort

Before learning a sorting algorithm, we need to understand **how data is stored in memory**, because the way data is stored decides how fast we can read, insert, and delete it.

---

## Part 1: How Memory Works

Think of your computer's memory as a **giant set of drawers**. Each drawer:

- can hold **one item**, and
- has an **address** (like `fe0ffeeb`).

When you want to store something, the computer gives you a drawer and tells you its address.
When you want to store **many items**, there are two basic ways to do it: **arrays** and **linked lists**.

---

## Part 2: Arrays

### How they're stored

All items are stored **right next to each other** in memory (contiguous).

```
Address:  100   101   102   103
Value:  [ 10 ][ 20 ][ 30 ][ 40 ]
```

### Why reading is fast: `O(1)`

Since items are side by side, the computer can **calculate** the address of any item instantly:

```
address = start address + (index × item size)
```

To get item #3, it doesn't walk through items 0, 1, 2. It jumps straight there.
This is called **random access**.

### Why adding is a problem

Think of going to the cinema with friends and sitting **together**.
If another friend shows up and there's no free seat next to you, **everyone has to move** to a new row with enough seats.

Arrays work the same way: if there's no free space after the last item, the whole array must be **copied to a new place** in memory.

Reserving extra slots in advance (e.g. 10 slots for 3 items) helps, but:

- ❌ Unused slots **waste memory**.
- ❌ If you go past the reserved space, you **still have to move** everything.

### Inserting / deleting in the middle: `O(n)`

To keep items side by side:

- **Insert** in the middle → shift every item after it **one step right**.
- **Delete** from the middle → shift every item after it **one step left** to fill the gap.

In the worst case (the first position), you shift **all `n` items**.

```
Insert 15 at index 1:
[10][20][30][40]  →  [10][  ][20][30][40]  →  [10][15][20][30][40]
                          shift 3 items right
```

---

## Part 3: Linked Lists

### How they're stored

Items can be **anywhere** in memory. Each item (called a **node**) stores two things:

1. its **value**, and
2. the **address of the next node**.

```
[10 | next→] ──► [20 | next→] ──► [30 | next→] ──► [40 | null]
```

It's like a **treasure hunt**: each clue tells you where the next clue is.

### Why inserting and deleting is fast: `O(1)`

No shifting is needed. You only **change the pointers**.

```
Insert 15 after 10:
[10] ──► [20]     becomes     [10] ──► [15] ──► [20]
(change 2 pointers, nothing else moves)

Delete 20:
[10] ──► [20] ──► [30]     becomes     [10] ──► [30]
(change 1 pointer)
```

And adding new items never requires moving the whole list: any free drawer works.

### Why reading is slow: `O(n)`

You **can't jump** to item #3. You don't know its address until you read item #2, and you don't know #2 until you read #1...
You must start at the head and follow the links one by one. This is called **sequential access**.

---

## Part 4: Big O Comparison

|            | Array  | Linked List |
| ---------- | ------ | ----------- |
| **Read**   | `O(1)` | `O(n)`      |
| **Insert** | `O(n)` | `O(1)`      |
| **Delete** | `O(n)` | `O(1)`      |

### Why?

| Operation | Array                                             | Linked List                      |
| --------- | ------------------------------------------------- | -------------------------------- |
| Read      | Address is calculated directly → jump to it       | Must follow links from the start |
| Insert    | Must shift items (and maybe copy the whole array) | Just change pointers             |
| Delete    | Must shift items to fill the gap                  | Just change a pointer            |

> ⚠️ **Important note:** the linked list's `O(1)` insert/delete assumes you **already have** the node where the change happens (e.g. the head, or the tail if you keep a pointer to it).
> If you first need to **find** the position, finding it costs `O(n)`.

### Random access vs sequential access

- **Random access** → jump to any item directly (arrays).
- **Sequential access** → read items one after another (linked lists).

Many algorithms (like **binary search**) need random access, which is one reason **arrays are used more often**.

### When to use which?

| Use an **array** when...                    | Use a **linked list** when...                     |
| ------------------------------------------- | ------------------------------------------------- |
| You read items by index a lot               | You insert/delete a lot                           |
| You need random access (e.g. binary search) | You only go through items in order                |
| The size doesn't change much                | Items are added/removed at the start or end often |

Also, all items in an array must be the **same type** in the book's model (so the address calculation works).

### In Dart

- Dart's `List` is a **growable array**:
  - `list[i]` → `O(1)`
  - `list.add(x)` → `O(1)` on average (it reserves extra space and only occasionally copies everything)
  - `list.insert(0, x)` and `list.removeAt(i)` → `O(n)` (shifting)
- For queues (add at the back, remove from the front), use `Queue` from `dart:collection`. Both ends are `O(1)`.
- `dart:collection` also has a `LinkedList` class.

---

## Part 5: Exercises

### 2.1 — Expense tracker

**Situation:** you add expenses every day (many inserts) and read them all once a month (few reads).

**Answer: Linked list.**

- There are many more inserts than reads, and linked lists insert in `O(1)`.
- The reads are **not random**: you go through **every** expense in order to sum them. Linked lists are fine at that, since reading all items is `O(n)` for both structures anyway.

---

### 2.2 — Restaurant order queue

**Situation:** servers add orders to the **back**, chefs take orders from the **front**.

**Answer: Linked list.**

- Only two operations happen: insert at the back and delete from the front.
- A linked list does both in `O(1)` (keeping pointers to the head and tail).
- An array would have to **shift every order** after removing the first one → `O(n)`.
- No random access is needed: nobody asks for "order #57".

---

### 2.3 — Searching Facebook usernames

**Situation:** many logins → many searches, done with **binary search**.

**Answer: Array.**

- Binary search needs to jump to the **middle** instantly → it needs **random access**.
- Arrays give that in `O(1)`. With a linked list, reaching the middle alone is `O(n)`, which destroys the whole benefit of binary search.

---

### 2.4 — Downsides of inserting new users into an array

**Answer:**

- Binary search needs the array to stay **sorted**, so a new user can't simply go at the end. You must insert them at the **correct position** and **shift** every user after it → `O(n)`.
- If the array runs out of space, the **whole array must be copied** to a new, bigger place in memory.
- With millions of sign-ups, inserts become very slow.

---

### 2.5 — Hybrid: array of 26 linked lists (one per letter)

|               | vs **Array** | vs **Linked List** |
| ------------- | ------------ | ------------------ |
| **Searching** | 🐢 Slower    | 🚀 Faster          |
| **Inserting** | 🚀 Faster    | ⚖️ Same            |

**Why?**

- **Searching vs array:** a sorted array allows binary search (`O(log n)`). The hybrid jumps to the right letter instantly, but then has to walk through that letter's linked list one by one.
- **Searching vs linked list:** instead of walking through **all** users, you only walk through users with the same first letter, a much smaller list.
- **Inserting vs array:** no shifting and no copying; just add a node to the right letter's list.
- **Inserting vs linked list:** jump to the letter (`O(1)`) + add a node (`O(1)`). Same as a linked list.

> 💡 This idea (an array that points you to a smaller group directly) is the basic idea behind **hash tables** (Chapter 5).

---

## Part 6: Selection Sort

### The idea

Imagine you have a list of songs with play counts, and you want to sort them from most played to least played:

1. Go through the whole list and find the **most played** song. Put it first in a new list.
2. Go through the remaining songs and find the **next most played**. Add it.
3. Repeat until the original list is empty.

In code, we usually sort from **smallest to largest**, so each round we pick the **smallest** item.

### Steps

1. Find the smallest item in the list.
2. Move it to the sorted result.
3. Repeat with the remaining items until none are left.

### Walkthrough (book-style version)

Sort `[4, 2, 7, 1]`:

| Round | Remaining      | Smallest | Sorted         |
| ----- | -------------- | -------- | -------------- |
| 1     | `[4, 2, 7, 1]` | 1        | `[1]`          |
| 2     | `[4, 2, 7]`    | 2        | `[1, 2]`       |
| 3     | `[4, 7]`       | 4        | `[1, 2, 4]`    |
| 4     | `[7]`          | 7        | `[1, 2, 4, 7]` |

### Walkthrough (in-place version)

Instead of building a new list, **swap** the smallest remaining item into its correct position:

| Pass | Look at        | Smallest | Action             | List after     |
| ---- | -------------- | -------- | ------------------ | -------------- |
| 1    | `[4, 2, 7, 1]` | 1        | swap index 0 and 3 | `[1, 2, 7, 4]` |
| 2    | `[2, 7, 4]`    | 2        | already in place   | `[1, 2, 7, 4]` |
| 3    | `[7, 4]`       | 4        | swap index 2 and 3 | `[1, 2, 4, 7]` |

### Big O: `O(n²)`

To find the smallest item, you check **every remaining item**:

```
Round 1: n items
Round 2: n - 1 items
Round 3: n - 2 items
...
Last:    1 item

Total = n + (n-1) + ... + 1 = n(n + 1) / 2  ≈  ½ × n²
```

Constants are dropped in Big O, so `½ × n²` → **`O(n²)`**.

Another way to see it: **`n` rounds × `O(n)` work per round = `O(n²)`**.

| n         | Checks (≈ n²/2)  |
| --------- | ---------------- |
| 10        | 55               |
| 1,000     | 500,500          |
| 1,000,000 | ~500,000,000,000 |

For 1,000,000 items, a fast `O(n log n)` sort needs roughly 20,000,000 operations. That's about **25,000 times fewer**.

> 💡 In my book-style implementation, `removeAt(index)` on a Dart `List` is **also `O(n)`**, because it shifts items left, exactly like deleting from an array in Part 2.
> So each round is `O(n)` (find) + `O(n)` (remove) = `O(n)`, and the total is still `O(n²)`.

### Comparing my two implementations

|                      | Book-style (`selectionSort`) | In-place (`selectionSortInPlace`) |
| -------------------- | ---------------------------- | --------------------------------- |
| Time                 | `O(n²)`                      | `O(n²)`                           |
| Extra memory         | `O(n)` (a new list + a copy) | `O(1)` (only swaps)               |
| Changes the input?   | ❌ No                        | ✅ Yes                            |
| Easier to understand | ✅                           | Slightly harder                   |

### Is selection sort used in real life?

Rarely. It's simple and great for learning, but slow for big data.
Real programs use faster `O(n log n)` algorithms, like Dart's built-in `list.sort()`.
**Quicksort** (Chapter 4) is one of them.

---

## Key Takeaways

- Memory is like a big set of drawers, and every drawer has an address.
- **Arrays** store items side by side → fast reads `O(1)`, slow inserts/deletes `O(n)`.
- **Linked lists** store items anywhere, each pointing to the next → slow reads `O(n)`, fast inserts/deletes `O(1)`.
- Arrays support **random access**; linked lists only support **sequential access**.
- Arrays are used more often because many algorithms need random access.
- Selection sort repeatedly picks the smallest remaining item → **`O(n²)`**.

## Code

👉 [selection_sort.dart](./selection_sort.dart)
