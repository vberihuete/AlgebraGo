import SwiftUI

struct CardView<Content: View>: View {
    let content: () -> Content

    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }

    var body: some View {
        content()
            .padding(Spacing.md)
            .background(Color.AG.cardBackground)
            .cornerRadius(Spacing.cardCornerRadius)
            .shadow(color: .black.opacity(0.06), radius: 8, x: 0, y: 2)
    }
}

struct ProgressBarView: View {
    let progress: Double
    var height: CGFloat = 8
    var backgroundColor: Color = Color.AG.progressBarBackground
    var foregroundColor: Color = Color.AG.accent

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: height / 2)
                    .fill(backgroundColor)
                    .frame(height: height)

                RoundedRectangle(cornerRadius: height / 2)
                    .fill(foregroundColor)
                    .frame(width: geometry.size.width * min(max(progress, 0), 1), height: height)
                    .animation(.easeInOut(duration: 0.3), value: progress)
            }
        }
        .frame(height: height)
        .accessibilityLabel("Progreso: \(Int(progress * 100))%")
    }
}

struct LevelHeaderView: View {
    let level: Int
    let points: Int
    let levelName: String
    let progress: Double

    var body: some View {
        VStack(spacing: Spacing.xs) {
            HStack {
                HStack(spacing: Spacing.xs) {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                    Text("Nivel \(level): \(levelName)")
                        .font(.AG.caption)
                        .foregroundColor(Color.AG.primaryText)
                }
                Spacer()
                Text("\(points) pts")
                    .font(.AG.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(Color.AG.accent)
            }
            ProgressBarView(progress: progress, height: 6)
        }
        .padding(.horizontal, Spacing.screenHorizontal)
        .padding(.vertical, Spacing.xs)
    }
}

struct ConfettiView: View {
    @State private var particles: [(id: Int, x: CGFloat, y: CGFloat, color: Color, rotation: Double)] = []
    @State private var isAnimating = false

    let colors: [Color] = [.red, .blue, .green, .yellow, .orange, .purple, .pink]

    var body: some View {
        ZStack {
            ForEach(particles, id: \.id) { particle in
                Rectangle()
                    .fill(particle.color)
                    .frame(width: 8, height: 8)
                    .rotationEffect(.degrees(particle.rotation))
                    .position(x: particle.x, y: particle.y)
            }
        }
        .allowsHitTesting(false)
        .onAppear {
            createParticles()
            withAnimation(.easeOut(duration: 2.0)) {
                isAnimating = true
            }
        }
    }

    private func createParticles() {
        let screenWidth = UIScreen.main.bounds.width
        particles = (0..<40).map { i in
            (
                id: i,
                x: CGFloat.random(in: 0...screenWidth),
                y: CGFloat.random(in: -100...(-20)),
                color: colors.randomElement()!,
                rotation: Double.random(in: 0...360)
            )
        }

        // Animate falling
        withAnimation(.easeIn(duration: 2.0)) {
            for i in particles.indices {
                particles[i].y = CGFloat.random(in: 400...800)
                particles[i].rotation += Double.random(in: 180...720)
            }
        }
    }
}
