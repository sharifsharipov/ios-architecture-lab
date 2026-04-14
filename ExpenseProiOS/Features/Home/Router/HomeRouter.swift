import Foundation

// MARK: - VIPER: Router
// Presenter'dan kelgan navigatsiya so'rovlarini AppRouter orqali amalga oshiradi.

protocol HomeRouterInput: AnyObject {
    func openTransaction(id: String)
    func openAddExpense()
}

@MainActor
final class HomeRouter: HomeRouterInput {
    weak var appRouter: AppRouter?

    init(appRouter: AppRouter) {
        self.appRouter = appRouter
    }

    func openTransaction(id: String) {
        appRouter?.push(.homeDescription(id: id), in: .home)
    }

    func openAddExpense() {
        appRouter?.push(.addExpense(editingId: nil), in: .home)
    }
}
