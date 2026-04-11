import Foundation

enum SARTData {

    /// Secuencia de práctica: 10 dígitos, 1 objetivo (dígito 3).
    static let practice: [Int] = [
        5, 7, 2, 9, 3, 1, 8, 4, 6, 2
    ]

    /// Versión A: 180 dígitos, 20 objetivos (dígito 3).
    /// Distribución pseudoaleatoria con separación mínima de 4 estímulos entre objetivos.
    static let versionA: [Int] = [
        // Bloque 1 (1–20)
        2, 8, 5, 1, 7, 3, 4, 9, 6, 2,
        1, 5, 8, 4, 3, 7, 9, 6, 1, 2,
        // Bloque 2 (21–40)
        4, 8, 6, 9, 3, 1, 5, 7, 2, 8,
        4, 6, 9, 1, 3, 5, 7, 2, 8, 4,
        // Bloque 3 (41–60)
        6, 1, 9, 7, 3, 2, 5, 8, 4, 6,
        1, 9, 7, 2, 3, 5, 8, 4, 6, 1,
        // Bloque 4 (61–80)
        9, 7, 2, 5, 3, 8, 4, 6, 1, 9,
        7, 2, 5, 8, 3, 4, 6, 1, 9, 7,
        // Bloque 5 (81–100)
        2, 5, 8, 4, 3, 6, 1, 9, 7, 2,
        5, 8, 4, 6, 3, 1, 9, 7, 2, 5,
        // Bloque 6 (101–120)
        8, 4, 6, 1, 3, 9, 7, 2, 5, 8,
        4, 6, 1, 9, 3, 7, 2, 5, 8, 4,
        // Bloque 7 (121–140)
        6, 1, 9, 7, 3, 2, 8, 5, 4, 6,
        9, 1, 7, 2, 3, 8, 5, 4, 6, 9,
        // Bloque 8 (141–160)
        1, 7, 2, 8, 3, 5, 4, 6, 9, 1,
        7, 2, 8, 5, 3, 4, 6, 9, 1, 7,
        // Bloque 9 (161–180)
        2, 8, 5, 4, 3, 6, 9, 1, 7, 2,
        8, 5, 4, 6, 3, 9, 1, 7, 2, 8
    ]

    /// Versión B: 180 dígitos, 20 objetivos (dígito 3).
    /// Distribución pseudoaleatoria diferente a la versión A.
    static let versionB: [Int] = [
        // Bloque 1 (1–20)
        7, 4, 9, 1, 3, 6, 2, 8, 5, 7,
        4, 9, 1, 6, 3, 2, 8, 5, 7, 4,
        // Bloque 2 (21–40)
        9, 1, 6, 2, 3, 8, 5, 7, 4, 9,
        1, 6, 2, 8, 3, 5, 7, 4, 9, 1,
        // Bloque 3 (41–60)
        6, 2, 8, 5, 3, 7, 4, 9, 1, 6,
        2, 8, 5, 7, 3, 4, 9, 1, 6, 2,
        // Bloque 4 (61–80)
        8, 5, 7, 4, 3, 9, 1, 6, 2, 8,
        5, 7, 4, 9, 3, 1, 6, 2, 8, 5,
        // Bloque 5 (81–100)
        7, 4, 9, 1, 3, 6, 2, 8, 5, 7,
        4, 1, 9, 6, 3, 2, 8, 5, 7, 4,
        // Bloque 6 (101–120)
        1, 9, 6, 2, 3, 8, 5, 7, 4, 1,
        9, 6, 2, 8, 3, 5, 7, 4, 1, 9,
        // Bloque 7 (121–140)
        6, 2, 8, 5, 3, 7, 4, 1, 9, 6,
        2, 8, 5, 7, 3, 4, 1, 9, 6, 2,
        // Bloque 8 (141–160)
        8, 5, 7, 4, 3, 1, 9, 6, 2, 8,
        5, 7, 4, 1, 3, 9, 6, 2, 8, 5,
        // Bloque 9 (161–180)
        7, 4, 1, 9, 3, 6, 2, 8, 5, 7,
        4, 1, 9, 6, 3, 2, 8, 5, 4, 7
    ]

    /// Devuelve la secuencia correspondiente a la versión indicada.
    static func sequence(for version: String) -> [Int] {
        version == "A" ? versionA : versionB
    }
}
