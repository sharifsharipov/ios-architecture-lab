import SwiftUI

@MainActor
enum AddExpenseBuilder {
    static func build(editingId: String?) -> some View {
        let di = DIContainer.shared
        let interactor = AddExpenseInteractor(repository: di.resolve(AddExpenseRepository.self))
        let router = AddExpenseRouter()
        let presenter = AddExpensePresenter(editingId: editingId, interactor: interactor, router: router)
        interactor.output = presenter
        return AddExpenseView(presenter: presenter)
    }
}
