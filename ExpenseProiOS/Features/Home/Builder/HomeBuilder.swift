import SwiftUI

// MARK: - VIPER: Builder
// Module'ni yig'adi. Interactor -> Presenter -> Router -> View bog'lanishi.

@MainActor
enum HomeBuilder {
    static func build(appRouter: AppRouter) -> some View {
        let di = DIContainer.shared
        let interactor = HomeInteractor(
            getSummary: di.resolve(GetHomeSummaryUseCase.self),
            repository: di.resolve(HomeRepository.self)
        )
        let router = HomeRouter(appRouter: appRouter)
        let presenter = HomePresenter(interactor: interactor, router: router)
        interactor.output = presenter
        return HomeView(presenter: presenter)
    }
}
