import Foundation

protocol GoalsInteractorInput: AnyObject {
    func loadGoals() async
}

protocol GoalsInteractorOutput: AnyObject {
    func interactor(didLoad goals: [GoalEntity])
    func interactor(didFail error: AppFailure)
}

final class GoalsInteractor: GoalsInteractorInput {
    weak var output: GoalsInteractorOutput?
    private let repository: GoalsRepository

    init(repository: GoalsRepository) { self.repository = repository }

    func loadGoals() async {
        switch await repository.fetchAll() {
        case .right(let xs): await MainActor.run { output?.interactor(didLoad: xs) }
        case .left(let f):   await MainActor.run { output?.interactor(didFail: f) }
        }
    }
}
