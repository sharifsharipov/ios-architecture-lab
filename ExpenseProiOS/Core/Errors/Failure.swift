import Foundation

protocol AppFailure: Error {
    var message: String { get }
}

struct ServerFailure: AppFailure {
    let message: String
    let statusCode: Int?

    init(message: String, statusCode: Int? = nil) {
        self.message = message
        self.statusCode = statusCode
    }
}

struct NetworkFailure: AppFailure {
    let message: String
    init(_ message: String = "No internet connection") { self.message = message }
}

struct UnauthorizedFailure: AppFailure {
    let message: String = "Unauthorized"
}

struct UnknownFailure: AppFailure {
    let message: String
    init(_ message: String = "Unexpected error") { self.message = message }
}

struct ValidationFailure: AppFailure {
    let message: String
    let field: String?

    init(message: String, field: String? = nil) {
        self.message = message
        self.field = field
    }
}
