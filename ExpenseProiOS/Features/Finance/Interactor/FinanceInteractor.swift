import Foundation

protocol FinanceInteractorInput: AnyObject {
    func loadRecords() async
}

protocol FinanceInteractorOutput: AnyObject {
    func interactor(didLoad records: [FinanceRecordEntity])
    func interactor(didFail error: AppFailure)
}

final class FinanceInteractor: FinanceInteractorInput {
    weak var output: FinanceInteractorOutput?
    private let repository: FinanceRepository

    init(repository: FinanceRepository) { self.repository = repository }

    func loadRecords() async {
        let r = await repository.fetchAll()
        switch r {
        case .right(let xs): await MainActor.run { output?.interactor(didLoad: xs) }
        case .left(let f):   await MainActor.run { output?.interactor(didFail: f) }
        }
    }
}
