import Foundation

enum UserLevel {
    case aprendiz      // 0-50
    case estudiante    // 51-100
    case practicante   // 101-180
    case experto       // 181-280
    case maestro       // 281+

    static func calculate(points: Int) -> Int {
        switch points {
        case 0...50: return 1
        case 51...100: return 2
        case 101...180: return 3
        case 181...280: return 4
        default: return 5
        }
    }

    static func name(for level: Int) -> String {
        switch level {
        case 1: return "Aprendiz"
        case 2: return "Estudiante"
        case 3: return "Practicante"
        case 4: return "Experto"
        case 5: return "Maestro"
        default: return "Aprendiz"
        }
    }

    static func pointsRange(for level: Int) -> (min: Int, max: Int) {
        switch level {
        case 1: return (0, 50)
        case 2: return (51, 100)
        case 3: return (101, 180)
        case 4: return (181, 280)
        case 5: return (281, 500)
        default: return (0, 50)
        }
    }

    static func progressInLevel(points: Int) -> Double {
        let level = calculate(points: points)
        let range = pointsRange(for: level)
        let progress = Double(points - range.min) / Double(range.max - range.min)
        return min(max(progress, 0), 1)
    }
}
