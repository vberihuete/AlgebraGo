import Foundation

enum RetentionTestData {

    // MARK: - Form A (Pre-test)

    static let formA: [TestItem] = [
        TestItem(
            index: 0,
            question: "¿Cuál es la definición de variable en una ecuación?",
            options: [
                "a) Un número fijo",
                "b) Un símbolo que representa un valor desconocido",
                "c) Una operación matemática",
                "d) Un tipo de ecuación"
            ],
            correctIndex: 1,
            category: "Ecuaciones lineales"
        ),
        TestItem(
            index: 1,
            question: "¿Cuál de las siguientes es una ecuación lineal?",
            options: [
                "a) x² + 3 = 0",
                "b) 2x + 5 = 11",
                "c) x³ - 1 = 0",
                "d) √x = 4"
            ],
            correctIndex: 1,
            category: "Ecuaciones lineales"
        ),
        TestItem(
            index: 2,
            question: "Resuelve: 2x + 6 = 14",
            options: [
                "a) x = 4",
                "b) x = 5",
                "c) x = 3",
                "d) x = 10"
            ],
            correctIndex: 0,
            category: "Ecuaciones lineales"
        ),
        TestItem(
            index: 3,
            question: "Resuelve: 3x - 9 = 0",
            options: [
                "a) x = 9",
                "b) x = 3",
                "c) x = -3",
                "d) x = 0"
            ],
            correctIndex: 1,
            category: "Ecuaciones lineales"
        ),
        TestItem(
            index: 4,
            question: "Si 5x = 25, entonces x =",
            options: [
                "a) 5",
                "b) 20",
                "c) 25",
                "d) 10"
            ],
            correctIndex: 0,
            category: "Ecuaciones lineales"
        ),
        TestItem(
            index: 5,
            question: "Resuelve: (x/2) + 3 = 7",
            options: [
                "a) x = 4",
                "b) x = 8",
                "c) x = 14",
                "d) x = 2"
            ],
            correctIndex: 1,
            category: "Ecuaciones lineales"
        ),
        TestItem(
            index: 6,
            question: "Resuelve: 4(x - 1) = 12",
            options: [
                "a) x = 4",
                "b) x = 3",
                "c) x = 2",
                "d) x = 5"
            ],
            correctIndex: 0,
            category: "Ecuaciones lineales"
        ),
        TestItem(
            index: 7,
            question: "Si la solución de ax + 3 = 11 es x = 2, ¿cuál es el valor de a?",
            options: [
                "a) a = 2",
                "b) a = 4",
                "c) a = 3",
                "d) a = 8"
            ],
            correctIndex: 1,
            category: "Ecuaciones lineales"
        ),
        TestItem(
            index: 8,
            question: "¿Cuál es el grado del polinomio 4x³ - 2x + 7?",
            options: [
                "a) 1",
                "b) 2",
                "c) 3",
                "d) 4"
            ],
            correctIndex: 2,
            category: "Polinomios"
        ),
        TestItem(
            index: 9,
            question: "¿Cómo se llama un polinomio de grado 2?",
            options: [
                "a) Lineal",
                "b) Cúbico",
                "c) Cuadrático",
                "d) Constante"
            ],
            correctIndex: 2,
            category: "Polinomios"
        ),
        TestItem(
            index: 10,
            question: "Simplifica: (3x² + 2x) + (x² - 5x)",
            options: [
                "a) 4x² - 3x",
                "b) 4x² + 7x",
                "c) 2x² - 3x",
                "d) 3x² - 5x"
            ],
            correctIndex: 0,
            category: "Polinomios"
        ),
        TestItem(
            index: 11,
            question: "Factoriza: x² - 9",
            options: [
                "a) (x-3)(x+3)",
                "b) (x-9)(x+1)",
                "c) (x-3)²",
                "d) (x+9)(x-1)"
            ],
            correctIndex: 0,
            category: "Polinomios"
        ),
        TestItem(
            index: 12,
            question: "¿Cuáles son las raíces de x² - 5x + 6 = 0?",
            options: [
                "a) x=1, x=6",
                "b) x=2, x=3",
                "c) x=-2, x=-3",
                "d) x=0, x=5"
            ],
            correctIndex: 1,
            category: "Polinomios"
        ),
        TestItem(
            index: 13,
            question: "Si P(x) = x² - 4 y P(a) = 0, ¿qué valores tiene a?",
            options: [
                "a) a = 4",
                "b) a = ±2",
                "c) a = ±4",
                "d) a = 2"
            ],
            correctIndex: 1,
            category: "Polinomios"
        ),
        TestItem(
            index: 14,
            question: "El polinomio x² + 6x + 9 es equivalente a:",
            options: [
                "a) (x+3)²",
                "b) (x+9)(x+1)",
                "c) (x-3)²",
                "d) (x+6)(x+3)"
            ],
            correctIndex: 0,
            category: "Polinomios"
        ),
        TestItem(
            index: 15,
            question: "¿Cuántas ecuaciones componen un sistema de dos ecuaciones lineales con dos incógnitas?",
            options: [
                "a) Una",
                "b) Dos",
                "c) Tres",
                "d) Cuatro"
            ],
            correctIndex: 1,
            category: "Sistemas de ecuaciones"
        ),
        TestItem(
            index: 16,
            question: "Resuelve por sustitución: x + y = 5; x - y = 1",
            options: [
                "a) x=3, y=2",
                "b) x=4, y=1",
                "c) x=2, y=3",
                "d) x=5, y=0"
            ],
            correctIndex: 0,
            category: "Sistemas de ecuaciones"
        ),
        TestItem(
            index: 17,
            question: "Resuelve: 2x + y = 7; x + y = 4",
            options: [
                "a) x=3, y=1",
                "b) x=2, y=3",
                "c) x=1, y=3",
                "d) x=4, y=-1"
            ],
            correctIndex: 0,
            category: "Sistemas de ecuaciones"
        ),
        TestItem(
            index: 18,
            question: "Un sistema cuyas ecuaciones representan líneas paralelas es:",
            options: [
                "a) Consistente",
                "b) Dependiente",
                "c) Inconsistente",
                "d) Indeterminado"
            ],
            correctIndex: 2,
            category: "Sistemas de ecuaciones"
        ),
        TestItem(
            index: 19,
            question: "Si al resolver un sistema obtienes 0 = 0, el sistema es:",
            options: [
                "a) Inconsistente",
                "b) Independiente",
                "c) Imposible",
                "d) Consistente con infinitas soluciones"
            ],
            correctIndex: 3,
            category: "Sistemas de ecuaciones"
        )
    ]

    // MARK: - Form B (Post-test)

    static let formB: [TestItem] = [
        TestItem(
            index: 0,
            question: "¿Qué representa una variable en matemáticas?",
            options: [
                "a) Una constante numérica",
                "b) Un símbolo que puede tomar distintos valores",
                "c) Un signo de operación",
                "d) Un resultado final"
            ],
            correctIndex: 1,
            category: "Ecuaciones lineales"
        ),
        TestItem(
            index: 1,
            question: "¿Cuál de las siguientes es una ecuación lineal?",
            options: [
                "a) x³ + 2 = 0",
                "b) 3x - 4 = 8",
                "c) x² + x = 5",
                "d) √x + 1 = 3"
            ],
            correctIndex: 1,
            category: "Ecuaciones lineales"
        ),
        TestItem(
            index: 2,
            question: "Resuelve: 3x + 9 = 21",
            options: [
                "a) x = 4",
                "b) x = 7",
                "c) x = 3",
                "d) x = 10"
            ],
            correctIndex: 0,
            category: "Ecuaciones lineales"
        ),
        TestItem(
            index: 3,
            question: "Resuelve: 4x - 12 = 0",
            options: [
                "a) x = 12",
                "b) x = 3",
                "c) x = -3",
                "d) x = 0"
            ],
            correctIndex: 1,
            category: "Ecuaciones lineales"
        ),
        TestItem(
            index: 4,
            question: "Si 7x = 42, entonces x =",
            options: [
                "a) 6",
                "b) 35",
                "c) 42",
                "d) 7"
            ],
            correctIndex: 0,
            category: "Ecuaciones lineales"
        ),
        TestItem(
            index: 5,
            question: "Resuelve: (x/3) + 2 = 6",
            options: [
                "a) x = 6",
                "b) x = 12",
                "c) x = 18",
                "d) x = 4"
            ],
            correctIndex: 1,
            category: "Ecuaciones lineales"
        ),
        TestItem(
            index: 6,
            question: "Resuelve: 5(x - 2) = 15",
            options: [
                "a) x = 5",
                "b) x = 3",
                "c) x = 4",
                "d) x = 7"
            ],
            correctIndex: 0,
            category: "Ecuaciones lineales"
        ),
        TestItem(
            index: 7,
            question: "Si la solución de bx + 5 = 17 es x = 3, ¿cuál es el valor de b?",
            options: [
                "a) a = 3",
                "b) b = 4",
                "c) b = 5",
                "d) b = 12"
            ],
            correctIndex: 1,
            category: "Ecuaciones lineales"
        ),
        TestItem(
            index: 8,
            question: "¿Cuál es el grado del polinomio 5x⁴ - 3x² + 1?",
            options: [
                "a) 2",
                "b) 3",
                "c) 4",
                "d) 5"
            ],
            correctIndex: 2,
            category: "Polinomios"
        ),
        TestItem(
            index: 9,
            question: "¿Cómo se llama un polinomio de grado 3?",
            options: [
                "a) Lineal",
                "b) Cuadrático",
                "c) Cúbico",
                "d) Constante"
            ],
            correctIndex: 2,
            category: "Polinomios"
        ),
        TestItem(
            index: 10,
            question: "Simplifica: (2x² + 4x) + (3x² - 7x)",
            options: [
                "a) 5x² - 3x",
                "b) 5x² + 11x",
                "c) x² - 3x",
                "d) 2x² - 7x"
            ],
            correctIndex: 0,
            category: "Polinomios"
        ),
        TestItem(
            index: 11,
            question: "Factoriza: x² - 16",
            options: [
                "a) (x-4)(x+4)",
                "b) (x-16)(x+1)",
                "c) (x-4)²",
                "d) (x+16)(x-1)"
            ],
            correctIndex: 0,
            category: "Polinomios"
        ),
        TestItem(
            index: 12,
            question: "¿Cuáles son las raíces de x² - 7x + 12 = 0?",
            options: [
                "a) x=1, x=12",
                "b) x=3, x=4",
                "c) x=-3, x=-4",
                "d) x=0, x=7"
            ],
            correctIndex: 1,
            category: "Polinomios"
        ),
        TestItem(
            index: 13,
            question: "Si Q(x) = x² - 9 y Q(a) = 0, ¿qué valores tiene a?",
            options: [
                "a) a = 9",
                "b) a = ±3",
                "c) a = ±9",
                "d) a = 3"
            ],
            correctIndex: 1,
            category: "Polinomios"
        ),
        TestItem(
            index: 14,
            question: "El polinomio x² + 8x + 16 es equivalente a:",
            options: [
                "a) (x+4)²",
                "b) (x+16)(x+1)",
                "c) (x-4)²",
                "d) (x+8)(x+2)"
            ],
            correctIndex: 0,
            category: "Polinomios"
        ),
        TestItem(
            index: 15,
            question: "¿Cuántas incógnitas tiene un sistema de dos ecuaciones lineales con dos incógnitas?",
            options: [
                "a) Una",
                "b) Dos",
                "c) Tres",
                "d) Cuatro"
            ],
            correctIndex: 1,
            category: "Sistemas de ecuaciones"
        ),
        TestItem(
            index: 16,
            question: "Resuelve por sustitución: x + y = 7; x - y = 3",
            options: [
                "a) x=5, y=2",
                "b) x=4, y=3",
                "c) x=3, y=4",
                "d) x=7, y=0"
            ],
            correctIndex: 0,
            category: "Sistemas de ecuaciones"
        ),
        TestItem(
            index: 17,
            question: "Resuelve: 3x + y = 10; x + y = 4",
            options: [
                "a) x=3, y=1",
                "b) x=2, y=4",
                "c) x=1, y=3",
                "d) x=5, y=-1"
            ],
            correctIndex: 0,
            category: "Sistemas de ecuaciones"
        ),
        TestItem(
            index: 18,
            question: "Un sistema de ecuaciones sin solución se denomina:",
            options: [
                "a) Consistente",
                "b) Dependiente",
                "c) Inconsistente",
                "d) Indeterminado"
            ],
            correctIndex: 2,
            category: "Sistemas de ecuaciones"
        ),
        TestItem(
            index: 19,
            question: "Si al resolver un sistema obtienes una identidad como 5 = 5, el sistema tiene:",
            options: [
                "a) Ninguna solución",
                "b) Una solución única",
                "c) Exactamente dos soluciones",
                "d) Infinitas soluciones"
            ],
            correctIndex: 3,
            category: "Sistemas de ecuaciones"
        )
    ]

    /// Returns the test items for the given form identifier.
    static func items(for form: String) -> [TestItem] {
        switch form {
        case "A": return formA
        case "B": return formB
        default: return formA
        }
    }
}
