import Foundation
import Swinject

enum HomeAssembly {
    static func assemble(container: Container) {
        container.register(HomeRepository.self) { r in
            HomeRepositoryImpl(provider: r.resolve(SupabaseProvider.self)!)
        }
        container.register(GetHomeSummaryUseCase.self) { r in
            GetHomeSummaryUseCase(repository: r.resolve(HomeRepository.self)!)
        }
    }
}
