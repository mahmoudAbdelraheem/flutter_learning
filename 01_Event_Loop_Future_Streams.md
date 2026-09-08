# 📘 Summary: Event Loop & Futures & Streams

> Part 1 of the Advanced Dart & Concurrency journey

---

## 1️⃣ Event Loop

### The Core Idea

Dart is **single-threaded** — one thread only (the Main Isolate). To manage priority between synchronous code and asynchronous operations, Dart uses an **Event Loop**.

### The Three Components

```
1. Call Stack (Synchronous code) — executes immediately, line by line
2. Microtask Queue — very high priority
3. Event Queue (Macrotask Queue) — lower priority
```

### The Golden Rule

> Dart runs all synchronous code first → drains the **entire Microtask Queue** → takes **only one item** from the Event Queue → goes back and drains the Microtask Queue again → repeat (a continuous loop).

### Reference Diagram

```
Start
  ↓
Execute Main()
  ↓
Microtask queue empty? ──No──► Run first microtask ──┐
  │Yes                                                 │
  ↓                                                     │(loops back to check microtasks again)
Event queue empty? ──No──► Handle first event ─────────┘
  │Yes
  ↓
End
```

**The most important point:** after executing **one single Event**, the loop goes back to check the Microtask Queue from scratch before taking the next Event. If that Event, while executing, schedules a new microtask, it will run **immediately** — before any other Event.

### Worked Example

```dart
void main() {
  print('A');                                    // Sync
  Future(() {
    print('Event 1');
    scheduleMicrotask(() => print('New Microtask'));
  });                                             // Event Queue
  Future(() => print('Event 2'));                 // Event Queue
  scheduleMicrotask(() => print('Old Microtask')); // Microtask Queue
  print('F');                                     // Sync
}
```

**Output:**
```
A
F
Old Microtask
Event 1
New Microtask   ← scheduled during Event 1's execution, so it runs before Event 2
Event 2
```

---

## 2️⃣ Future & async/await

### The Most Important Rule About `await`

> `await` only pauses **the function it's inside**, not the whole program. Any code outside that function keeps running normally.

```dart
void main() {
  print('start');
  myFunction();     // contains an await inside
  print('end');     // ← runs immediately, does NOT wait for myFunction
}

void myFunction() async {
  print('A');
  await Future.delayed(Duration(seconds: 1));
  print('B');       // ← this is what gets delayed, not the outside code
}

// Output: start → A → end → (after 1 second) → B
```

If you actually want `main` to wait for `myFunction`, you need to `await` at the call site itself:
```dart
void main() async {
  print('start');
  await myFunction();  // now main will wait
  print('end');
}
```

---

### Sequential vs Parallel Execution

**Sequential** — each `await` waits for the previous one to finish:
```dart
final user = await fetchUser();              // 1s
final notifications = await fetchNotifications(); // 1s
final settings = await fetchSettings();       // 1s
// Total time: ~3 seconds
```

Use this when the next request **needs the result** of the previous one:
```dart
final user = await fetchUser();
final posts = await fetchPostsByUserId(user.id); // needs user.id
```

**Parallel** — `Future.wait` runs everything together:
```dart
final results = await Future.wait([
  fetchUser(),
  fetchNotifications(),
  fetchSettings(),
]);
// Total time: roughly the slowest operation only (not the sum)
```

Use this when the requests are **independent** of each other.

### Error Handling with `Future.wait`

- If **any Future** throws, the whole `Future.wait` throws with that same exception and jumps to `catch`.
- The remaining Futures (still running) **keep running in the background**, but their results won't reach you through that same `await`.
- `eagerError: false` (the default) lets the other Futures keep running even after one fails.

### An Alternative Real-World Design (Independent Cards)

For a scenario like a Dashboard with multiple cards, **independence is often better than bundling with `Future.wait`**:
- Each Card/Feature manages its own Loading/Success/Error state (usually via a separate BLoC/Cubit)
- Shared headers (Auth Token, ...) are handled via a **Dio Interceptor** instead of duplicating logic
- Overall coordination (e.g. "Refresh everything") is handled by a **BLoC** as a higher layer, which decides when to use Parallel and when to keep things independent

---

## 3️⃣ Streams

### The Precise Definition

| | Value | How many times |
|---|---|---|
| **Future** | one value (Success/Error) | once, then it's done |
| **Stream** | a sequence of values | zero or more, over time |

```
Future:   ────────●
Stream:   ──●────●──────●───●──
```

### Stream = Observer Pattern

- **Stream** = Publisher/Subject
- **Listener** (`.listen()`) = Observer/Subscriber

`BlocBuilder`/`BlocListener` are themselves listening to a Stream of States under the hood.

---

### Single Subscription vs Broadcast

**Single Subscription** (the default):
```dart
final controller = StreamController<int>();
controller.stream.listen((d) => print('L1: $d'));
controller.stream.listen((d) => print('L2: $d'));
// ❌ Exception: "Stream has already been listened to"
```
Only **one listener at a time** is allowed.

**Broadcast**:
```dart
final controller = StreamController<int>.broadcast();
controller.stream.listen((d) => print('L1: $d'));
controller.stream.listen((d) => print('L2: $d'));
// ✅ Works fine, both receive the same events
```

> **Important note:** `Bloc`/`Cubit` from `flutter_bloc` uses a Broadcast stream internally by default, so that `BlocBuilder`, `BlocListener`, and `BlocConsumer` can all listen at the same time.

---

### Subscription Lifecycle

```dart
final subscription = myStream.listen((data) => print(data));

subscription.pause();   // pauses temporarily (events are buffered, not lost)
subscription.resume();  // continues from where it stopped
subscription.cancel();  // closes it entirely, no going back
```

**The critical rule:**
> In a StatefulWidget's `dispose()` → **always use `cancel()`**. Never `pause()`, because the State will be destroyed completely and nothing will ever call `resume()` again — this is a memory leak (a subscription left paused forever).

`pause()`/`resume()` are used in a different context: when you're **still holding onto the subscription** and can return to it later (e.g. App Lifecycle: pause when the app goes to background, resume when it comes back).

---

### Error Handling in a Stream

```dart
myStream.listen(
  (data) => print('Data: $data'),
  onError: (error) => print('Error: $error'),
  onDone: () => print('Done'),
);
```

An important difference from Future: an Error in a Stream **doesn't necessarily close it** — it can emit an error and then keep emitting data normally afterward.

---

### StreamController

The tool you use to build a Stream from scratch:

```dart
class CounterController {
  final _controller = StreamController<int>();
  int _count = 0;

  Stream<int> get counterStream => _controller.stream;

  void increment() {
    _count++;
    _controller.add(_count); // = controller.sink.add(_count)
  }

  void dispose() {
    _controller.close(); // very important — cleans up the Controller itself
  }
}
```

### Two Different Things to Clean Up (both are needed)

| Operation | Used by | When |
|---|---|---|
| `subscription.cancel()` | The listening side (Listener) | When you're done caring about the stream |
| `controller.close()` | The producing side (Producer) | When nothing will ever be added again |

**A very common bug:** forgetting either one = a memory leak. The full correct example:

```dart
class SearchService {
  final _controller = StreamController<String>();
  Stream<String> get searchStream => _controller.stream;
  void onTextChanged(String text) => _controller.add(text);
  void dispose() => _controller.close();          // (1) clean up the Controller
}

class _SearchScreenState extends State<SearchScreen> {
  final searchService = SearchService();
  late StreamSubscription<String> _subscription;   // must hold onto it

  @override
  void initState() {
    super.initState();
    _subscription = searchService.searchStream.listen((query) {
      print('Searching for: $query');
    });
  }

  @override
  void dispose() {
    _subscription.cancel();     // (2) clean up the Subscription
    searchService.dispose();    // (3) clean up the Service itself
    super.dispose();
  }
}
```

---

### When Do You Actually Need a Manual StreamController?

In day-to-day BLoC work, you'll **almost never need it** — `emit(state)` is essentially `controller.add()` at a higher level, and the Bloc manages its own lifecycle.

You actually need it when:
1. You're building a **wrapper** around something that isn't a Stream to begin with (e.g. converting a callback-based API into a Stream)
2. You're building something like **Debounce** manually from scratch
3. You're working at a low level (Data Source layer, your own package)

---

### Advanced Streams (Quick Overview)

```dart
// async* + yield: build a Stream from a regular function
Stream<int> countStream(int max) async* {
  for (int i = 1; i <= max; i++) {
    await Future.delayed(Duration(seconds: 1));
    yield i;
  }
}

// yield*: merge a Stream inside another Stream
Stream<int> allNumbers() async* {
  yield* countStream(3);
  yield* countStream(2);
}

// Transformers: transform the shape of the data (map/where/distinct and deeper)
searchStream
  .where((q) => q.length > 2)
  .listen((q) => performSearch(q));
```

> You'll typically encounter these inside ready-made libraries (e.g. `bloc_concurrency` for debounce/throttle on Events) more than writing them from scratch yourself.

---

## ✅ Key Takeaways From This Part

1. **Sync → Microtask (fully drained) → one Event → back to checking Microtasks** — this is the foundation for everything else
2. `await` only pauses its own function, not the whole program
3. Parallel (`Future.wait`) for independent requests, Sequential for requests that depend on each other's results
4. Single Subscription = one listener, Broadcast = multiple listeners (BLoC uses Broadcast by default)
5. `dispose()` = **always `cancel()`**, never `pause()`
6. Two separate things must be closed: the `subscription` (Listener) and the `controller` (Producer)
7. A manual `StreamController` = special cases only, not the everyday pattern with BLoC

---

*Next in the roadmap: Isolates 🔥*
