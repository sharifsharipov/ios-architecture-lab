import SwiftUI

struct FinanceView: View {
    @StateObject private var presenter: FinancePresenter

    init(presenter: FinancePresenter) {
        _presenter = StateObject(wrappedValue: presenter)
    }

    var body: some View {
        Group {
            switch presenter.state.phase {
            case .loading where presenter.state.records.isEmpty:
                LoadingView()
            case .error(let msg) where presenter.state.records.isEmpty:
                ErrorView(message: msg) {
                    Task { await presenter.refresh() }
                }
            default:
                list
            }
        }
        .navigationTitle(String(localized: "finance"))
        .onAppear { presenter.onAppear() }
        .refreshable { await presenter.refresh() }
    }

    private var list: some View {
        List {
            if presenter.state.records.isEmpty {
                EmptyStateView(
                    title: String(localized: "finance"),
                    systemImage: "chart.pie",
                    subtitle: String(localized: "financeDescriptionPage")
                )
            } else {
                ForEach(presenter.state.records) { r in
                    Button { presenter.didTapRecord(r.id) } label: {
                        HStack {
                            Text(r.title)
                            Spacer()
                            Text("\(r.amount) \(r.currency)").foregroundStyle(.secondary)
                        }
                    }
                }
            }
        }
    }
}

struct FinanceDescriptionView: View {
    let id: String
    var body: some View {
        Text("Finance \(id)").navigationTitle(String(localized: "details"))
    }
}
