import Foundation
import SwiftUI

protocol AddExpenseRouterInput: AnyObject {
    func dismiss()
}

@MainActor
final class AddExpenseRouter: AddExpenseRouterInput {
    var dismissHandler: (() -> Void)?

    func dismiss() { dismissHandler?() }
}
