import SwiftUI

struct AddExpenseView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var presenter: AddExpensePresenter

    init(presenter: AddExpensePresenter) {
        _presenter = StateObject(wrappedValue: presenter)
    }

    var body: some View {
        Form {
            Section {
                AppTextField(
                    title: String(localized: "title"),
                    text: Binding(get: { presenter.state.draft.title },
                                  set: { presenter.state.draft.title = $0 })
                )
                TextField(String(localized: "amount"),
                          value: Binding(get: { presenter.state.draft.amount },
                                         set: { presenter.state.draft.amount = $0 }),
                          format: .number)
                    .keyboardType(.decimalPad)
                Picker(String(localized: "type"),
                       selection: Binding(get: { presenter.state.draft.kind },
                                          set: { presenter.state.draft.kind = $0 })) {
                    Text(String(localized: "income")).tag(TransactionEntity.Kind.income)
                    Text(String(localized: "expense")).tag(TransactionEntity.Kind.expense)
                }
                DatePicker(String(localized: "date"),
                           selection: Binding(get: { presenter.state.draft.date },
                                              set: { presenter.state.draft.date = $0 }),
                           displayedComponents: .date)
            }

            Section {
                TextField(String(localized: "category"), text: Binding(
                    get: { presenter.state.draft.category ?? "" },
                    set: { presenter.state.draft.category = $0.isEmpty ? nil : $0 }
                ))
                TextField(String(localized: "note"), text: Binding(
                    get: { presenter.state.draft.note ?? "" },
                    set: { presenter.state.draft.note = $0.isEmpty ? nil : $0 }
                ), axis: .vertical)
            }

            if let err = presenter.state.errorMessage {
                Section { Text(err).foregroundColor(AppTheme.danger) }
            }
        }
        .navigationTitle(String(localized: "addExpense"))
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button(String(localized: "save"), action: presenter.didTapSave)
                    .disabled(presenter.state.isSaving)
            }
        }
        .onChange(of: presenter.state.didSave) { saved in
            if saved { dismiss() }
        }
    }
}
