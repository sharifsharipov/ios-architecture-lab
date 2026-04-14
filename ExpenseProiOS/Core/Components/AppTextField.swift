import SwiftUI
import UIKit

struct AppTextField: View {
    let title: String
    @Binding var text: String
    var placeholder: String = ""
    var keyboard: UIKeyboardType = .default
    var isSecure: Bool = false
    var icon: String? = nil
    var errorText: String? = nil

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            if !title.isEmpty {
                Text(title).font(.caption).foregroundStyle(.secondary)
            }
            HStack(spacing: 8) {
                if let icon {
                    Image(systemName: icon).foregroundStyle(.secondary)
                }
                Group {
                    if isSecure {
                        SecureField(placeholder, text: $text)
                    } else {
                        TextField(placeholder, text: $text)
                            .keyboardType(keyboard)
                    }
                }
                .textFieldStyle(.plain)
            }
            .padding(.horizontal, 14)
            .padding(.vertical, 12)
            .background(AppTheme.bgSecondary, in: RoundedRectangle(cornerRadius: AppTheme.Corner.md))
            .overlay(
                RoundedRectangle(cornerRadius: AppTheme.Corner.md)
                    .stroke(errorText == nil ? .clear : AppTheme.danger, lineWidth: 1)
            )
            if let errorText {
                Text(errorText).font(.caption2).foregroundStyle(AppTheme.danger)
            }
        }
    }
}
