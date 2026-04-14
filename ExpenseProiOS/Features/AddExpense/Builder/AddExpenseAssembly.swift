import Foundation
import Swinject

enum AddExpenseAssembly {
    static func assemble(container: Container) {
        container.register(AddExpenseRepository.self) { r in
            AddExpenseRepositoryImpl(provider: r.resolve(SupabaseProvider.self)!)
        }
    }
}
