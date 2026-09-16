// Chapter 1 — Binary Search vs Linear Search
// Run: dart run binary_search.dart

void main() {
  final numbers = [1, 3, 5, 7, 9, 11, 13, 15, 17, 19];

  print('--- Basic tests ---');
  print('binarySearch(numbers, 13) -> ${binarySearch(numbers, 13)}'); // 6
  print('binarySearch(numbers, 1)  -> ${binarySearch(numbers, 1)}'); // 0
  print('binarySearch(numbers, 19) -> ${binarySearch(numbers, 19)}'); // 9
  print('binarySearch(numbers, 4)  -> ${binarySearch(numbers, 4)}'); // null

  print('\n--- Unsorted list (wrong result!) ---');
  print(
    'binarySearch([7, 2, 9, 1, 5], 1) -> ${binarySearch([7, 2, 9, 1, 5], 1)}',
  );

  print('\n--- Worst-case steps: linear vs binary ---');
  for (final size in [100, 10000, 1000000]) {
    final list = List<int>.generate(size, (i) => i);
    final target = size - 1; // last item = worst case for linear search

    final linear = linearSearchWithSteps(list, target);
    final binary = binarySearchWithSteps(list, target);

    print(
      'n = $size -> linear: ${linear.steps} steps, '
      'binary: ${binary.steps} steps',
    );
  }
}

/// Returns the index of [item] in [list], or null if not found.
/// Works on any list. Time: O(n)
int? linearSearch(List<int> list, int item) {
  for (var i = 0; i < list.length; i++) {
    if (list[i] == item) return i;
  }
  return null;
}

/// Returns the index of [item] in [list], or null if not found.
/// ⚠️ [list] must be sorted. Time: O(log n)
int? binarySearch(List<int> list, int item) {
  var low = 0;
  var high = list.length - 1;

  while (low <= high) {
    final mid = low + (high - low) ~/ 2; // avoids overflow in other languages
    final guess = list[mid];

    if (guess == item) return mid;

    if (guess > item) {
      high = mid - 1; // target is in the left half
    } else {
      low = mid + 1; // target is in the right half
    }
  }
  return null;
}

// ---------- Versions that count steps (to see Big O in action) ----------
// return type is Record you can find it in phase 2 advanced dart language features file
({int? index, int steps}) linearSearchWithSteps(List<int> list, int item) {
  var steps = 0;
  for (var i = 0; i < list.length; i++) {
    steps++;
    if (list[i] == item) return (index: i, steps: steps);
  }
  return (index: null, steps: steps);
}

({int? index, int steps}) binarySearchWithSteps(List<int> list, int item) {
  var low = 0;
  var high = list.length - 1;
  var steps = 0;

  while (low <= high) {
    steps++;
    final mid = low + (high - low) ~/ 2;
    final guess = list[mid];

    if (guess == item) return (index: mid, steps: steps);

    if (guess > item) {
      high = mid - 1;
    } else {
      low = mid + 1;
    }
  }
  return (index: null, steps: steps);
}
