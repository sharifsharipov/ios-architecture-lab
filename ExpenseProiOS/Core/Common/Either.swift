import Foundation

// Flutter loyihasidagi Either<AppFailure, T> monadasining Swift ekvivalenti.
// Native `Result<Success, AppFailure>` mavjud, lekin API nomini mos keltirish uchun
// yengil wrapper taqdim etamiz.

enum Either<L, R> {
    case left(L)
    case right(R)

    var isRight: Bool {
        if case .right = self { return true }
        return false
    }

    var isLeft: Bool {
        if case .left = self { return true }
        return false
    }

    var rightValue: R? {
        if case .right(let v) = self { return v }
        return nil
    }

    var leftValue: L? {
        if case .left(let v) = self { return v }
        return nil
    }

    func map<T>(_ transform: (R) -> T) -> Either<L, T> {
        switch self {
        case .left(let l): return .left(l)
        case .right(let r): return .right(transform(r))
        }
    }

    func flatMap<T>(_ transform: (R) -> Either<L, T>) -> Either<L, T> {
        switch self {
        case .left(let l): return .left(l)
        case .right(let r): return transform(r)
        }
    }

    func fold<T>(left: (L) -> T, right: (R) -> T) -> T {
        switch self {
        case .left(let l): return left(l)
        case .right(let r): return right(r)
        }
    }
}

typealias FailureOr<T> = Either<AppFailure, T>
