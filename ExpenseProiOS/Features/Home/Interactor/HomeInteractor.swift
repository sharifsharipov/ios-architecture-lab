import Foundation

// MARK: - VIPER: Interactor
// Biznes logikani o'z ichiga oladi. Presenter'ga javob qaytaradi.

protocol HomeInteractorInput: AnyObject {
    func loadSummary() async
    func loadTransaction(id: String) async
}

protocol HomeInteractorOutput: AnyObject {
    func interactor(didLoad summary: HomeSummary)
    func interactor(didLoad transaction: TransactionEntity)
    func interactor(didFail error: AppFailure)
}

final class HomeInteractor: HomeInteractorInput {
    weak var output: HomeInteractorOutput?

    private let getSummary: GetHomeSummaryUseCase
    private let repository: HomeRepository

    init(getSummary: GetHomeSummaryUseCase, repository: HomeRepository) {
        self.getSummary = getSummary
        self.repository = repository
    }

    func loadSummary() async {
        let result = await getSummary(NoParams.value)
        switch result {
        case .right(let s): await MainActor.run { output?.interactor(didLoad: s) }
        case .left(let f):  await MainActor.run { output?.interactor(didFail: f) }
        }
    }

    func loadTransaction(id: String) async {
        let result = await repository.fetchTransaction(id: id)
        switch result {
        case .right(let tx): await MainActor.run { output?.interactor(didLoad: tx) }
        case .left(let f):   await MainActor.run { output?.interactor(didFail: f) }
        }
    }
}
