# 🗺️ خطة إتقان Flutter & Dart بعمق

> **معدل المذاكرة المبدئي:** 30 دقيقة – ساعة يوميًا (مرن حسب الشغل)
> **الفلسفة:** Learn → Understand → Practice → Build → Review
> **القاعدة الذهبية:** لو حسيت إن موضوع محتاج وقت أطول، خده. الجدول ده تقريبي مش مقدس.

---

## 📌 قبل ما تبدأ — قواعد مهمة

1. **الشهر الأول = Main Track بس.** من غير CS ومن غير قراءة كتاب. الهدف الأساسي إنك تثبت عادة المذاكرة اليومية الأول، بعد كده نضيف الباقي.
2. **كل ما تخلص Topic، اكتب 3-5 سطور بلغتك انت** (مش نسخ ولزق) — تلخيص بسيط في ملف Notes. ده اللي هيفرق بين "قرأت" و"فهمت".
3. **متفتحش أكتر من مصدر واحد للـTopic الواحد.** اختار مصدر (فيديو/مقال/توثيق رسمي) وكمله، بعدين لو حابب تعمق دور على تاني.
4. **الأسبوع اللي حاسس فيه إنك تعبان أو الشغل زحمة → قلل، متوقفش خالص.** حتى 15 دقيقة يوميًا أفضل من صفر.

---

## المرحلة صفر — أسبوع التأسيس (اختياري بس مفيد)

**المدة:** 3-4 أيام، 20-30 دقيقة يوميًا

- جهز مكان لكتابة الـNotes (Notion / Obsidian / حتى ملف Markdown عادي)
- اعمل فولدر مشروع Flutter اسمه `flutter-playground` هتستخدمه في كل تجربة عملية طول الرحلة
- اقرأ نظرة عامة سريعة عن الخطة كلها (اللي كتبتها انت) عشان تبقى الصورة الكبيرة واضحة في دماغك

---

## المرحلة ١ — Advanced Dart & Concurrency

**المدة الكلية المقترحة:** 5-6 أسابيع | **يوميًا:** 30-45 دقيقة، 4-5 أيام/أسبوع

| الأسبوع | الموضوع | تفاصيل المذاكرة | وقت تقريبي |
|---|---|---|---|
| 1 | Event Loop | Single-threaded Dart، Sync code، Event Queue، Microtask Queue، ترتيب التنفيذ. **تمرين:** اكتب كود فيه print + Future + scheduleMicrotask وتوقع الـOutput قبل التشغيل (اعمل 5 أمثلة مختلفة) | 3-4 أيام × 30د |
| 2 | Microtasks vs Event Queue | Future.microtask, scheduleMicrotask, Future(), Future.delayed — إمتى تستخدم كل واحدة وليه | 2-3 أيام × 30د |
| 2-3 | Futures & Async عميق | Future chaining, Error propagation, Future.wait, Parallel vs Sequential, Timeout | 3-4 أيام × 30-45د |
| 3-4 | Streams Basics | Single Subscription vs Broadcast, Listen/Pause/Resume/Cancel, Error handling, Lifecycle | 4 أيام × 30-45د |
| 4 | Stream Controllers | StreamController, broadcast, Sink, إمتى فعلًا تحتاجه (مش كل حاجة Stream) | 3 أيام × 30-45د |
| 5 | Advanced Streams | async*, yield, yield*, transformers, combining streams. **مشروع صغير:** Mini app بسيط يعتمد على Stream (زي عداد أو Search debounce) | 4-5 أيام × 45د-1س |
| 5-6 | Isolates | ليه الـUI بيعلق، compute, Isolate.spawn, SendPort/ReceivePort. **تمرين عملي إجباري:** اعمل عملية تقيلة (loop كبير أو حساب) على الـMain Thread وشوف تأثيرها، بعدين انقلها لـIsolate وقارن | 4-5 أيام × 45د-1س |

> 🎯 **نهاية المرحلة:** اعمل ملخص واحد صفحة "إمتى أستخدم Future / Stream / Isolate" — دي أهم حاجة هتفرق معاك عمليًا.

---

## المرحلة ٢ — Advanced Dart Language Features

**المدة:** 2-3 أسابيع | **يوميًا:** 30-40 دقيقة

| الأسبوع | الموضوع | تفاصيل | وقت |
|---|---|---|---|
| 1 | Generics | Generic classes/methods, Type constraints, استخدامها في Architecture (مش `Box<T>` وخلاص) | 2-3 أيام × 30د |
| 1-2 | Sealed Classes + Records | sealed, base, interface, final والفرق بينهم، Exhaustiveness. Records: Positional/Named، Returning multiple values. **طبقها في:** API states (Loading/Success/Error) | 3-4 أيام × 30-40د |
| 2 | Pattern Matching | Object patterns, Destructuring, Switch expressions, Guard clauses. **اربطها بـSealed Classes** في مثال عملي واحد كامل | 3 أيام × 30-40د |
| 3 | Memory Management | Stack vs Heap, GC, Closures وتأثيرها، StreamSubscription/Controller leaks، dispose() | 3-4 أيام × 30-40د |

---

## المرحلة ٣ — Flutter Internals & Rendering

**المدة:** 4-5 أسابيع | **يوميًا:** 30-45 دقيقة

| الأسبوع | الموضوع | تفاصيل | وقت |
|---|---|---|---|
| 1 | الأشجار الثلاثة | Widget Tree → Element Tree → RenderObject Tree. ليه Widget immutable، Element بيعمل إيه، RenderObject مسؤول عن إيه | 3-4 أيام × 30د |
| 1-2 | BuildContext | إيه هو فعلًا، علاقته بالـElement Tree، `.of(context)` بيشتغل إزاي فعليًا | 2 أيام × 30د |
| 2 | Widget Lifecycle | initState → didChangeDependencies → build → didUpdateWidget → deactivate → dispose. **تمرين:** Logging على كل واحدة وشوفها بتشتغل إمتى فعليًا | 2-3 أيام × 30د |
| 2-3 | Keys | ValueKey, ObjectKey, UniqueKey, GlobalKey — إمتى فعلًا تحتاجهم | 2 أيام × 30د |
| 3 | Rendering Pipeline | Build → Layout → Paint → Compositing → Rasterization. الفرق بين Rebuild/Relayout/Repaint | 3-4 أيام × 30-45د |
| 4 | Engine & Platforms | Flutter Engine, Dart Runtime, Impeller/Skia، ليه مفيش Native Widgets عادة | 3 أيام × 30-45د |
| 4-5 | Flutter Web | Architecture, Rendering على الويب، الفرق عن React | 2-3 أيام × 30د |

---

## المرحلة ٤ — 🎨 Animations & Custom Paint (الجزء اللي طلبته)

**المدة:** 3-4 أسابيع | **يوميًا:** 30-45 دقيقة

> رتبتها هنا بالظبط لأنها مبنية مباشرة على فهمك للـRendering Pipeline اللي خلصته في المرحلة اللي فاتت، وهي كمان تمهيد طبيعي لمرحلة الـPerformance اللي جاية.

| الأسبوع | الموضوع | تفاصيل | وقت |
|---|---|---|---|
| 1 | Implicit Animations | AnimatedContainer, AnimatedOpacity, AnimatedPositioned, AnimatedSwitcher, TweenAnimationBuilder — إمتى تكفي ومتى متكفيش | 3-4 أيام × 30د |
| 1-2 | Explicit Animations الأساسيات | AnimationController, Tween, Curve, Ticker/TickerProvider, addListener | 3-4 أيام × 30-45د |
| 2 | AnimatedBuilder vs AnimatedWidget | الفرق، الأداء، إمتى تستخدم كل واحد. **تمرين:** اعمل نفس الأنيميشن بالطريقتين وقارن | 2-3 أيام × 30-45د |
| 2-3 | Hero & Staggered Animations | Hero animations بين الصفحات، Staggered animations (تسلسل حركات مترابطة) | 3 أيام × 30-45د |
| 3 | Physics-based Animations | SpringSimulation, friction, fling — نظرة تعريفية وتطبيق بسيط | 2 أيام × 30د |
| 3-4 | Custom Paint Basics | Canvas API, Paint object, CustomPainter, `shouldRepaint` — إمتى بترجع true/false وليه مهم للأداء | 3-4 أيام × 30-45د |
| 4 | Custom Paint متقدم | رسم Shapes/Paths, PathMetrics, Clipping. **مشروع صغير:** ارسم شكل مخصص (زي progress circle أو chart بسيط) بـCustomPainter من الصفر | 3-4 أيام × 45د-1س |

> 🎯 **نهاية المرحلة:** اعمل مكون Animation واحد (مثلاً custom loading indicator أو progress بار) من الصفر بدون أي package جاهز.

---

## المرحلة ٥ — Software Architecture Deep Dive

**المدة:** 3-4 أسابيع | **يوميًا:** 30-45 دقيقة

| الأسبوع | الموضوع | تفاصيل | وقت |
|---|---|---|---|
| 1 | Clean Architecture Trade-offs | مش إعادة الأساسيات — ركز على: إمتى مفيدة، إمتى Overengineering، هل كل Feature محتاج Use Case | 3-4 أيام × 30-45د |
| 1-2 | SOLID عمليًا | كل مبدأ: Problem → Bad Code → ليه مشكلة → Refactor → Solution (استخدم كود من مشروعك انت) | 4-5 أيام × 30-45د |
| 2-3 | Design Patterns | Factory, Strategy, Adapter, Observer, Builder, Repository, DI — كل واحد بمثال من مشروع حقيقي | 4-5 أيام × 30-45د |
| 3-4 | Architecture للمشاريع الكبيرة | Feature-first, Modularization, Shared core, Circular dependencies, Monorepo basics | 3-4 أيام × 30-45د |

---

## المرحلة ٦ — Performance ⚡ + Flutter DevTools

**المدة:** 4-5 أسابيع | **يوميًا:** 30-45 دقيقة

| الأسبوع | الموضوع | تفاصيل | وقت |
|---|---|---|---|
| 1 | Rebuilds & Rendering Cost | إيه اللي بيعمل Rebuild، إمتى بيبقى مشكلة فعلًا، const، Widget splitting، RepaintBoundary | 3-4 أيام × 30-45د |
| 2 | Lists & Images | Lazy rendering, Pagination, Image optimization/caching | 2-3 أيام × 30-45د |
| 2-3 | DevTools: Inspector & Performance View | Widget Tree debugging, UI Thread vs Raster Thread, Jank, Frame budget (16ms) | 4 أيام × 30-45د |
| 3-4 | DevTools: CPU & Memory Profiler | لقاء Function بطيئة، Memory usage، Object allocation، اكتشاف الـleaks عمليًا | 4-5 أيام × 45د-1س |
| 4-5 | تطبيق عملي كامل | **إجباري:** اعمل مشكلة Performance بنفسك (heavy rebuild أو leak) → افتحها في DevTools → سجلها → حلها → قارن قبل/بعد | 4-5 أيام × 45د-1س |

---

## المرحلة ٧ — Testing 🧪

**المدة:** 3-4 أسابيع | **يوميًا:** 30-45 دقيقة

| الأسبوع | الموضوع | تفاصيل | وقت |
|---|---|---|---|
| 1 | Basics | ليه Testing، Test Pyramid، Arrange/Act/Assert، الفرق بين الأنواع الثلاثة | 2 أيام × 30د |
| 1-2 | Unit Testing | Validators, Use Cases, Business logic → بعدها Repositories + Mocking | 4 أيام × 30-45د |
| 2-3 | Widget Testing | Widget ظاهر، User interaction، Forms، Loading/Error states | 3-4 أيام × 30-45د |
| 3 | Integration Testing | Flow كامل (Login → API → Home → Logout) | 3 أيام × 45د-1س |
| 3-4 | تطبيق حقيقي | اختار مشروعك الحالي وضيف Testing تدريجيًا لـFeature واحدة كاملة (Unit → Widget → Integration) | مستمر |

---

## 💻 المسار الموازي — CS + Problem Solving

**يبدأ من الشهر الثاني** (بعد ما تثبت عادة الـMain Track)
**المعدل:** 2-3 أيام/أسبوع، 25-30 دقيقة

| الفترة | الموضوعات |
|---|---|
| الشهر 2-3 | Big O, Arrays, Strings, Hash Maps, Stack, Queue, Recursion |
| الشهر 3-4 | Linked Lists, Trees, Binary Search, Sorting, Two Pointers |
| الشهر 5-6 | Graphs, BFS, DFS, Dynamic Programming basics |

---

## 📚 القراءة

**يبدأ من الشهر الثاني، 15-20 دقيقة في الأيام اللي عندك طاقة (مش يومي)**

- كتاب واحد بس تقني، عملي أكتر من أكاديمي (مش Introduction to Algorithms كبداية)
- Clean Code بالتوازي لو حابب — اقرأ الفكرة، طبقها، شوف الـTrade-offs بنفسك

---

## 🗓️ الجدول الأسبوعي المقترح (من الشهر الثاني وبعده)

| اليوم | النشاط | الوقت |
|---|---|---|
| السبت | Main Track | 30-45 د |
| الأحد | Main Track | 30-45 د |
| الاثنين | CS | 25-30 د |
| الثلاثاء | Main Track | 30-45 د |
| الأربعاء | CS أو Reading | 25-30 د |
| الخميس | Main Track | 30-45 د |
| الجمعة | Review للأسبوع + كتابة Notes | 20-30 د |

> الشهر الأول: امسح CS والقراءة من الجدول واستخدم أيامهم كـReview إضافي أو راحة.

---

## ⏱️ ملخص الزمن الكلي التقريبي

| المرحلة | المدة |
|---|---|
| صفر — تأسيس | أسبوع |
| ١ — Advanced Dart & Concurrency | 5-6 أسابيع |
| ٢ — Advanced Language Features | 2-3 أسابيع |
| ٣ — Flutter Internals & Rendering | 4-5 أسابيع |
| ٤ — Animations & Custom Paint | 3-4 أسابيع |
| ٥ — Architecture | 3-4 أسابيع |
| ٦ — Performance & DevTools | 4-5 أسابيع |
| ٧ — Testing | 3-4 أسابيع |
| **الإجمالي** | **~26-32 أسبوع (6-7.5 شهور)** بمعدل نصف ساعة-ساعة يوميًا |

---

## ✅ قاعدة الاستمرارية (الأهم من الجدول كله)

- كل نهاية أسبوع: اسأل نفسك سؤال واحد بس — **"لو حد سألني، أقدر أشرحله الموضوع ده من غير ما أفتح النوتس؟"**
- لو الإجابة لأ، خد يوم زيادة في نفس الموضوع بدل ما تكمل.
- ماتقارنش نفسك بسرعة أي حد تاني. الهدف فهم حقيقي مش سرعة إنهاء Checklist.
