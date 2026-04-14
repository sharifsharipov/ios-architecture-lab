import Foundation
import Swinject

enum GoalsAssembly {
    static func assemble(container: Container) {
        container.register(GoalsRepository.self) { r in
            GoalsRepositoryImpl(provider: r.resolve(SupabaseProvider.self)!)
        }
    }
}
