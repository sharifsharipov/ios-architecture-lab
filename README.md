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
# ios-architecture-lab
