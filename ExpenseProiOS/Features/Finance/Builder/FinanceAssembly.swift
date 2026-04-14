import Foundation
import Swinject

enum FinanceAssembly {
    static func assemble(container: Container) {
        container.register(FinanceRepository.self) { r in
            FinanceRepositoryImpl(provider: r.resolve(SupabaseProvider.self)!)
        }
    }
}
