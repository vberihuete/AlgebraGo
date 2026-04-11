import SwiftUI

struct AvatarOption: View {
    let index: Int
    let isSelected: Bool
    let onSelect: () -> Void

    var body: some View {
        Button(action: onSelect) {
            VStack(spacing: Spacing.xs) {
                ZStack {
                    Circle()
                        .fill(isSelected ? Color.AG.accent : Color.AG.lightAccent)
                        .frame(width: 70, height: 70)

                    Image(systemName: avatarIcon(index))
                        .font(.system(size: 28))
                        .foregroundColor(isSelected ? .white : Color.AG.accent)
                }

                if isSelected {
                    Circle()
                        .fill(Color.AG.accent)
                        .frame(width: 8, height: 8)
                }
            }
        }
        .accessibilityLabel("Avatar \(index)")
        .accessibilityAddTraits(isSelected ? .isSelected : [])
    }
}

struct SelectionRow: View {
    let title: String
    let subtitle: String
    let isSelected: Bool
    let onSelect: () -> Void

    var body: some View {
        Button(action: onSelect) {
            HStack {
                VStack(alignment: .leading, spacing: Spacing.xxs) {
                    Text(title)
                        .font(.AG.bodyBold)
                        .foregroundColor(Color.AG.primaryText)
                    Text(subtitle)
                        .font(.AG.caption)
                        .foregroundColor(Color.AG.secondaryText)
                }

                Spacer()

                Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(isSelected ? Color.AG.accent : Color.AG.secondaryText)
                    .font(.title2)
            }
            .padding(Spacing.md)
            .background(isSelected ? Color.AG.lightAccent : Color.AG.cardBackground)
            .cornerRadius(Spacing.cardCornerRadius)
            .overlay(
                RoundedRectangle(cornerRadius: Spacing.cardCornerRadius)
                    .stroke(isSelected ? Color.AG.accent : Color.clear, lineWidth: 2)
            )
        }
        .accessibilityLabel("\(title), \(subtitle)")
        .accessibilityAddTraits(isSelected ? .isSelected : [])
    }
}
