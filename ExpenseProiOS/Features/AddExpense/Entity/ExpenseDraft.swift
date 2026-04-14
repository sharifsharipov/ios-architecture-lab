import Foundation

struct ExpenseDraft: Equatable {
    var title: String = ""
    var amount: Decimal = 0
    var currency: String = "UZS"
    var kind: TransactionEntity.Kind = .expense
    var date: Date = Date()
    var category: String? = nil
    var note: String? = nil
}
