import Foundation

struct Badge: Codable, Identifiable, Hashable {
    var id: String
    var name: String
    var description: String
    var iconName: String
    var isUnlocked: Bool
    var unlockedDate: Date?
    var category: BadgeCategory

    enum BadgeCategory: String, Codable {
        case module       // Per-module completion
        case unit         // Full unit completion ("Maestro")
        case streak       // 3-day streak
        case perfect      // Perfect quiz score
    }
}

extension Badge {
    static let allBadges: [Badge] = {
        var badges: [Badge] = []

        // Module badges (12)
        let moduleNames = [
            ("m1_1", "Variables y Ecuaciones", "Completa el módulo 1.1", "x.squareroot"),
            ("m1_2", "Ecuaciones Lineales", "Completa el módulo 1.2", "equal"),
            ("m1_3", "Fracciones y Paréntesis", "Completa el módulo 1.3", "divide"),
            ("m1_4", "Aplicaciones Lineales", "Completa el módulo 1.4", "lightbulb"),
            ("m2_1", "Polinomios", "Completa el módulo 2.1", "function"),
            ("m2_2", "Suma y Resta", "Completa el módulo 2.2", "plus.forwardslash.minus"),
            ("m2_3", "Factorización", "Completa el módulo 2.3", "star"),
            ("m2_4", "Raíces Cuadráticas", "Completa el módulo 2.4", "square.and.arrow.up"),
            ("m3_1", "Sistemas de Ecuaciones", "Completa el módulo 3.1", "rectangle.grid.2x2"),
            ("m3_2", "Sustitución", "Completa el módulo 3.2", "arrow.left.arrow.right"),
            ("m3_3", "Eliminación", "Completa el módulo 3.3", "minus.circle"),
            ("m3_4", "Consistencia", "Completa el módulo 3.4", "checkmark.seal"),
        ]

        for (id, name, desc, icon) in moduleNames {
            badges.append(Badge(id: id, name: name, description: desc, iconName: icon, isUnlocked: false, category: .module))
        }

        // Unit badges (3)
        badges.append(Badge(id: "unit_1", name: "Maestro: Ecuaciones", description: "Completa la Unidad 1", iconName: "trophy", isUnlocked: false, category: .unit))
        badges.append(Badge(id: "unit_2", name: "Maestro: Polinomios", description: "Completa la Unidad 2", iconName: "trophy.fill", isUnlocked: false, category: .unit))
        badges.append(Badge(id: "unit_3", name: "Maestro: Sistemas", description: "Completa la Unidad 3", iconName: "medal", isUnlocked: false, category: .unit))

        // Streak badge
        badges.append(Badge(id: "streak_3", name: "Racha de 3 días", description: "Usa la app 3 días consecutivos", iconName: "flame", isUnlocked: false, category: .streak))

        // Perfect quiz badges
        badges.append(Badge(id: "perfect_first", name: "Primera Perfección", description: "Obtén 100% en tu primer quiz", iconName: "sparkles", isUnlocked: false, category: .perfect))

        return badges
    }()
}
