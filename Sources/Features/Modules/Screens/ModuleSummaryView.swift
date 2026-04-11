import SwiftUI

struct ModuleSummaryView: View {
    let module: ModuleContent
    let score: Double
    let timeSpent: Int
    let pointsEarned: Int
    let bonusAwarded: Bool
    let onDismiss: () -> Void

    @State private var showConfetti = false

    var body: some View {
        ZStack {
            Color.AG.background.ignoresSafeArea()

            VStack(spacing: Spacing.xl) {
                Spacer()

                // Score circle
                ZStack {
                    Circle()
                        .stroke(Color.AG.progressBarBackground, lineWidth: 8)
                        .frame(width: 120, height: 120)

                    Circle()
                        .trim(from: 0, to: score)
                        .stroke(
                            score >= 0.75 ? Color.AG.success : Color.AG.accent,
                            style: StrokeStyle(lineWidth: 8, lineCap: .round)
                        )
                        .frame(width: 120, height: 120)
                        .rotationEffect(.degrees(-90))

                    VStack {
                        Text("\(Int(score * 100))%")
                            .font(.AG.largeTitle)
                            .foregroundColor(Color.AG.primaryText)
                    }
                }

                Text(score >= 0.75 ? "¡Excelente trabajo!" : "Buen esfuerzo")
                    .font(.AG.title)
                    .foregroundColor(Color.AG.primaryText)

                Text("Módulo \(module.unitNumber).\(module.moduleNumber): \(module.title)")
                    .font(.AG.body)
                    .foregroundColor(Color.AG.secondaryText)
                    .multilineTextAlignment(.center)

                // Stats
                CardView {
                    VStack(spacing: Spacing.md) {
                        HStack {
                            Label("Tiempo", systemImage: "clock")
                            Spacer()
                            Text(formatTime(timeSpent))
                        }
                        Divider()
                        HStack {
                            Label("Puntos ganados", systemImage: "star.fill")
                            Spacer()
                            Text("+\(pointsEarned) pts")
                                .foregroundColor(Color.AG.accent)
                                .fontWeight(.semibold)
                        }
                        if bonusAwarded {
                            Divider()
                            HStack {
                                Label("¡Bonus aleatorio!", systemImage: "sparkles")
                                    .foregroundColor(.orange)
                                Spacer()
                                Text("+5 pts")
                                    .foregroundColor(.orange)
                                    .fontWeight(.semibold)
                            }
                        }
                    }
                    .font(.AG.body)
                    .foregroundColor(Color.AG.primaryText)
                }
                .padding(.horizontal, Spacing.screenHorizontal)

                Spacer()

                PrimaryButton(title: "Continuar") {
                    onDismiss()
                }
                .padding(.horizontal, Spacing.screenHorizontal)
                .padding(.bottom, Spacing.xl)
            }

            if showConfetti {
                ConfettiView()
                    .ignoresSafeArea()
            }
        }
        .onAppear {
            if score >= 0.75 {
                showConfetti = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    showConfetti = false
                }
            }
        }
    }

    private func formatTime(_ seconds: Int) -> String {
        let mins = seconds / 60
        let secs = seconds % 60
        return String(format: "%d:%02d", mins, secs)
    }
}
