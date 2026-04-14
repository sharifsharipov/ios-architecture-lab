import SwiftUI

struct GoalsView: View {
    @StateObject private var presenter: GoalsPresenter

    init(presenter: GoalsPresenter) {
        _presenter = StateObject(wrappedValue: presenter)
    }

    var body: some View {
        Group {
            switch presenter.state.phase {
            case .loading where presenter.state.goals.isEmpty:
                LoadingView()
            case .error(let msg) where presenter.state.goals.isEmpty:
                ErrorView(message: msg) { Task { await presenter.refresh() } }
            default:
                list
            }
        }
        .navigationTitle(String(localized: "goals"))
        .onAppear { presenter.onAppear() }
        .refreshable { await presenter.refresh() }
    }

    private var list: some View {
        List {
            if presenter.state.goals.isEmpty {
                EmptyStateView(
                    title: String(localized: "goals"),
                    systemImage: "target",
                    subtitle: String(localized: "goalsDescription")
                )
            } else {
                ForEach(presenter.state.goals) { g in
                    Button { presenter.didTapGoal(g.id) } label: {
                        VStack(alignment: .leading, spacing: 6) {
                            Text(g.title).font(.headline)
                            ProgressView(value: g.progress)
                            Text("\(g.savedAmount) / \(g.targetAmount) \(g.currency)")
                                .font(.caption).foregroundStyle(.secondary)
                        }
                    }
                    .buttonStyle(.plain)
                }
            }
        }
    }
}

struct GoalsDescriptionView: View {
    let id: String
    var body: some View {
        Text("Goal \(id)").navigationTitle(String(localized: "details"))
    }
}
