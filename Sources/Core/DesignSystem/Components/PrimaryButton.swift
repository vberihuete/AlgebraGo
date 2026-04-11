import SwiftUI

struct PrimaryButton: View {
    let title: LocalizedStringKey
    var isEnabled: Bool = true
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.AG.button)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, Spacing.md)
                .background(isEnabled ? Color.AG.accent : Color.AG.secondaryText)
                .cornerRadius(Spacing.buttonCornerRadius)
        }
        .disabled(!isEnabled)
        .accessibilityLabel(title)
    }
}

struct SecondaryButton: View {
    let title: LocalizedStringKey
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.AG.button)
                .foregroundColor(Color.AG.accent)
                .frame(maxWidth: .infinity)
                .padding(.vertical, Spacing.md)
                .background(Color.AG.lightAccent)
                .cornerRadius(Spacing.buttonCornerRadius)
                .overlay(
                    RoundedRectangle(cornerRadius: Spacing.buttonCornerRadius)
                        .stroke(Color.AG.accent, lineWidth: 1.5)
                )
        }
        .accessibilityLabel(title)
    }
}
