import SwiftUI

@MainActor
enum GoalsBuilder {
    static func build(appRouter: AppRouter) -> some View {
        let di = DIContainer.shared
        let interactor = GoalsInteractor(repository: di.resolve(GoalsRepository.self))
        let router = GoalsRouter(appRouter: appRouter)
        let presenter = GoalsPresenter(interactor: interactor, router: router)
        interactor.output = presenter
        return GoalsView(presenter: presenter)
    }
}
