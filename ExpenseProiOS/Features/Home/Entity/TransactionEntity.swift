import Foundation

struct TransactionEntity: Identifiable, Equatable {
    enum Kind: String, Codable { case income, expense }

    let id: String
    let title: String
    let amount: Decimal
    let currency: String
    let kind: Kind
    let date: Date
    let category: String?
    let note: String?
}

struct HomeSummary: Equatable {
    let balance: Decimal
    let income: Decimal
    let expense: Decimal
    let currency: String
    let recent: [TransactionEntity]

    static let empty = HomeSummary(balance: 0, income: 0, expense: 0, currency: "UZS", recent: [])
}
