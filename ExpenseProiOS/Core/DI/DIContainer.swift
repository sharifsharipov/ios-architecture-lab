import Foundation
import Swinject

// Flutter `GetIt + injectable` ekvivalenti. `DIContainer.shared.resolve(T.self)`.

final class DIContainer {
    static let shared = DIContainer()
    let container = Container()

    private init() {}

    func registerAll() {
        registerCore()
        registerFeatures()
    }

    private func registerCore() {
        container.register(AppConfig.self) { _ in AppConfig.default }.inObjectScope(.container)

        container.register(LocalSourceProtocol.self) { _ in LocalSource() }
            .inObjectScope(.container)

        container.register(NetworkMonitorProtocol.self) { _ in NetworkMonitor() }
            .inObjectScope(.container)

        container.register(SupabaseProvider.self) { r in
            SupabaseProvider(config: r.resolve(AppConfig.self)!)
        }.inObjectScope(.container)
    }

    private func registerFeatures() {
        AuthAssembly.assemble(container: container)
        HomeAssembly.assemble(container: container)
        FinanceAssembly.assemble(container: container)
        GoalsAssembly.assemble(container: container)
        AddExpenseAssembly.assemble(container: container)
        ProfileAssembly.assemble(container: container)
    }

    func resolve<T>(_ type: T.Type) -> T {
        guard let v = container.resolve(type) else {
            fatalError("DI: \(type) ro'yxatga olinmagan")
        }
        return v
    }
}
