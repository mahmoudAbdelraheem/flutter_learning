# Algorithms 📚

My notes and Dart implementations while studying **[Grokking Algorithms](https://www.manning.com/books/grokking-algorithms-second-edition)** by Aditya Bhargava.

The goal is to study a little every day, understand each idea deeply, and write it down in my own words.

## How this folder is organized

Each chapter has its own folder that contains:

- `README.md` → a summary of the chapter: the ideas, examples, exercises, and my notes.
- `*.dart` → the implementation in Dart, with short comments.

## Progress

| #   | Chapter                    | Topics                                         | Notes                                   | Code                                                           | Status  |
| --- | -------------------------- | ---------------------------------------------- | --------------------------------------- | -------------------------------------------------------------- | ------- |
| 1   | Introduction to Algorithms | Binary Search, Big O Notation                  | [README](./01_binary_search/README.md)  | [binary_search.dart](./01_binary_search/binary_search.dart)    | ✅ Done |
| 2   | Selection Sort             | Memory, Arrays vs Linked Lists, Selection Sort | [README](./02_selection_sort/README.md) | [selection_sort.dart](./02_selection_sort/selection_sort.dart) | ✅ Done |

> More chapters will be added as I go through the book.

## Big O Cheat Sheet

| Algorithm / Operation        | Big O      | Chapter |
| ---------------------------- | ---------- | ------- |
| Linear search                | `O(n)`     | 1       |
| Binary search                | `O(log n)` | 1       |
| Array: read                  | `O(1)`     | 2       |
| Array: insert / delete       | `O(n)`     | 2       |
| Linked list: read            | `O(n)`     | 2       |
| Linked list: insert / delete | `O(1)`     | 2       |
| Selection sort               | `O(n²)`    | 2       |

## How to run the code

No Flutter project is needed. The code is plain Dart, so you only need the [Dart SDK](https://dart.dev/get-dart) (it also comes with Flutter).

From inside the `algorithms` folder, run any file like this:

```bash
dart run <chapter_folder>/<file_name>.dart
```

- `<chapter_folder>` → the chapter's folder name (see the **Progress** table above).
- `<file_name>` → the Dart file inside that folder.
