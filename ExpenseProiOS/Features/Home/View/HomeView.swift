import SwiftUI

// MARK: - VIPER: View
// Passiv. Faqat Presenter state'ni ko'rsatadi va event'larni uzatadi.

struct HomeView: View {
    @StateObject private var presenter: HomePresenter

    init(presenter: HomePresenter) {
        _presenter = StateObject(wrappedValue: presenter)
    }

    var body: some View {
        Group {
            switch presenter.state.phase {
            case .loading where presenter.state.summary == .empty:
                LoadingView()
            case .error(let msg) where presenter.state.summary == .empty:
                ErrorView(message: msg) {
                    Task { await presenter.refresh() }
                }
            default:
                content
            }
        }
        .navigationTitle(String(localized: "home"))
        .onAppear { presenter.onAppear() }
        .refreshable { await presenter.refresh() }
    }

    private var content: some View {
        ScrollView {
            VStack(spacing: AppTheme.Spacing.lg) {
                balanceCard
                actions
                recentSection
            }
            .padding(AppTheme.Spacing.lg)
        }
    }

    private var balanceCard: some View {
        CardView(background: AppTheme.accent.opacity(0.08)) {
            VStack(alignment: .leading, spacing: AppTheme.Spacing.sm) {
                Text(String(localized: "balance"))
                    .font(.caption).foregroundStyle(.secondary)
                Text("\(presenter.state.summary.balance) \(presenter.state.summary.currency)")
                    .font(.largeTitle.bold())
                HStack {
                    amountLabel("income", value: presenter.state.summary.income, color: AppTheme.success)
                    Spacer()
                    amountLabel("expense", value: presenter.state.summary.expense, color: AppTheme.danger)
                }
            }
        }
    }

    private func amountLabel(_ key: String.LocalizationValue, value: Decimal, color: Color) -> some View {
        VStack(alignment: .leading) {
            Text(String(localized: key)).font(.caption2).foregroundStyle(.secondary)
            Text("\(value)").foregroundStyle(color).font(.subheadline.bold())
        }
    }

    private var actions: some View {
        PrimaryButton(
            title: String(localized: "addExpense"),
            icon: "plus.circle.fill",
            action: presenter.didTapAddExpense
        )
    }

    private var recentSection: some View {
        VStack(alignment: .leading, spacing: AppTheme.Spacing.sm) {
            SectionHeader(title: String(localized: "recent"))
            if presenter.state.summary.recent.isEmpty {
                EmptyStateView(
                    title: String(localized: "noTransactions"),
                    systemImage: "tray",
                    subtitle: nil
                )
            } else {
                ForEach(presenter.state.summary.recent) { tx in
                    Button { presenter.didTapTransaction(tx.id) } label: {
                        TransactionRow(tx: tx)
                    }
                    .buttonStyle(.plain)
                }
            }
        }
    }
}

struct TransactionRow: View {
    let tx: TransactionEntity

    var body: some View {
        HStack {
            Image(systemName: tx.kind == .income ? "arrow.down.circle.fill" : "arrow.up.circle.fill")
                .foregroundStyle(tx.kind == .income ? AppTheme.success : AppTheme.danger)
                .font(.title2)
            VStack(alignment: .leading) {
                Text(tx.title).font(.subheadline.bold())
                if let cat = tx.category {
                    Text(cat).font(.caption).foregroundStyle(.secondary)
                }
            }
            Spacer()
            Text("\(tx.amount) \(tx.currency)")
                .font(.subheadline.bold())
                .foregroundStyle(tx.kind == .income ? AppTheme.success : AppTheme.danger)
        }
        .padding(.vertical, AppTheme.Spacing.sm)
    }
}

struct HomeDescriptionView: View {
    let id: String
    var body: some View {
        Text("Transaction \(id)")
            .navigationTitle(String(localized: "details"))
    }
}
