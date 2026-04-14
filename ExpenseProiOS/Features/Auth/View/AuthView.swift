import SwiftUI

struct AuthCoordinatorView: View {
    var body: some View {
        NavigationStack {
            AuthBuilder.build()
        }
    }
}

struct AuthView: View {
    @StateObject private var presenter: AuthPresenter

    init(presenter: AuthPresenter) {
        _presenter = StateObject(wrappedValue: presenter)
    }

    var body: some View {
        VStack(spacing: AppTheme.Spacing.lg) {
            Text("ExpensePro").font(.largeTitle.bold()).padding(.top, 40)
            Text(String(localized: "welcomeMessage")).foregroundStyle(.secondary)

            Spacer()

            switch presenter.state.step {
            case .enterPhone:
                VStack(spacing: AppTheme.Spacing.md) {
                    AppTextField(
                        title: String(localized: "phoneNumber"),
                        text: Binding(
                            get: { presenter.state.phone },
                            set: { presenter.state.phone = $0 }
                        ),
                        placeholder: "+998 ...",
                        keyboard: .phonePad,
                        icon: "phone.fill"
                    )
                    PrimaryButton(
                        title: String(localized: "continue"),
                        isLoading: presenter.state.isLoading,
                        action: presenter.didTapRequestCode
                    )
                }
            case .enterCode:
                VStack(spacing: AppTheme.Spacing.md) {
                    AppTextField(
                        title: "OTP",
                        text: Binding(
                            get: { presenter.state.code },
                            set: { presenter.state.code = $0 }
                        ),
                        placeholder: "______",
                        keyboard: .numberPad,
                        icon: "lock.shield.fill"
                    )
                    PrimaryButton(
                        title: String(localized: "verify"),
                        isLoading: presenter.state.isLoading,
                        action: presenter.didTapVerify
                    )
                }
            }

            if let err = presenter.state.errorMessage {
                Text(err).foregroundColor(AppTheme.danger).font(.footnote)
            }

            Spacer()
        }
        .padding(AppTheme.Spacing.lg)
    }
}

struct LoginView: View {
    var body: some View { AuthBuilder.build() }
}
