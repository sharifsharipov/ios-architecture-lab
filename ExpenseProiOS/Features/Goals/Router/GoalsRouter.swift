import Foundation

protocol GoalsRouterInput: AnyObject {
    func openDetail(id: String)
}

@MainActor
final class GoalsRouter: GoalsRouterInput {
    weak var appRouter: AppRouter?
    init(appRouter: AppRouter) { self.appRouter = appRouter }

    func openDetail(id: String) {
        appRouter?.push(.goalsDescription(id: id), in: .goals)
    }
}
