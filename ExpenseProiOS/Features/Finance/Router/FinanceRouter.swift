import Foundation

protocol FinanceRouterInput: AnyObject {
    func openDetail(id: String)
}

@MainActor
final class FinanceRouter: FinanceRouterInput {
    weak var appRouter: AppRouter?
    init(appRouter: AppRouter) { self.appRouter = appRouter }

    func openDetail(id: String) {
        appRouter?.push(.financeDescription(id: id), in: .finance)
    }
}
