// Chapter 2 — Selection Sort
// Run: dart run selection_sort.dart

void main() {
  final data = [4, 3, 7, 8, 1, 2, 0, 10, 6, 5];

  final smallest = findSmallest(data);
  print('Smallest in $data is ${smallest.value} at index ${smallest.index}');

  // Version 1 (book style): returns a NEW sorted list.
  print('selectionSort          -> ${selectionSort(data)}');
  print('original list is still -> $data'); // not emptied ✅

  // Version 2 (classic): sorts the list itself by swapping.
  final copy = [...data];
  selectionSortInPlace(copy);
  print('selectionSortInPlace   -> $copy');
}

/// Returns the smallest value in [list] and its index.
/// Uses a named record, so we can write `.value` / `.index` instead of `$1` / `$2`.
/// (Records → see the phase 2 advanced Dart language features file)
/// Time: O(n)
({int value, int index}) findSmallest(List<int> list) {
  if (list.isEmpty) {
    throw ArgumentError('list must not be empty');
  }

  var smallest = list[0];
  var smallestIndex = 0;

  for (var i = 1; i < list.length; i++) {
    // `<` keeps the FIRST smallest item if there are duplicates.
    if (list[i] < smallest) {
      smallest = list[i];
      smallestIndex = i;
    }
  }
  return (value: smallest, index: smallestIndex);
}

/// Book-style selection sort: keeps moving the smallest item into a new list.
/// Does NOT change [list].
/// Time: O(n²) · Extra memory: O(n)
List<int> selectionSort(List<int> list) {
  final remaining = [...list]; // copy, so the caller's list isn't emptied
  final sorted = <int>[];

  while (remaining.isNotEmpty) {
    final smallest = findSmallest(remaining); // O(n)
    sorted.add(smallest.value); // O(1) on average
    remaining.removeAt(smallest.index); // O(n): shifts items to the left
  }
  return sorted;
}

/// Classic selection sort: swaps the smallest remaining item into its place.
/// Changes [list] directly.
/// Time: O(n²) · Extra memory: O(1)
void selectionSortInPlace(List<int> list) {
  // The last item is already in place when all others are sorted.
  for (var i = 0; i < list.length - 1; i++) {
    var minIndex = i;

    // Find the smallest item in the unsorted part (from i to the end).
    for (var j = i + 1; j < list.length; j++) {
      if (list[j] < list[minIndex]) minIndex = j;
    }

    // Swap it into position i.
    if (minIndex != i) {
      final temp = list[i];
      list[i] = list[minIndex];
      list[minIndex] = temp;
    }
  }
}
