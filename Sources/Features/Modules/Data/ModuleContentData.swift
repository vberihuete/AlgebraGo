import Foundation

struct ModuleContentData {
    static let allModules: [ModuleContent] = [

        // MARK: - Unit 1: Ecuaciones Lineales

        // MARK: 1.1
        ModuleContent(
            id: "1_1",
            unitNumber: 1,
            moduleNumber: 1,
            title: "¿Qué es una variable y una ecuación?",
            explanation: [
                ExplanationStep(
                    text: "Una variable es un símbolo (generalmente una letra como x, y o z) que representa un valor desconocido. En álgebra, usamos variables para expresar relaciones entre cantidades que queremos determinar.",
                    formula: nil
                ),
                ExplanationStep(
                    text: "Una ecuación es una igualdad entre dos expresiones matemáticas que contiene al menos una variable. El objetivo al resolver una ecuación es encontrar el valor de la variable que hace verdadera la igualdad.",
                    formula: "2x + 3 = 7"
                ),
                ExplanationStep(
                    text: "En una ecuación, el signo igual (=) separa el lado izquierdo del lado derecho. Resolver la ecuación significa encontrar el valor de x que satisface la igualdad. En el ejemplo anterior, x = 2 porque 2(2) + 3 = 7.",
                    formula: "x = 2"
                ),
                ExplanationStep(
                    text: "Las ecuaciones lineales son aquellas donde la variable aparece con exponente 1 (es decir, no hay x^2, x^3, etc.). Se llaman lineales porque su representación gráfica es una línea recta.",
                    formula: "ax + b = c"
                )
            ],
            example: StepByStepExample(
                title: "Verificar si x = 5 es solución de 3x - 7 = 8",
                steps: [
                    ExampleStep(stepNumber: 1, description: "Sustituimos x por 5 en el lado izquierdo de la ecuación.", formula: "3(5) - 7"),
                    ExampleStep(stepNumber: 2, description: "Realizamos la multiplicación: 3 por 5 es 15.", formula: "15 - 7"),
                    ExampleStep(stepNumber: 3, description: "Restamos: 15 - 7 = 8. Como el resultado coincide con el lado derecho, x = 5 sí es solución.", formula: "8 = 8 ✓")
                ]
            ),
            quizQuestions: [
                QuizQuestion(
                    question: "¿Qué es una variable en una ecuación?",
                    options: [
                        "Un número fijo que nunca cambia",
                        "Un símbolo que representa un valor desconocido",
                        "El resultado de una operación",
                        "Un signo matemático como + o -"
                    ],
                    correctIndex: 1,
                    explanationOnWrong: "Una variable es un símbolo (como x o y) que representa un valor que no conocemos y queremos encontrar.",
                    explanationOnWrongRetry: "Piensa en la variable como una 'caja vacía' que necesitamos llenar con el número correcto para que la ecuación sea verdadera."
                ),
                QuizQuestion(
                    question: "¿Cuál de las siguientes es una ecuación lineal?",
                    options: [
                        "x^2 + 3 = 12",
                        "5x - 2 = 13",
                        "1/x = 4",
                        "x^3 = 27"
                    ],
                    correctIndex: 1,
                    explanationOnWrong: "Una ecuación lineal tiene la variable con exponente 1, es decir, sin elevar al cuadrado ni al cubo.",
                    explanationOnWrongRetry: "Busca la opción donde x aparece sola (exponente 1), sin x^2 ni x^3 ni en el denominador."
                ),
                QuizQuestion(
                    question: "Si 2x + 1 = 9, ¿cuál es el valor de x?",
                    options: [
                        "3",
                        "5",
                        "4",
                        "8"
                    ],
                    correctIndex: 2,
                    explanationOnWrong: "Resta 1 de ambos lados: 2x = 8, luego divide entre 2: x = 4.",
                    explanationOnWrongRetry: "Paso a paso: 2x + 1 = 9 → 2x = 9 - 1 → 2x = 8 → x = 8/2 = 4."
                ),
                QuizQuestion(
                    question: "¿Qué significa resolver una ecuación?",
                    options: [
                        "Simplificar la expresión",
                        "Graficar la ecuación",
                        "Encontrar el valor de la variable que hace verdadera la igualdad",
                        "Multiplicar ambos lados por el mismo número"
                    ],
                    correctIndex: 2,
                    explanationOnWrong: "Resolver una ecuación es encontrar el valor exacto de la variable que satisface la igualdad.",
                    explanationOnWrongRetry: "El objetivo final es hallar qué número debe tomar la variable para que el lado izquierdo sea igual al lado derecho."
                )
            ]
        ),

        // MARK: 1.2
        ModuleContent(
            id: "1_2",
            unitNumber: 1,
            moduleNumber: 2,
            title: "Resolviendo ecuaciones de una incógnita (ax + b = c)",
            explanation: [
                ExplanationStep(
                    text: "Para resolver una ecuación de la forma ax + b = c, aplicamos operaciones inversas. El objetivo es aislar la variable x en un lado de la ecuación.",
                    formula: "ax + b = c"
                ),
                ExplanationStep(
                    text: "Primer paso: eliminamos el término independiente (b) restándolo de ambos lados de la ecuación. Esto nos deja ax = c - b.",
                    formula: "ax = c - b"
                ),
                ExplanationStep(
                    text: "Segundo paso: dividimos ambos lados entre el coeficiente de x (es decir, a) para obtener el valor de x.",
                    formula: "x = (c - b) / a"
                ),
                ExplanationStep(
                    text: "Recuerda: lo que hagas de un lado de la ecuación, debes hacerlo del otro. Esto mantiene la igualdad. Siempre puedes verificar tu respuesta sustituyendo el valor encontrado en la ecuación original.",
                    formula: nil
                )
            ],
            example: StepByStepExample(
                title: "Resolver la ecuación 4x + 6 = 22",
                steps: [
                    ExampleStep(stepNumber: 1, description: "Restamos 6 de ambos lados para eliminar el término independiente.", formula: "4x + 6 - 6 = 22 - 6"),
                    ExampleStep(stepNumber: 2, description: "Simplificamos ambos lados.", formula: "4x = 16"),
                    ExampleStep(stepNumber: 3, description: "Dividimos ambos lados entre 4 para aislar x.", formula: "x = 16 / 4 = 4"),
                    ExampleStep(stepNumber: 4, description: "Verificamos: 4(4) + 6 = 16 + 6 = 22. ¡Correcto!", formula: "4(4) + 6 = 22 ✓")
                ]
            ),
            quizQuestions: [
                QuizQuestion(
                    question: "Resuelve: 3x + 9 = 24",
                    options: ["x = 7", "x = 5", "x = 11", "x = 3"],
                    correctIndex: 1,
                    explanationOnWrong: "Resta 9 de ambos lados: 3x = 15, luego divide entre 3: x = 5.",
                    explanationOnWrongRetry: "3x + 9 = 24 → 3x = 24 - 9 = 15 → x = 15/3 = 5."
                ),
                QuizQuestion(
                    question: "Resuelve: 7x - 14 = 0",
                    options: ["x = -2", "x = 14", "x = 2", "x = 7"],
                    correctIndex: 2,
                    explanationOnWrong: "Suma 14 a ambos lados: 7x = 14, luego divide entre 7: x = 2.",
                    explanationOnWrongRetry: "7x - 14 = 0 → 7x = 14 → x = 14/7 = 2."
                ),
                QuizQuestion(
                    question: "¿Cuál es el primer paso para resolver 5x + 3 = 28?",
                    options: [
                        "Dividir ambos lados entre 5",
                        "Restar 3 de ambos lados",
                        "Multiplicar ambos lados por 3",
                        "Sumar 5 a ambos lados"
                    ],
                    correctIndex: 1,
                    explanationOnWrong: "El primer paso es eliminar el término independiente (+3) restándolo de ambos lados.",
                    explanationOnWrongRetry: "Primero eliminamos lo que está sumando o restando a la variable, y después dividimos entre el coeficiente."
                ),
                QuizQuestion(
                    question: "Resuelve: -2x + 10 = 4",
                    options: ["x = -3", "x = 7", "x = 3", "x = -7"],
                    correctIndex: 2,
                    explanationOnWrong: "Resta 10: -2x = 4 - 10 = -6, luego divide entre -2: x = 3.",
                    explanationOnWrongRetry: "-2x + 10 = 4 → -2x = -6 → x = -6 / (-2) = 3. Recuerda: negativo entre negativo es positivo."
                )
            ]
        ),

        // MARK: 1.3
        ModuleContent(
            id: "1_3",
            unitNumber: 1,
            moduleNumber: 3,
            title: "Ecuaciones con fracciones y paréntesis",
            explanation: [
                ExplanationStep(
                    text: "Cuando una ecuación tiene fracciones, una estrategia eficaz es multiplicar ambos lados por el mínimo común múltiplo (MCM) de los denominadores para eliminar las fracciones.",
                    formula: "x/2 + x/3 = 5"
                ),
                ExplanationStep(
                    text: "Si la ecuación contiene paréntesis, usamos la propiedad distributiva para expandirlos: a(b + c) = ab + ac. Esto nos permite simplificar la ecuación antes de resolverla.",
                    formula: "3(x + 2) = 3x + 6"
                ),
                ExplanationStep(
                    text: "Después de eliminar fracciones y expandir paréntesis, agrupamos los términos con la variable de un lado y los términos numéricos del otro. Luego resolvemos como una ecuación lineal estándar.",
                    formula: nil
                ),
                ExplanationStep(
                    text: "Es fundamental distribuir el signo correctamente. Si hay un signo negativo antes del paréntesis, este cambia el signo de todos los términos dentro del paréntesis: -(a + b) = -a - b.",
                    formula: "-(2x - 3) = -2x + 3"
                )
            ],
            example: StepByStepExample(
                title: "Resolver: x/2 + x/3 = 10",
                steps: [
                    ExampleStep(stepNumber: 1, description: "Identificamos los denominadores: 2 y 3. El MCM es 6. Multiplicamos toda la ecuación por 6.", formula: "6(x/2) + 6(x/3) = 6(10)"),
                    ExampleStep(stepNumber: 2, description: "Simplificamos cada término: 6/2 = 3 y 6/3 = 2.", formula: "3x + 2x = 60"),
                    ExampleStep(stepNumber: 3, description: "Combinamos los términos semejantes.", formula: "5x = 60"),
                    ExampleStep(stepNumber: 4, description: "Dividimos ambos lados entre 5.", formula: "x = 12")
                ]
            ),
            quizQuestions: [
                QuizQuestion(
                    question: "Resuelve: x/4 + x/2 = 6",
                    options: ["x = 12", "x = 8", "x = 4", "x = 24"],
                    correctIndex: 1,
                    explanationOnWrong: "Multiplica por 4 (MCM): x + 2x = 24 → 3x = 24 → x = 8.",
                    explanationOnWrongRetry: "x/4 + x/2 = 6. MCM = 4. Multiplicando: x + 2x = 24, así que 3x = 24 y x = 8."
                ),
                QuizQuestion(
                    question: "Expande: 2(3x - 4)",
                    options: ["6x - 4", "6x - 8", "5x - 6", "3x - 8"],
                    correctIndex: 1,
                    explanationOnWrong: "Aplica la propiedad distributiva: 2 · 3x = 6x y 2 · (-4) = -8, por lo tanto 6x - 8.",
                    explanationOnWrongRetry: "Multiplica el 2 por cada término dentro del paréntesis: 2 × 3x = 6x, y 2 × (-4) = -8."
                ),
                QuizQuestion(
                    question: "Resuelve: 3(x + 2) = 21",
                    options: ["x = 9", "x = 7", "x = 5", "x = 3"],
                    correctIndex: 2,
                    explanationOnWrong: "Distribuye: 3x + 6 = 21 → 3x = 15 → x = 5.",
                    explanationOnWrongRetry: "Primero expande el paréntesis: 3x + 6 = 21. Resta 6: 3x = 15. Divide entre 3: x = 5."
                ),
                QuizQuestion(
                    question: "¿Cuál es el resultado de -(x - 5)?",
                    options: ["-x - 5", "x + 5", "-x + 5", "x - 5"],
                    correctIndex: 2,
                    explanationOnWrong: "El signo negativo cambia el signo de cada término: -(x) = -x y -(-5) = +5, resultando -x + 5.",
                    explanationOnWrongRetry: "Distribuye el signo menos: -1 · x = -x, y -1 · (-5) = +5. El resultado es -x + 5."
                )
            ]
        ),

        // MARK: 1.4
        ModuleContent(
            id: "1_4",
            unitNumber: 1,
            moduleNumber: 4,
            title: "Aplicaciones prácticas de ecuaciones lineales",
            explanation: [
                ExplanationStep(
                    text: "Las ecuaciones lineales permiten modelar situaciones reales. El proceso consiste en: identificar la incógnita, traducir el problema a lenguaje algebraico, resolver la ecuación y verificar que la respuesta tenga sentido en el contexto.",
                    formula: nil
                ),
                ExplanationStep(
                    text: "Para problemas de edades, precios o distancias, define la variable claramente. Por ejemplo, si la edad de Juan es el doble que la de María y juntos tienen 36 años, podemos escribir:",
                    formula: "x + 2x = 36"
                ),
                ExplanationStep(
                    text: "En problemas de mezclas o porcentajes, recuerda que 'de' significa multiplicación y 'es' significa igualdad. Por ejemplo, '20% de un número es 15' se traduce como:",
                    formula: "0.20 · x = 15"
                ),
                ExplanationStep(
                    text: "Siempre verifica que tu respuesta tenga sentido en el contexto del problema. Una edad negativa o una distancia negativa indicarían un error en el planteamiento o la resolución.",
                    formula: nil
                )
            ],
            example: StepByStepExample(
                title: "Un televisor cuesta RD$18,000 después de un descuento de 25%. ¿Cuál era el precio original?",
                steps: [
                    ExampleStep(stepNumber: 1, description: "Definimos x como el precio original. Si se aplica un 25% de descuento, el cliente paga el 75% del precio original.", formula: "0.75x = 18000"),
                    ExampleStep(stepNumber: 2, description: "Dividimos ambos lados entre 0.75 para despejar x.", formula: "x = 18000 / 0.75"),
                    ExampleStep(stepNumber: 3, description: "Calculamos el resultado.", formula: "x = 24000"),
                    ExampleStep(stepNumber: 4, description: "Verificamos: 25% de 24,000 = 6,000. Precio con descuento: 24,000 - 6,000 = 18,000. ¡Correcto!", formula: "24000 - 0.25(24000) = 18000 ✓")
                ]
            ),
            quizQuestions: [
                QuizQuestion(
                    question: "La suma de tres números consecutivos es 66. ¿Cuál es el menor?",
                    options: ["20", "21", "22", "23"],
                    correctIndex: 1,
                    explanationOnWrong: "Si el menor es x, los consecutivos son x+1 y x+2. Entonces x + (x+1) + (x+2) = 66 → 3x + 3 = 66 → 3x = 63 → x = 21.",
                    explanationOnWrongRetry: "Plantea: x + (x+1) + (x+2) = 66. Simplifica: 3x + 3 = 66, luego 3x = 63, así que x = 21."
                ),
                QuizQuestion(
                    question: "Un artículo cuesta RD$800 después de un aumento de 60%. ¿Cuál era el precio original?",
                    options: ["RD$320", "RD$480", "RD$500", "RD$640"],
                    correctIndex: 2,
                    explanationOnWrong: "Con aumento del 60%, el precio final es 160% del original: 1.60x = 800 → x = 500.",
                    explanationOnWrongRetry: "El precio con aumento es 1.60 × precio original. Entonces: 1.60x = 800, x = 800/1.60 = 500."
                ),
                QuizQuestion(
                    question: "Pedro tiene el triple de dinero que Ana. Juntos tienen RD$2,400. ¿Cuánto tiene Ana?",
                    options: ["RD$800", "RD$1,200", "RD$600", "RD$400"],
                    correctIndex: 2,
                    explanationOnWrong: "Si Ana tiene x, Pedro tiene 3x. Entonces x + 3x = 2400 → 4x = 2400 → x = 600.",
                    explanationOnWrongRetry: "Ana = x, Pedro = 3x. Total: x + 3x = 4x = 2400. Por lo tanto x = 600."
                ),
                QuizQuestion(
                    question: "El 30% de un número es 45. ¿Cuál es el número?",
                    options: ["135", "150", "13.5", "115"],
                    correctIndex: 1,
                    explanationOnWrong: "Planteamos 0.30x = 45. Dividimos: x = 45 / 0.30 = 150.",
                    explanationOnWrongRetry: "0.30 · x = 45. Despejando: x = 45 ÷ 0.30 = 150. Verifica: 30% de 150 = 45."
                )
            ]
        ),

        // MARK: - Unit 2: Polinomios

        // MARK: 2.1
        ModuleContent(
            id: "2_1",
            unitNumber: 2,
            moduleNumber: 1,
            title: "Definición, grado y clasificación de polinomios",
            explanation: [
                ExplanationStep(
                    text: "Un polinomio es una expresión algebraica formada por la suma de uno o más términos, llamados monomios. Cada monomio tiene un coeficiente (número), una variable y un exponente no negativo entero.",
                    formula: "3x^2 + 5x - 7"
                ),
                ExplanationStep(
                    text: "El grado de un polinomio es el mayor exponente de la variable que aparece en sus términos. Por ejemplo, en 4x^3 + 2x - 1, el grado es 3. El grado determina el comportamiento y el nombre del polinomio.",
                    formula: nil
                ),
                ExplanationStep(
                    text: "Clasificación por número de términos: monomio (1 término, ej. 5x^2), binomio (2 términos, ej. x + 3), trinomio (3 términos, ej. x^2 + x + 1). Si tiene más de 3 términos, simplemente se llama polinomio.",
                    formula: nil
                ),
                ExplanationStep(
                    text: "Clasificación por grado: grado 0 es constante, grado 1 es lineal, grado 2 es cuadrático, grado 3 es cúbico. Un polinomio está en forma estándar cuando sus términos se escriben de mayor a menor grado.",
                    formula: "ax^2 + bx + c"
                )
            ],
            example: StepByStepExample(
                title: "Clasificar el polinomio 7x^3 - 2x + 4x^2 - 9",
                steps: [
                    ExampleStep(stepNumber: 1, description: "Primero, reordenamos en forma estándar (de mayor a menor grado).", formula: "7x^3 + 4x^2 - 2x - 9"),
                    ExampleStep(stepNumber: 2, description: "Identificamos el grado: el mayor exponente es 3, por lo tanto es un polinomio de grado 3 (cúbico).", formula: "Grado = 3"),
                    ExampleStep(stepNumber: 3, description: "Contamos los términos: 7x^3, 4x^2, -2x, -9. Son 4 términos, así que es un polinomio (más de 3 términos).", formula: nil),
                    ExampleStep(stepNumber: 4, description: "Conclusión: es un polinomio cúbico de 4 términos con coeficiente principal 7.", formula: nil)
                ]
            ),
            quizQuestions: [
                QuizQuestion(
                    question: "¿Cuál es el grado del polinomio 5x^4 - 3x^2 + x - 8?",
                    options: ["2", "3", "4", "5"],
                    correctIndex: 2,
                    explanationOnWrong: "El grado es el mayor exponente de la variable. Aquí el mayor exponente es 4 (en 5x^4).",
                    explanationOnWrongRetry: "Observa los exponentes: 4, 2, 1 y 0. El mayor es 4, ese es el grado del polinomio."
                ),
                QuizQuestion(
                    question: "¿Cómo se clasifica el polinomio x^2 + 5x - 3 por número de términos?",
                    options: ["Monomio", "Binomio", "Trinomio", "Polinomio de 4 términos"],
                    correctIndex: 2,
                    explanationOnWrong: "Contemos los términos: x^2, 5x y -3. Son 3 términos, por lo tanto es un trinomio.",
                    explanationOnWrongRetry: "Tres términos separados por + o -: eso es un trinomio."
                ),
                QuizQuestion(
                    question: "¿Cuál es el coeficiente principal de -2x^3 + 4x^2 - x + 6?",
                    options: ["4", "6", "-2", "-1"],
                    correctIndex: 2,
                    explanationOnWrong: "El coeficiente principal es el coeficiente del término de mayor grado. El término de mayor grado es -2x^3, su coeficiente es -2.",
                    explanationOnWrongRetry: "Busca el término con el exponente más alto (x^3 en este caso). Su coeficiente (-2) es el coeficiente principal."
                ),
                QuizQuestion(
                    question: "Un polinomio de grado 2 se llama:",
                    options: ["Lineal", "Cuadrático", "Cúbico", "Constante"],
                    correctIndex: 1,
                    explanationOnWrong: "Los polinomios de grado 2 se llaman cuadráticos. Grado 1 = lineal, grado 3 = cúbico.",
                    explanationOnWrongRetry: "Grado 0: constante. Grado 1: lineal. Grado 2: cuadrático. Grado 3: cúbico."
                )
            ]
        ),

        // MARK: 2.2
        ModuleContent(
            id: "2_2",
            unitNumber: 2,
            moduleNumber: 2,
            title: "Suma y resta de polinomios",
            explanation: [
                ExplanationStep(
                    text: "Para sumar o restar polinomios, combinamos los términos semejantes. Dos términos son semejantes cuando tienen la misma variable elevada al mismo exponente. Solo se suman o restan sus coeficientes.",
                    formula: "3x^2 + 5x^2 = 8x^2"
                ),
                ExplanationStep(
                    text: "En la suma de polinomios, simplemente agrupamos los términos semejantes y sumamos sus coeficientes. No se modifican los exponentes.",
                    formula: "(2x^2 + 3x) + (4x^2 - x) = 6x^2 + 2x"
                ),
                ExplanationStep(
                    text: "En la resta, hay que cambiar el signo de todos los términos del polinomio que se está restando (el sustraendo) antes de agrupar términos semejantes.",
                    formula: "(5x^2 + 2x) - (3x^2 - x) = 5x^2 + 2x - 3x^2 + x = 2x^2 + 3x"
                ),
                ExplanationStep(
                    text: "Es importante no confundir términos semejantes. Por ejemplo, 3x^2 y 3x no son semejantes porque tienen distintos exponentes. Tampoco lo son 2x y 2y porque tienen distintas variables.",
                    formula: nil
                )
            ],
            example: StepByStepExample(
                title: "Calcular (3x^2 - 5x + 4) - (x^2 + 2x - 7)",
                steps: [
                    ExampleStep(stepNumber: 1, description: "Distribuimos el signo negativo al segundo polinomio, cambiando el signo de cada término.", formula: "3x^2 - 5x + 4 - x^2 - 2x + 7"),
                    ExampleStep(stepNumber: 2, description: "Agrupamos los términos semejantes: los de x^2, los de x y las constantes.", formula: "(3x^2 - x^2) + (-5x - 2x) + (4 + 7)"),
                    ExampleStep(stepNumber: 3, description: "Sumamos los coeficientes de cada grupo.", formula: "2x^2 - 7x + 11")
                ]
            ),
            quizQuestions: [
                QuizQuestion(
                    question: "Calcula: (4x^2 + 3x) + (2x^2 - x)",
                    options: ["6x^2 + 4x", "6x^2 + 2x", "8x^2 + 2x", "6x^2 - 2x"],
                    correctIndex: 1,
                    explanationOnWrong: "Suma los términos semejantes: 4x^2 + 2x^2 = 6x^2, y 3x + (-x) = 2x. Resultado: 6x^2 + 2x.",
                    explanationOnWrongRetry: "x^2 con x^2: 4 + 2 = 6. Los de x: 3 + (-1) = 2. Resultado: 6x^2 + 2x."
                ),
                QuizQuestion(
                    question: "Calcula: (5x - 3) - (2x + 4)",
                    options: ["3x + 1", "3x - 7", "7x - 7", "3x + 7"],
                    correctIndex: 1,
                    explanationOnWrong: "Cambia los signos del segundo polinomio: 5x - 3 - 2x - 4 = 3x - 7.",
                    explanationOnWrongRetry: "Distribuye el negativo: -(2x + 4) = -2x - 4. Luego: (5x - 2x) + (-3 - 4) = 3x - 7."
                ),
                QuizQuestion(
                    question: "¿Cuáles son términos semejantes?",
                    options: ["3x^2 y 3x", "5x y -2x", "4x^2 y 4y^2", "2x y 2"],
                    correctIndex: 1,
                    explanationOnWrong: "Términos semejantes tienen la misma variable con el mismo exponente. 5x y -2x ambos tienen x con exponente 1.",
                    explanationOnWrongRetry: "Para ser semejantes necesitan la misma variable y el mismo exponente. Solo 5x y -2x cumplen esto."
                ),
                QuizQuestion(
                    question: "Calcula: (x^2 + 4x - 2) + (3x^2 - 4x + 5)",
                    options: ["4x^2 + 8x + 3", "4x^2 + 3", "4x^2 - 3", "3x^2 + 3"],
                    correctIndex: 1,
                    explanationOnWrong: "Sumamos: x^2 + 3x^2 = 4x^2, 4x + (-4x) = 0, -2 + 5 = 3. Resultado: 4x^2 + 3.",
                    explanationOnWrongRetry: "Los términos de x se cancelan: 4x - 4x = 0. Quedan 4x^2 y +3. Resultado: 4x^2 + 3."
                )
            ]
        ),

        // MARK: 2.3
        ModuleContent(
            id: "2_3",
            unitNumber: 2,
            moduleNumber: 3,
            title: "Multiplicación y factorización básica (x^2 - a^2)",
            explanation: [
                ExplanationStep(
                    text: "Para multiplicar polinomios, cada término del primer polinomio se multiplica por cada término del segundo. Al multiplicar potencias de la misma base, se suman los exponentes.",
                    formula: "x^a · x^b = x^(a+b)"
                ),
                ExplanationStep(
                    text: "Un caso especial importante es el producto de binomios conjugados: (a + b)(a - b). El resultado es siempre la diferencia de cuadrados.",
                    formula: "(a + b)(a - b) = a^2 - b^2"
                ),
                ExplanationStep(
                    text: "Factorizar es el proceso inverso de multiplicar: descomponer una expresión en producto de factores. La diferencia de cuadrados se factoriza como el producto de sus binomios conjugados.",
                    formula: "x^2 - 9 = (x + 3)(x - 3)"
                ),
                ExplanationStep(
                    text: "Para reconocer una diferencia de cuadrados, verifica que ambos términos sean cuadrados perfectos y estén separados por un signo menos. Recuerda: la suma de cuadrados (a^2 + b^2) no se factoriza con números reales.",
                    formula: "25x^2 - 16 = (5x + 4)(5x - 4)"
                )
            ],
            example: StepByStepExample(
                title: "Factorizar 4x^2 - 49",
                steps: [
                    ExampleStep(stepNumber: 1, description: "Verificamos que sea una diferencia de cuadrados: 4x^2 = (2x)^2 y 49 = 7^2. Ambos son cuadrados perfectos separados por un signo menos.", formula: "4x^2 - 49 = (2x)^2 - 7^2"),
                    ExampleStep(stepNumber: 2, description: "Aplicamos la fórmula a^2 - b^2 = (a + b)(a - b), donde a = 2x y b = 7.", formula: "(2x + 7)(2x - 7)"),
                    ExampleStep(stepNumber: 3, description: "Verificamos multiplicando: (2x + 7)(2x - 7) = 4x^2 - 14x + 14x - 49 = 4x^2 - 49. ¡Correcto!", formula: "4x^2 - 49 ✓")
                ]
            ),
            quizQuestions: [
                QuizQuestion(
                    question: "Factoriza: x^2 - 25",
                    options: ["(x + 5)(x + 5)", "(x - 5)(x - 5)", "(x + 5)(x - 5)", "(x + 25)(x - 1)"],
                    correctIndex: 2,
                    explanationOnWrong: "x^2 - 25 es una diferencia de cuadrados: x^2 - 5^2 = (x + 5)(x - 5).",
                    explanationOnWrongRetry: "Usa la fórmula a^2 - b^2 = (a + b)(a - b) con a = x y b = 5."
                ),
                QuizQuestion(
                    question: "¿Cuál es el resultado de (x + 4)(x - 4)?",
                    options: ["x^2 + 16", "x^2 - 8", "x^2 - 16", "x^2 + 8x - 16"],
                    correctIndex: 2,
                    explanationOnWrong: "Es un producto de conjugados: (x + 4)(x - 4) = x^2 - 4^2 = x^2 - 16.",
                    explanationOnWrongRetry: "Los conjugados (a+b)(a-b) siempre dan a^2 - b^2. Aquí: x^2 - 16."
                ),
                QuizQuestion(
                    question: "Factoriza: 9x^2 - 1",
                    options: ["(9x + 1)(x - 1)", "(3x + 1)(3x - 1)", "(3x - 1)(3x - 1)", "(9x + 1)(9x - 1)"],
                    correctIndex: 1,
                    explanationOnWrong: "9x^2 = (3x)^2 y 1 = 1^2. Entonces: (3x + 1)(3x - 1).",
                    explanationOnWrongRetry: "Identifica las raíces cuadradas: √(9x^2) = 3x, √1 = 1. Resultado: (3x + 1)(3x - 1)."
                ),
                QuizQuestion(
                    question: "Multiplica: (2x)(3x^2)",
                    options: ["5x^3", "6x^2", "6x^3", "5x^2"],
                    correctIndex: 2,
                    explanationOnWrong: "Multiplica coeficientes: 2 × 3 = 6. Suma exponentes: x^1 · x^2 = x^3. Resultado: 6x^3.",
                    explanationOnWrongRetry: "Coeficientes se multiplican (2·3=6), exponentes de la misma base se suman (1+2=3): 6x^3."
                )
            ]
        ),

        // MARK: 2.4
        ModuleContent(
            id: "2_4",
            unitNumber: 2,
            moduleNumber: 4,
            title: "Raíces de polinomios cuadráticos simples",
            explanation: [
                ExplanationStep(
                    text: "Las raíces (o ceros) de un polinomio cuadrático ax^2 + bx + c = 0 son los valores de x que hacen que el polinomio sea igual a cero. Un polinomio cuadrático puede tener 0, 1 o 2 raíces reales.",
                    formula: "ax^2 + bx + c = 0"
                ),
                ExplanationStep(
                    text: "La fórmula general (o fórmula cuadrática) permite encontrar las raíces de cualquier ecuación cuadrática. Se obtiene completando el cuadrado en la forma general.",
                    formula: "x = (-b ± √(b^2 - 4ac)) / (2a)"
                ),
                ExplanationStep(
                    text: "El discriminante Δ = b^2 - 4ac determina el número de raíces reales: si Δ > 0, hay dos raíces distintas; si Δ = 0, hay una raíz doble; si Δ < 0, no hay raíces reales.",
                    formula: "Δ = b^2 - 4ac"
                ),
                ExplanationStep(
                    text: "Para ecuaciones simples como x^2 - k = 0, las raíces son x = ±√k. También puedes factorizar cuando sea posible: x^2 - 5x + 6 = (x - 2)(x - 3) = 0, así x = 2 o x = 3.",
                    formula: "x^2 - 5x + 6 = (x - 2)(x - 3)"
                )
            ],
            example: StepByStepExample(
                title: "Resolver x^2 - 4x - 5 = 0 usando la fórmula general",
                steps: [
                    ExampleStep(stepNumber: 1, description: "Identificamos los coeficientes: a = 1, b = -4, c = -5.", formula: "a = 1, b = -4, c = -5"),
                    ExampleStep(stepNumber: 2, description: "Calculamos el discriminante.", formula: "Δ = (-4)^2 - 4(1)(-5) = 16 + 20 = 36"),
                    ExampleStep(stepNumber: 3, description: "Aplicamos la fórmula general. Como Δ = 36 > 0, hay dos raíces reales.", formula: "x = (4 ± √36) / 2 = (4 ± 6) / 2"),
                    ExampleStep(stepNumber: 4, description: "Calculamos las dos raíces: x₁ = (4 + 6)/2 = 5, x₂ = (4 - 6)/2 = -1.", formula: "x₁ = 5, x₂ = -1")
                ]
            ),
            quizQuestions: [
                QuizQuestion(
                    question: "¿Cuáles son las raíces de x^2 - 9 = 0?",
                    options: ["x = 9", "x = 3 y x = -3", "x = 3", "x = 81"],
                    correctIndex: 1,
                    explanationOnWrong: "x^2 = 9, entonces x = ±√9 = ±3. Las raíces son 3 y -3.",
                    explanationOnWrongRetry: "Despeja: x^2 = 9. La raíz cuadrada tiene dos valores: +3 y -3."
                ),
                QuizQuestion(
                    question: "Si el discriminante de una ecuación cuadrática es negativo, ¿cuántas raíces reales tiene?",
                    options: ["Dos", "Una", "Ninguna", "Infinitas"],
                    correctIndex: 2,
                    explanationOnWrong: "Cuando Δ < 0, no podemos calcular la raíz cuadrada de un número negativo (en los reales), por lo que no hay raíces reales.",
                    explanationOnWrongRetry: "Δ < 0 implica √(negativo), lo cual no existe en los números reales. Por eso: cero raíces reales."
                ),
                QuizQuestion(
                    question: "Resuelve x^2 - 7x + 12 = 0 por factorización.",
                    options: ["x = 2 y x = 6", "x = 3 y x = 4", "x = -3 y x = -4", "x = 1 y x = 12"],
                    correctIndex: 1,
                    explanationOnWrong: "Buscamos dos números que multiplicados den 12 y sumados den 7: son 3 y 4. Entonces (x - 3)(x - 4) = 0, x = 3 o x = 4.",
                    explanationOnWrongRetry: "Factoriza: x^2 - 7x + 12 = (x - 3)(x - 4). Las raíces son x = 3 y x = 4."
                ),
                QuizQuestion(
                    question: "¿Cuál es el discriminante de 2x^2 + 3x - 2 = 0?",
                    options: ["25", "1", "-7", "17"],
                    correctIndex: 0,
                    explanationOnWrong: "Δ = b^2 - 4ac = 3^2 - 4(2)(-2) = 9 + 16 = 25.",
                    explanationOnWrongRetry: "a = 2, b = 3, c = -2. Δ = 9 - 4(2)(-2) = 9 - (-16) = 9 + 16 = 25."
                )
            ]
        ),

        // MARK: - Unit 3: Sistemas de Ecuaciones

        // MARK: 3.1
        ModuleContent(
            id: "3_1",
            unitNumber: 3,
            moduleNumber: 1,
            title: "¿Qué es un sistema de ecuaciones?",
            explanation: [
                ExplanationStep(
                    text: "Un sistema de ecuaciones es un conjunto de dos o más ecuaciones con dos o más incógnitas que deben satisfacerse simultáneamente. La solución es el par (o conjunto) de valores que cumple todas las ecuaciones a la vez.",
                    formula: nil
                ),
                ExplanationStep(
                    text: "Un sistema de dos ecuaciones lineales con dos incógnitas tiene la forma general mostrada. Los valores de x e y que satisfacen ambas ecuaciones al mismo tiempo son la solución del sistema.",
                    formula: "a₁x + b₁y = c₁ ; a₂x + b₂y = c₂"
                ),
                ExplanationStep(
                    text: "Geométricamente, cada ecuación lineal representa una recta en el plano. La solución del sistema corresponde al punto de intersección de las rectas. Si las rectas son paralelas, no hay solución; si son la misma recta, hay infinitas soluciones.",
                    formula: nil
                ),
                ExplanationStep(
                    text: "Los métodos principales para resolver sistemas son: sustitución, igualación y eliminación (reducción). Cada uno tiene ventajas según la forma de las ecuaciones.",
                    formula: nil
                )
            ],
            example: StepByStepExample(
                title: "Verificar que x = 2, y = 3 es solución del sistema: x + y = 5 ; 2x - y = 1",
                steps: [
                    ExampleStep(stepNumber: 1, description: "Sustituimos x = 2 e y = 3 en la primera ecuación.", formula: "2 + 3 = 5 ✓"),
                    ExampleStep(stepNumber: 2, description: "Sustituimos x = 2 e y = 3 en la segunda ecuación.", formula: "2(2) - 3 = 4 - 3 = 1 ✓"),
                    ExampleStep(stepNumber: 3, description: "Como el par (2, 3) satisface ambas ecuaciones, confirmamos que es la solución del sistema. Gráficamente, las rectas se cruzan en el punto (2, 3).", formula: nil)
                ]
            ),
            quizQuestions: [
                QuizQuestion(
                    question: "¿Qué es un sistema de ecuaciones?",
                    options: [
                        "Una sola ecuación con muchas variables",
                        "Un conjunto de ecuaciones que deben cumplirse simultáneamente",
                        "Una ecuación cuadrática especial",
                        "Un método para graficar funciones"
                    ],
                    correctIndex: 1,
                    explanationOnWrong: "Un sistema es un conjunto de dos o más ecuaciones cuyas soluciones deben satisfacer todas las ecuaciones al mismo tiempo.",
                    explanationOnWrongRetry: "La clave es 'simultáneamente': los mismos valores de las variables deben funcionar en todas las ecuaciones."
                ),
                QuizQuestion(
                    question: "¿Es (1, 4) solución de x + y = 5 y 2x + y = 6?",
                    options: ["Sí", "No, solo cumple la primera", "No, solo cumple la segunda", "No, no cumple ninguna"],
                    correctIndex: 0,
                    explanationOnWrong: "Verificamos: 1 + 4 = 5 ✓ y 2(1) + 4 = 6 ✓. Cumple ambas, entonces sí es solución.",
                    explanationOnWrongRetry: "Sustituye x=1, y=4 en ambas: primera → 5=5 ✓, segunda → 6=6 ✓. Sí es solución."
                ),
                QuizQuestion(
                    question: "Si dos rectas son paralelas, ¿cuántas soluciones tiene el sistema?",
                    options: ["Una", "Dos", "Infinitas", "Ninguna"],
                    correctIndex: 3,
                    explanationOnWrong: "Rectas paralelas nunca se cruzan, por lo tanto no existe un punto que satisfaga ambas ecuaciones. El sistema no tiene solución.",
                    explanationOnWrongRetry: "Sin punto de intersección = sin solución. Las rectas paralelas no se encuentran."
                ),
                QuizQuestion(
                    question: "Si dos ecuaciones representan la misma recta, el sistema tiene:",
                    options: ["Exactamente una solución", "Ninguna solución", "Exactamente dos soluciones", "Infinitas soluciones"],
                    correctIndex: 3,
                    explanationOnWrong: "Si las rectas son idénticas, todos los puntos de la recta son solución. Hay infinitas soluciones.",
                    explanationOnWrongRetry: "Una misma recta tiene infinitos puntos, y todos son puntos de intersección consigo misma."
                )
            ]
        ),

        // MARK: 3.2
        ModuleContent(
            id: "3_2",
            unitNumber: 3,
            moduleNumber: 2,
            title: "Método de sustitución",
            explanation: [
                ExplanationStep(
                    text: "El método de sustitución consiste en despejar una variable de una ecuación y sustituir esa expresión en la otra ecuación. Así reducimos el sistema a una sola ecuación con una sola incógnita.",
                    formula: nil
                ),
                ExplanationStep(
                    text: "Paso 1: Elegir una ecuación y despejar una variable (preferiblemente la que tenga coeficiente 1 o -1 para evitar fracciones). Paso 2: Sustituir la expresión obtenida en la otra ecuación.",
                    formula: nil
                ),
                ExplanationStep(
                    text: "Paso 3: Resolver la ecuación resultante (que tendrá una sola variable). Paso 4: Sustituir el valor encontrado en la expresión del paso 1 para hallar la otra variable.",
                    formula: nil
                ),
                ExplanationStep(
                    text: "Este método es especialmente útil cuando una de las ecuaciones ya tiene una variable despejada o cuando un coeficiente es 1, lo que facilita el despeje sin generar fracciones.",
                    formula: nil
                )
            ],
            example: StepByStepExample(
                title: "Resolver por sustitución: x + y = 10 ; 3x - y = 6",
                steps: [
                    ExampleStep(stepNumber: 1, description: "Despejamos y de la primera ecuación (es más fácil porque el coeficiente de y es 1).", formula: "y = 10 - x"),
                    ExampleStep(stepNumber: 2, description: "Sustituimos esta expresión en la segunda ecuación.", formula: "3x - (10 - x) = 6"),
                    ExampleStep(stepNumber: 3, description: "Resolvemos: distribuimos el signo y simplificamos.", formula: "3x - 10 + x = 6 → 4x = 16 → x = 4"),
                    ExampleStep(stepNumber: 4, description: "Sustituimos x = 4 en la expresión y = 10 - x para encontrar y.", formula: "y = 10 - 4 = 6"),
                    ExampleStep(stepNumber: 5, description: "La solución es (4, 6). Verificamos en la segunda ecuación: 3(4) - 6 = 12 - 6 = 6 ✓.", formula: "Solución: x = 4, y = 6")
                ]
            ),
            quizQuestions: [
                QuizQuestion(
                    question: "En el sistema y = 2x ; x + y = 9, ¿cuál es el primer paso por sustitución?",
                    options: [
                        "Sumar las dos ecuaciones",
                        "Sustituir y = 2x en la segunda ecuación",
                        "Despejar x de la segunda ecuación",
                        "Multiplicar ambas ecuaciones por 2"
                    ],
                    correctIndex: 1,
                    explanationOnWrong: "Como y ya está despejada (y = 2x), sustituimos directamente en la otra: x + 2x = 9.",
                    explanationOnWrongRetry: "Si una variable ya está despejada, el paso natural es sustituirla en la otra ecuación."
                ),
                QuizQuestion(
                    question: "Resuelve por sustitución: y = x + 1 ; 2x + y = 7",
                    options: ["x = 3, y = 4", "x = 2, y = 3", "x = 1, y = 2", "x = 4, y = 5"],
                    correctIndex: 1,
                    explanationOnWrong: "Sustituimos y = x + 1 en la segunda: 2x + (x + 1) = 7 → 3x + 1 = 7 → 3x = 6 → x = 2. Luego y = 3.",
                    explanationOnWrongRetry: "2x + (x+1) = 7 → 3x = 6 → x = 2. Luego y = 2 + 1 = 3."
                ),
                QuizQuestion(
                    question: "¿Cuándo es más conveniente usar el método de sustitución?",
                    options: [
                        "Cuando los coeficientes son muy grandes",
                        "Cuando una variable ya está despejada o su coeficiente es 1",
                        "Cuando las ecuaciones tienen fracciones",
                        "Cuando ambas ecuaciones son cuadráticas"
                    ],
                    correctIndex: 1,
                    explanationOnWrong: "La sustitución es ideal cuando una variable tiene coeficiente 1 o ya está despejada, porque evitamos generar fracciones.",
                    explanationOnWrongRetry: "Si el coeficiente es 1, el despeje es inmediato y limpio, sin fracciones."
                ),
                QuizQuestion(
                    question: "Resuelve: x = 5 - y ; 3x + 2y = 12",
                    options: ["x = 2, y = 3", "x = 3, y = 2", "x = 4, y = 0", "x = 1, y = 4"],
                    correctIndex: 0,
                    explanationOnWrong: "Sustituimos x = 5-y: 3(5-y) + 2y = 12 → 15 - 3y + 2y = 12 → -y = -3 → y = 3. Luego x = 5-3 = 2.",
                    explanationOnWrongRetry: "3(5-y) + 2y = 12 → 15 - 3y + 2y = 12 → 15 - y = 12 → y = 3 → x = 2."
                )
            ]
        ),

        // MARK: 3.3
        ModuleContent(
            id: "3_3",
            unitNumber: 3,
            moduleNumber: 3,
            title: "Método de igualación / eliminación",
            explanation: [
                ExplanationStep(
                    text: "El método de eliminación (también llamado reducción) consiste en sumar o restar las ecuaciones del sistema para eliminar una de las variables. Para ello, los coeficientes de la variable a eliminar deben ser iguales (o opuestos).",
                    formula: nil
                ),
                ExplanationStep(
                    text: "Si los coeficientes no son opuestos, multiplicamos una o ambas ecuaciones por constantes adecuadas. Por ejemplo, para eliminar y del sistema 2x + 3y = 12 y 4x - y = 5, multiplicamos la segunda por 3.",
                    formula: "4x - y = 5 → 12x - 3y = 15"
                ),
                ExplanationStep(
                    text: "Luego sumamos las ecuaciones: los términos con y se cancelan. 2x + 3y + 12x - 3y = 12 + 15 → 14x = 27, y así encontramos x.",
                    formula: "14x = 27 → x = 27/14"
                ),
                ExplanationStep(
                    text: "El método de igualación es una variante: despejamos la misma variable de ambas ecuaciones y las igualamos. Por ejemplo, si y = 2x + 1 y y = -x + 7, entonces 2x + 1 = -x + 7, lo que da 3x = 6, x = 2.",
                    formula: "2x + 1 = -x + 7"
                )
            ],
            example: StepByStepExample(
                title: "Resolver por eliminación: 2x + y = 8 ; x - y = 1",
                steps: [
                    ExampleStep(stepNumber: 1, description: "Observamos que los coeficientes de y son +1 y -1 (ya son opuestos). Sumamos ambas ecuaciones.", formula: "(2x + y) + (x - y) = 8 + 1"),
                    ExampleStep(stepNumber: 2, description: "La variable y se elimina al sumar.", formula: "3x = 9"),
                    ExampleStep(stepNumber: 3, description: "Resolvemos para x.", formula: "x = 3"),
                    ExampleStep(stepNumber: 4, description: "Sustituimos x = 3 en la primera ecuación para encontrar y.", formula: "2(3) + y = 8 → y = 2"),
                    ExampleStep(stepNumber: 5, description: "La solución es (3, 2). Verificamos en la segunda: 3 - 2 = 1 ✓.", formula: "Solución: x = 3, y = 2")
                ]
            ),
            quizQuestions: [
                QuizQuestion(
                    question: "Para eliminar y del sistema 3x + 2y = 10 y x + 2y = 6, ¿qué hacemos?",
                    options: [
                        "Sumamos las ecuaciones",
                        "Restamos la segunda de la primera",
                        "Multiplicamos la primera por 2",
                        "Dividimos ambas entre 2"
                    ],
                    correctIndex: 1,
                    explanationOnWrong: "Como ambas tienen +2y, restamos una de otra para eliminar y: (3x+2y) - (x+2y) = 10-6 → 2x = 4.",
                    explanationOnWrongRetry: "Mismos coeficientes con mismo signo: restamos. Si fueran signos opuestos, sumaríamos."
                ),
                QuizQuestion(
                    question: "Resuelve por eliminación: x + y = 7 ; x - y = 3",
                    options: ["x = 5, y = 2", "x = 4, y = 3", "x = 3, y = 4", "x = 2, y = 5"],
                    correctIndex: 0,
                    explanationOnWrong: "Sumamos: 2x = 10 → x = 5. Sustituimos: 5 + y = 7 → y = 2.",
                    explanationOnWrongRetry: "Suma ambas ecuaciones: (x+y)+(x-y) = 7+3 → 2x = 10 → x = 5, luego y = 2."
                ),
                QuizQuestion(
                    question: "En el método de igualación, ¿qué hacemos primero?",
                    options: [
                        "Sumamos las dos ecuaciones directamente",
                        "Despejamos la misma variable de ambas ecuaciones y las igualamos",
                        "Multiplicamos ambas ecuaciones entre sí",
                        "Graficamos ambas ecuaciones"
                    ],
                    correctIndex: 1,
                    explanationOnWrong: "En igualación, despejamos la misma variable de ambas ecuaciones y hacemos las expresiones iguales entre sí.",
                    explanationOnWrongRetry: "Si de la primera sale y = ... y de la segunda también y = ..., igualamos ambas expresiones."
                ),
                QuizQuestion(
                    question: "Resuelve: 2x + 3y = 13 ; 2x - y = 5",
                    options: ["x = 5, y = 1", "x = 2, y = 3", "x = 3.5, y = 2", "x = 4, y = 3"],
                    correctIndex: 2,
                    explanationOnWrong: "Restamos: (2x+3y)-(2x-y) = 13-5 → 4y = 8 → y = 2. Luego 2x - 2 = 5 → 2x = 7 → x = 3.5.",
                    explanationOnWrongRetry: "Restando se elimina x: 4y = 8, y = 2. Sustituimos: 2x = 5 + 2 = 7, x = 3.5."
                )
            ]
        ),

        // MARK: 3.4
        ModuleContent(
            id: "3_4",
            unitNumber: 3,
            moduleNumber: 4,
            title: "Consistencia e inconsistencia de sistemas",
            explanation: [
                ExplanationStep(
                    text: "Un sistema de ecuaciones es consistente si tiene al menos una solución. Puede ser determinado (una única solución) o indeterminado (infinitas soluciones). Es inconsistente si no tiene solución.",
                    formula: nil
                ),
                ExplanationStep(
                    text: "Un sistema determinado ocurre cuando las rectas se cortan en un punto. Los coeficientes no son proporcionales: a₁/a₂ ≠ b₁/b₂. Ejemplo: x + y = 5 y x - y = 1 tiene solución única (3, 2).",
                    formula: "a₁/a₂ ≠ b₁/b₂ → solución única"
                ),
                ExplanationStep(
                    text: "Un sistema inconsistente (sin solución) ocurre cuando las rectas son paralelas: los coeficientes de las variables son proporcionales pero los términos independientes no. Ejemplo: 2x + y = 5 y 4x + 2y = 3.",
                    formula: "a₁/a₂ = b₁/b₂ ≠ c₁/c₂ → sin solución"
                ),
                ExplanationStep(
                    text: "Un sistema indeterminado (infinitas soluciones) ocurre cuando ambas ecuaciones representan la misma recta: todos los coeficientes y el término independiente son proporcionales.",
                    formula: "a₁/a₂ = b₁/b₂ = c₁/c₂ → infinitas soluciones"
                )
            ],
            example: StepByStepExample(
                title: "Clasificar el sistema: 2x + 4y = 8 ; x + 2y = 4",
                steps: [
                    ExampleStep(stepNumber: 1, description: "Comparamos los coeficientes: a₁/a₂ = 2/1 = 2, b₁/b₂ = 4/2 = 2, c₁/c₂ = 8/4 = 2.", formula: "2/1 = 4/2 = 8/4 = 2"),
                    ExampleStep(stepNumber: 2, description: "Como a₁/a₂ = b₁/b₂ = c₁/c₂, las ecuaciones representan la misma recta.", formula: nil),
                    ExampleStep(stepNumber: 3, description: "El sistema es consistente indeterminado: tiene infinitas soluciones. Cualquier punto de la recta x + 2y = 4 es solución.", formula: "Infinitas soluciones"),
                    ExampleStep(stepNumber: 4, description: "Podemos verificar: la primera ecuación es simplemente 2 veces la segunda: 2(x + 2y) = 2(4) → 2x + 4y = 8.", formula: nil)
                ]
            ),
            quizQuestions: [
                QuizQuestion(
                    question: "¿Cómo se clasifica un sistema que no tiene solución?",
                    options: ["Consistente determinado", "Consistente indeterminado", "Inconsistente", "Dependiente"],
                    correctIndex: 2,
                    explanationOnWrong: "Un sistema sin solución se llama inconsistente. Sus rectas son paralelas y nunca se cruzan.",
                    explanationOnWrongRetry: "Sin solución = inconsistente. Con una solución = consistente determinado. Con infinitas = consistente indeterminado."
                ),
                QuizQuestion(
                    question: "El sistema x + y = 3 y 2x + 2y = 8 es:",
                    options: ["Consistente determinado", "Consistente indeterminado", "Inconsistente", "No se puede determinar"],
                    correctIndex: 2,
                    explanationOnWrong: "Comparamos: a₁/a₂ = 1/2, b₁/b₂ = 1/2, c₁/c₂ = 3/8. Como 1/2 = 1/2 ≠ 3/8, el sistema es inconsistente (sin solución).",
                    explanationOnWrongRetry: "Los coeficientes son proporcionales (1/2 = 1/2) pero los independientes no (3/8 ≠ 1/2). Rectas paralelas = inconsistente."
                ),
                QuizQuestion(
                    question: "Si al resolver un sistema obtienes 0 = 5, ¿qué significa?",
                    options: [
                        "La solución es x = 5",
                        "El sistema tiene infinitas soluciones",
                        "El sistema es inconsistente (no tiene solución)",
                        "Hay un error de cálculo"
                    ],
                    correctIndex: 2,
                    explanationOnWrong: "Una contradicción como 0 = 5 indica que no existe ningún par de valores que satisfaga ambas ecuaciones. El sistema es inconsistente.",
                    explanationOnWrongRetry: "0 = 5 es falso siempre. Esto significa que las ecuaciones se contradicen y el sistema no tiene solución."
                ),
                QuizQuestion(
                    question: "Si al resolver un sistema obtienes 0 = 0, ¿qué significa?",
                    options: [
                        "La solución es x = 0, y = 0",
                        "El sistema es inconsistente",
                        "El sistema tiene infinitas soluciones",
                        "El sistema no tiene sentido"
                    ],
                    correctIndex: 2,
                    explanationOnWrong: "0 = 0 es siempre verdadero, lo cual indica que las ecuaciones son equivalentes. El sistema tiene infinitas soluciones.",
                    explanationOnWrongRetry: "Una identidad (0 = 0) significa que las ecuaciones son la misma recta: infinitas soluciones."
                )
            ]
        )
    ]
}
