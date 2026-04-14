import SwiftUI

@MainActor
enum FinanceBuilder {
    static func build(appRouter: AppRouter) -> some View {
        let di = DIContainer.shared
        let interactor = FinanceInteractor(repository: di.resolve(FinanceRepository.self))
        let router = FinanceRouter(appRouter: appRouter)
        let presenter = FinancePresenter(interactor: interactor, router: router)
        interactor.output = presenter
        return FinanceView(presenter: presenter)
    }
}
