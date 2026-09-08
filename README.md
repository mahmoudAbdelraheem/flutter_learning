# 🗺️ Flutter & Dart Deep Mastery Plan

> **Initial study pace:** 30 minutes – 1 hour daily (flexible around work)
> **Philosophy:** Learn → Understand → Practice → Build → Review
> **Golden rule:** If a topic needs more time, take it. This schedule is approximate, not sacred.

---

## 📌 Before You Start — Important Rules

1. **Month 1 = Main Track only.** No CS, no book reading. The main goal is to establish the daily study habit first; everything else gets added later.
2. **Every time you finish a topic, write 3-5 lines in your own words** (not copy-paste) — a simple summary in a Notes file. This is what separates "read" from "understood."
3. **Don't open more than one source for the same topic.** Pick a source (video/article/official docs) and finish it; if you want to go deeper afterward, look for another.
4. **In weeks you feel tired or work is busy → reduce, but never stop completely.** Even 15 minutes a day is better than zero.

---

## Phase Zero — Foundation Week (Optional but Useful)

**Duration:** 3-4 days, 20-30 minutes daily

- Set up a place to write Notes (Notion / Obsidian / even a plain Markdown file)
- Create a Flutter project folder called `flutter-playground` to use for every hands-on experiment throughout the journey
- Read a quick overview of the whole plan (the one you wrote) so the big picture is clear in your mind

---

## Phase 1 — Advanced Dart & Concurrency

**Total suggested duration:** 5-6 weeks | **Daily:** 30-45 minutes, 4-5 days/week

| Week | Topic | Study Details | Approx. Time |
|---|---|---|---|
| 1 | Event Loop | Single-threaded Dart, sync code, Event Queue, Microtask Queue, execution order. **Exercise:** write code with print + Future + scheduleMicrotask and predict the output before running it (do 5 different examples) | 3-4 days × 30 min |
| 2 | Microtasks vs Event Queue | Future.microtask, scheduleMicrotask, Future(), Future.delayed — when to use each and why | 2-3 days × 30 min |
| 2-3 | Futures & Async in Depth | Future chaining, error propagation, Future.wait, parallel vs sequential, timeout | 3-4 days × 30-45 min |
| 3-4 | Streams Basics | Single Subscription vs Broadcast, Listen/Pause/Resume/Cancel, error handling, lifecycle | 4 days × 30-45 min |
| 4 | Stream Controllers | StreamController, broadcast, Sink, when you actually need one (not everything needs to be a Stream) | 3 days × 30-45 min |
| 5 | Advanced Streams | async*, yield, yield*, transformers, combining streams. **Mini project:** a small app based on Streams (e.g., a counter or search debounce) | 4-5 days × 45 min-1 hr |
| 5-6 | Isolates | Why the UI freezes, compute, Isolate.spawn, SendPort/ReceivePort. **Mandatory hands-on exercise:** run a heavy operation (large loop or computation) on the Main Thread and observe its effect, then move it to an Isolate and compare | 4-5 days × 45 min-1 hr |

> 🎯 **End of phase:** write a one-page summary "When do I use Future / Stream / Isolate" — this is the thing that will make the biggest practical difference.

---

## Phase 2 — Advanced Dart Language Features

**Duration:** 2-3 weeks | **Daily:** 30-40 minutes

| Week | Topic | Details | Time |
|---|---|---|---|
| 1 | Generics | Generic classes/methods, type constraints, using them in architecture (not just `Box<T>`) | 2-3 days × 30 min |
| 1-2 | Sealed Classes + Records | sealed, base, interface, final and the differences between them, exhaustiveness. Records: positional/named, returning multiple values. **Apply to:** API states (Loading/Success/Error) | 3-4 days × 30-40 min |
| 2 | Pattern Matching | Object patterns, destructuring, switch expressions, guard clauses. **Connect it to Sealed Classes** in one complete practical example | 3 days × 30-40 min |
| 3 | Memory Management | Stack vs Heap, GC, closures and their impact, StreamSubscription/Controller leaks, dispose() | 3-4 days × 30-40 min |

---

## Phase 3 — Flutter Internals & Rendering

**Duration:** 4-5 weeks | **Daily:** 30-45 minutes

| Week | Topic | Details | Time |
|---|---|---|---|
| 1 | The Three Trees | Widget Tree → Element Tree → RenderObject Tree. Why Widget is immutable, what Element does, what RenderObject is responsible for | 3-4 days × 30 min |
| 1-2 | BuildContext | What it really is, its relationship to the Element Tree, how `.of(context)` actually works | 2 days × 30 min |
| 2 | Widget Lifecycle | initState → didChangeDependencies → build → didUpdateWidget → deactivate → dispose. **Exercise:** add logging to each one and observe when they actually fire | 2-3 days × 30 min |
| 2-3 | Keys | ValueKey, ObjectKey, UniqueKey, GlobalKey — when you actually need them | 2 days × 30 min |
| 3 | Rendering Pipeline | Build → Layout → Paint → Compositing → Rasterization. The difference between Rebuild/Relayout/Repaint | 3-4 days × 30-45 min |
| 4 | Engine & Platforms | Flutter Engine, Dart Runtime, Impeller/Skia, why there are usually no native widgets | 3 days × 30-45 min |
| 4-5 | Flutter Web | Architecture, rendering on the web, the difference from React | 2-3 days × 30 min |

---

## Phase 4 — 🎨 Animations & Custom Paint (The Part You Asked For)

**Duration:** 3-4 weeks | **Daily:** 30-45 minutes

> Placed exactly here because it builds directly on your understanding of the Rendering Pipeline from the previous phase, and it's a natural lead-in to the upcoming Performance phase.

| Week | Topic | Details | Time |
|---|---|---|---|
| 1 | Implicit Animations | AnimatedContainer, AnimatedOpacity, AnimatedPositioned, AnimatedSwitcher, TweenAnimationBuilder — when they're enough and when they're not | 3-4 days × 30 min |
| 1-2 | Explicit Animations Basics | AnimationController, Tween, Curve, Ticker/TickerProvider, addListener | 3-4 days × 30-45 min |
| 2 | AnimatedBuilder vs AnimatedWidget | The difference, performance, when to use each. **Exercise:** build the same animation both ways and compare | 2-3 days × 30-45 min |
| 2-3 | Hero & Staggered Animations | Hero animations between pages, staggered animations (sequenced, related movements) | 3 days × 30-45 min |
| 3 | Physics-based Animations | SpringSimulation, friction, fling — an introductory look and simple application | 2 days × 30 min |
| 3-4 | Custom Paint Basics | Canvas API, Paint object, CustomPainter, `shouldRepaint` — when it returns true/false and why it matters for performance | 3-4 days × 30-45 min |
| 4 | Advanced Custom Paint | Drawing shapes/paths, PathMetrics, clipping. **Mini project:** draw a custom shape (e.g., a progress circle or simple chart) with CustomPainter from scratch | 3-4 days × 45 min-1 hr |

> 🎯 **End of phase:** build one animation component (e.g., a custom loading indicator or progress bar) from scratch without any ready-made package.

---

## Phase 5 — Software Architecture Deep Dive

**Duration:** 3-4 weeks | **Daily:** 30-45 minutes

| Week | Topic | Details | Time |
|---|---|---|---|
| 1 | Clean Architecture Trade-offs | Not re-covering the basics — focus on: when it's useful, when it's overengineering, does every feature need a Use Case | 3-4 days × 30-45 min |
| 1-2 | SOLID in Practice | Each principle: Problem → Bad Code → Why It's a Problem → Refactor → Solution (use code from your own project) | 4-5 days × 30-45 min |
| 2-3 | Design Patterns | Factory, Strategy, Adapter, Observer, Builder, Repository, DI — each with an example from a real project | 4-5 days × 30-45 min |
| 3-4 | Architecture for Large Projects | Feature-first, modularization, shared core, circular dependencies, monorepo basics | 3-4 days × 30-45 min |

---

## Phase 6 — Performance ⚡ + Flutter DevTools

**Duration:** 4-5 weeks | **Daily:** 30-45 minutes

| Week | Topic | Details | Time |
|---|---|---|---|
| 1 | Rebuilds & Rendering Cost | What causes a rebuild, when it's actually a problem, const, widget splitting, RepaintBoundary | 3-4 days × 30-45 min |
| 2 | Lists & Images | Lazy rendering, pagination, image optimization/caching | 2-3 days × 30-45 min |
| 2-3 | DevTools: Inspector & Performance View | Widget Tree debugging, UI Thread vs Raster Thread, jank, frame budget (16ms) | 4 days × 30-45 min |
| 3-4 | DevTools: CPU & Memory Profiler | Finding slow functions, memory usage, object allocation, discovering leaks hands-on | 4-5 days × 45 min-1 hr |
| 4-5 | Full Hands-on Application | **Mandatory:** create a performance problem yourself (heavy rebuild or leak) → open it in DevTools → record it → fix it → compare before/after | 4-5 days × 45 min-1 hr |

---

## Phase 7 — Testing 🧪

**Duration:** 3-4 weeks | **Daily:** 30-45 minutes

| Week | Topic | Details | Time |
|---|---|---|---|
| 1 | Basics | Why testing, Test Pyramid, Arrange/Act/Assert, the difference between the three types | 2 days × 30 min |
| 1-2 | Unit Testing | Validators, use cases, business logic → then repositories + mocking | 4 days × 30-45 min |
| 2-3 | Widget Testing | Visible widgets, user interaction, forms, loading/error states | 3-4 days × 30-45 min |
| 3 | Integration Testing | A full flow (Login → API → Home → Logout) | 3 days × 45 min-1 hr |
| 3-4 | Real Application | Pick your current project and gradually add testing to one complete feature (Unit → Widget → Integration) | Ongoing |

---

## 💻 Parallel Track — CS + Problem Solving

**Starts from Month 2** (after the daily habit is established in the Main Track)
**Pace:** 2-3 days/week, 25-30 minutes

| Period | Topics |
|---|---|
| Months 2-3 | Big O, Arrays, Strings, Hash Maps, Stack, Queue, Recursion |
| Months 3-4 | Linked Lists, Trees, Binary Search, Sorting, Two Pointers |
| Months 5-6 | Graphs, BFS, DFS, Dynamic Programming basics |

---

## 📚 Reading

**Starts from Month 2, 15-20 minutes on days you have energy (not daily)**

- One technical book only, practical rather than academic (not something like Introduction to Algorithms as a starting point)
- Clean Code in parallel if you like — read the idea, apply it, see the trade-offs yourself

---

## 🗓️ Suggested Weekly Schedule (From Month 2 Onward)

| Day | Activity | Time |
|---|---|---|
| Saturday | Main Track | 30-45 min |
| Sunday | Main Track | 30-45 min |
| Monday | CS | 25-30 min |
| Tuesday | Main Track | 30-45 min |
| Wednesday | CS or Reading | 25-30 min |
| Thursday | Main Track | 30-45 min |
| Friday | Weekly review + writing notes | 20-30 min |

> Month 1: remove CS and reading from the schedule and use their days as extra review or rest.

---

## ⏱️ Approximate Total Time Summary

| Phase | Duration |
|---|---|
| 0 — Foundation | 1 week |
| 1 — Advanced Dart & Concurrency | 5-6 weeks |
| 2 — Advanced Language Features | 2-3 weeks |
| 3 — Flutter Internals & Rendering | 4-5 weeks |
| 4 — Animations & Custom Paint | 3-4 weeks |
| 5 — Architecture | 3-4 weeks |
| 6 — Performance & DevTools | 4-5 weeks |
| 7 — Testing | 3-4 weeks |
| **Total** | **~26-32 weeks (6-7.5 months)** at a pace of half an hour to an hour daily |

---

## ✅ The Consistency Rule (More Important Than the Whole Schedule)

- At the end of every week, ask yourself one question — **"If someone asked me, could I explain this topic without opening my notes?"**
- If the answer is no, spend an extra day on the same topic instead of moving on.
- Don't compare yourself to how fast anyone else is going. The goal is real understanding, not speed-running a checklist.
