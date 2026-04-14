import Foundation

protocol UseCase {
    associatedtype Params
    associatedtype Success

    func callAsFunction(_ params: Params) async -> FailureOr<Success>
}

struct NoParams { static let value = NoParams() }
