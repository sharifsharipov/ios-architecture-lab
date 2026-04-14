# ExpensePro iOS (SwiftUI)

Flutter `expense_pro` loyihasining SwiftUI versiyasi. Clean Architecture + MVVM + Combine.

## Talablar

- Xcode 15+
- iOS 16+
- CocoaPods
- [xcodegen](https://github.com/yonaskolb/XcodeGen): `brew install xcodegen`

## Birinchi ishga tushirish

```bash
# 1. Xcode loyihasini generatsiya qilish
xcodegen generate

# 2. Pod'larni o'rnatish
pod install

# 3. Workspace'ni ochish
open ExpenseProiOS.xcworkspace
```

## Arxitektura

```
ExpenseProiOS/
├── App/                     # Entry point, AppDelegate
├── Core/                    # DI, Theme, Network, Errors, Services
├── Router/                  # NavigationStack + TabView shell
├── Features/                # Clean Architecture (har bir feature)
│   ├── Auth/
│   │   ├── Data/            (DataSource, Repository impl, Models)
│   │   ├── Domain/          (Entity, Repository protocol, UseCase)
│   │   └── Presentation/    (ViewModel, View)
│   ├── Main/
│   ├── Home/
│   ├── Finance/
│   ├── Goals/
│   ├── AddExpense/
│   └── Profile/
└── Resources/               # Localizable.xcstrings, Assets, Info.plist
```

## Texnologiyalar

- **UI:** SwiftUI + Combine
- **Backend:** Supabase (supabase-swift)
- **DI:** Swinject
- **Local storage:** KeychainAccess (token) + UserDefaults/FileManager (preferences)
- **Image:** Kingfisher
- **Lokalizatsiya:** String Catalog (`.xcstrings`) — en, ru, uz, fr

## Keyingi qadamlar

- [ ] Har bir feature uchun `Data` qatlamini Supabase'ga ulash
- [ ] BLoC → `@Observable` ViewModel migratsiyasi
- [ ] `flutter_gen` assetlari → `Assets.xcassets`
- [ ] `make gen` ekvivalenti kerak emas (Swift'da build-time codegen yo'q)

---

# iOS Roadmap — to'liq o'rganish yo'li

Flutter/Dart dan kelgan dasturchi uchun iOS (Swift + SwiftUI) ni 0 dan professional darajagacha o'rganish yo'li. Har bir bosqich oldingisining ustiga quriladi.

## Bosqich 0 — Tayyorgarlik (1 hafta)

- [ ] **Xcode** o'rnatish (App Store)
- [ ] **Command Line Tools:** `xcode-select --install`
- [ ] **Homebrew** + `brew install xcodegen cocoapods swiftlint swiftformat`
- [ ] **Apple Developer** akkaunt (bepul — simulyator uchun yetadi)
- [ ] Xcode interfeysini o'rganish: Navigator, Inspector, Console, Simulator

**Natija:** Simulyator'da "Hello World" app ishga tushadi.

## Bosqich 1 — Swift tili (2–3 hafta)

### 1.1 Asoslar
- [ ] `var` / `let`, type inference
- [ ] Optional (`?`, `!`, `if let`, `guard let`, `??`)
- [ ] `struct` vs `class` (value vs reference semantics)
- [ ] `enum` — associated values, raw values
- [ ] Funksiyalar, closures, trailing closure sintaksisi

### 1.2 O'rta daraja
- [ ] Protocol va protocol-oriented programming (POP)
- [ ] Generics (`<T>`, `where` clause)
- [ ] Extensions
- [ ] Error handling: `throws`, `try`, `do-catch`, `Result<Success, Failure>`
- [ ] Property wrappers (`@State`, `@Published`)

### 1.3 Rivojlangan
- [ ] `async/await`, `Task`, `actor`, `@MainActor`
- [ ] Access control: `private`, `fileprivate`, `internal`, `public`, `open`
- [ ] ARC, `weak`, `unowned`, retain cycles
- [ ] Key paths (`\.property`)

**Manba:** [Swift.org Tour](https://docs.swift.org/swift-book/), [Hacking with Swift — 100 Days of Swift](https://www.hackingwithswift.com/100).

## Bosqich 2 — SwiftUI asoslari (3–4 hafta)

### 2.1 View va Layout
- [ ] `View` protocol, `some View`, `@ViewBuilder`
- [ ] `VStack`, `HStack`, `ZStack`, `Spacer`, `Group`
- [ ] Modifier'lar zanjiri — tartib muhim
- [ ] `Text`, `Image`, `Button`, `TextField`, `Toggle`, `Picker`
- [ ] `List`, `ForEach`, `ScrollView`, `LazyVStack`, `LazyHGrid`

### 2.2 State Management
- [ ] `@State` — lokal o'zgaruvchan holat
- [ ] `@Binding` — parent ↔ child bog'lanish
- [ ] `@StateObject` vs `@ObservedObject`
- [ ] `@EnvironmentObject` — DI orqali uzatish
- [ ] `@Environment` (dismiss, colorScheme, locale)
- [ ] Yangi `@Observable` makrosi (iOS 17+)

### 2.3 Navigation
- [ ] `NavigationStack` + `navigationDestination(for:)`
- [ ] `NavigationPath` — type-erased stack
- [ ] `TabView` + `.tag()`
- [ ] `.sheet`, `.fullScreenCover`, `.alert`, `.confirmationDialog`
- [ ] Deep linking — `onOpenURL`

**Amaliyot:** Ushbu ExpenseProiOS loyihasidagi `Router/` papkasini tahlil qiling.

## Bosqich 3 — Arxitektura (2 hafta)

- [ ] **MVVM** + SwiftUI
- [ ] **Clean Architecture:** Data / Domain / Presentation qatlamlari
- [ ] **Dependency Injection** — Swinject yoki qo'lda
- [ ] **Coordinator / Router** pattern
- [ ] **Repository** + **UseCase** patternlari

**Amaliyot:** Ushbu loyihada `Features/Auth/` qatlamini o'rganing.

## Bosqich 4 — Asinxronlik va Reaktivlik (2 hafta)

- [ ] **Combine:** `Publisher`, `Subscriber`, `@Published`, `sink`, `assign`
- [ ] Operatorlar: `map`, `filter`, `flatMap`, `debounce`, `combineLatest`
- [ ] `AnyCancellable` va xotira boshqaruvi
- [ ] **Swift Concurrency:** `async let`, `TaskGroup`, `AsyncSequence`
- [ ] `URLSession` async API
- [ ] Flutter solishtiruvi: Stream/Future → AsyncSequence/Task

## Bosqich 5 — Tarmoq va Ma'lumot (2 hafta)

### Tarmoq
- [ ] `URLSession` — GET, POST, JSON
- [ ] `Codable`, `JSONEncoder`, `JSONDecoder`, `CodingKeys`
- [ ] **Alamofire** (ixtiyoriy, loyihada bor)
- [ ] **Supabase Swift SDK** (loyihada ishlatiladi)
- [ ] Auth token refresh, interceptor pattern

### Lokal saqlash
- [ ] `UserDefaults` — oddiy sozlamalar
- [ ] **Keychain** — maxfiy ma'lumotlar (KeychainAccess)
- [ ] **FileManager** — fayllar
- [ ] **Core Data** yoki **SwiftData** (iOS 17+) — kattaroq bazalar
- [ ] **SQLite / GRDB** — SQL kerak bo'lsa

## Bosqich 6 — UI/UX chuqurlashtirish (2 hafta)

- [ ] **Animatsiyalar:** `.animation`, `withAnimation`, `matchedGeometryEffect`
- [ ] **Gestures:** `TapGesture`, `DragGesture`, `LongPressGesture`
- [ ] **Custom Shapes, Paths, Canvas**
- [ ] **GeometryReader** va responsive layout
- [ ] **Accessibility** — VoiceOver, Dynamic Type
- [ ] **Lokalizatsiya** — String Catalog (`.xcstrings`)
- [ ] **Dark Mode**, `@Environment(\.colorScheme)`
- [ ] **SF Symbols** — tizim ikonlari

## Bosqich 7 — Qurilma imkoniyatlari (1–2 hafta)

- [ ] **Camera / PhotoPicker** — `PhotosUI`
- [ ] **Location** — `CoreLocation`
- [ ] **Notifications** — local va push (APNs, FCM)
- [ ] **Biometrics** — `LocalAuthentication` (FaceID/TouchID)
- [ ] **Haptics** — `UIFeedbackGenerator`
- [ ] **Background tasks**
- [ ] **App Intents / Shortcuts** (iOS 16+)
- [ ] **Widgets** (WidgetKit)

## Bosqich 8 — Sifat va Test (2 hafta)

- [ ] **XCTest** — unit test
- [ ] **Swift Testing** (yangi framework, iOS 17+)
- [ ] **XCUITest** — UI test
- [ ] **Snapshot testing** — pointfreeco/swift-snapshot-testing
- [ ] **Mock'lar** — protocol orqali
- [ ] **Instruments** — profiling, memory leak, Time Profiler
- [ ] **SwiftLint** / **SwiftFormat** — kod sifati

## Bosqich 9 — Release va CI/CD (1 hafta)

- [ ] **Code signing**, Provisioning Profiles
- [ ] **App Store Connect** — build yuklash
- [ ] **TestFlight** — beta test
- [ ] **Fastlane** — avtomatlashtirish
- [ ] **GitHub Actions** / **Xcode Cloud** — CI/CD
- [ ] **App Store Review Guidelines**

## Bosqich 10 — Professional darajasi (doimiy)

- [ ] **Swift Package Manager (SPM)** — modulyar arxitektura
- [ ] **UIKit interop** — `UIViewRepresentable`, `UIViewControllerRepresentable`
- [ ] **Metal / SceneKit / RealityKit** (agar kerak bo'lsa)
- [ ] **WatchOS**, **iPadOS**, **macOS** (Catalyst)
- [ ] **Performance** — RunLoop, render hook, Instruments
- [ ] **Xavfsizlik** — ATS, certificate pinning, jailbreak detection
- [ ] **Open Source** — GitHub'da hissa qo'shing

## Flutter → iOS tarjimon jadvali

| Flutter | iOS (SwiftUI) |
|---|---|
| `Widget` | `View` |
| `StatelessWidget` | `struct View` |
| `StatefulWidget` + `setState` | `@State` |
| `Provider` / `Riverpod` | `@StateObject` + `@EnvironmentObject` |
| `BLoC` | `ObservableObject` + Combine |
| `GoRouter` | `NavigationStack` + `AppRouter` |
| `Future<T>` | `async throws -> T` |
| `Stream<T>` | `AsyncSequence` / `Publisher` |
| `Dio` / `http` | `URLSession` / Alamofire |
| `shared_preferences` | `UserDefaults` |
| `flutter_secure_storage` | `Keychain` |
| `get_it` / `injectable` | `Swinject` |
| `freezed` / `json_serializable` | `Codable` (til darajasida) |
| `intl` / `.arb` | `String Catalog` (`.xcstrings`) |
| `pubspec.yaml` | `Podfile` + `Package.swift` |

## Tavsiya etilgan manbalar

- **Rasmiy:** [developer.apple.com](https://developer.apple.com/tutorials/swiftui), [Swift Book](https://docs.swift.org/swift-book/)
- **Videolar:** WWDC sessiyalari (developer.apple.com/videos)
- **Kurslar:** Stanford CS193p (YouTube, bepul), Paul Hudson — "Hacking with Swift"
- **Kitoblar:** *SwiftUI by Tutorials* (Kodeco), *Advanced Swift* (objc.io)
- **Hamjamiyat:** Swift Forums, r/swift, iOS Dev Weekly (newsletter)
- **Amaliyot:** LeetCode (Swift), ushbu ExpenseProiOS loyihasi

## Umumiy taymlayn

| Bosqich | Vaqt | Natija |
|---|---|---|
| 0–1 | 3–4 hafta | Swift tilini bilaman |
| 2–3 | 5–6 hafta | SwiftUI'da app yoza olaman |
| 4–5 | 4 hafta | Real backend bilan ishlay olaman |
| 6–7 | 3–4 hafta | Sifatli UI + qurilma funksiyalari |
| 8–9 | 3 hafta | Test yozaman, App Store'ga chiqaraman |
| 10 | Doimiy | Professional, komandada ishlay olaman |

**Jami:** ~5–6 oy intensiv mashq (kuniga 2–3 soat).

