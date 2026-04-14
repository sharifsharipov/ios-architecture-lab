import Foundation
import Swinject

enum ProfileAssembly {
    static func assemble(container: Container) {
        container.register(ProfileRepository.self) { r in
            ProfileRepositoryImpl(provider: r.resolve(SupabaseProvider.self)!)
        }
    }
}
