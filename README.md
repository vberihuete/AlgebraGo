# AlgebraGo

Aplicación móvil educativa para investigación de tesis de maestría sobre gamificación y microlearning en álgebra introductoria.

## Requisitos

- **Xcode 15+** (probado con Xcode 16)
- **iOS 17.0+**
- **macOS Sonoma o superior**
- **XcodeGen** (solo si necesitas regenerar el proyecto)

## Compilación

### Opción 1: Abrir directamente
```bash
open AlgebraGo.xcodeproj
```
Selecciona un simulador iPhone y presiona `Cmd+R`.

### Opción 2: Compilar desde terminal
```bash
xcodebuild -project AlgebraGo.xcodeproj \
  -scheme AlgebraGo \
  -destination 'platform=iOS Simulator,name=iPhone 16' \
  build
```

### Regenerar proyecto (si modificas la estructura)
```bash
brew install xcodegen  # solo la primera vez
xcodegen generate
```

## Distribución por TestFlight

1. **Configura el equipo de desarrollo:**
   - Abre `AlgebraGo.xcodeproj` en Xcode
   - Ve a la pestaña **Signing & Capabilities**
   - Selecciona tu equipo de desarrollo en **Team**
   - Verifica que el **Bundle Identifier** sea único: `com.thesis.algebrago`

2. **Crea un App en App Store Connect:**
   - Ve a [App Store Connect](https://appstoreconnect.apple.com)
   - Crea una nueva app con el Bundle ID configurado

3. **Archiva y sube:**
   - En Xcode: **Product → Archive**
   - En el Organizer: **Distribute App → App Store Connect**
   - Selecciona **Upload** y sigue las instrucciones

4. **Invita testers:**
   - En App Store Connect → TestFlight
   - Agrega testers internos o crea un grupo de testing externo
   - Comparte el enlace de invitación con los 40 participantes

## Estructura del Proyecto

```
Sources/
├── App/
│   ├── AlgebraGoApp.swift          # Punto de entrada
│   └── AppState.swift              # Estado global (auth, participante)
├── Core/
│   ├── Models/
│   │   ├── Participant.swift       # Modelo del participante
│   │   ├── Badge.swift             # Sistema de insignias
│   │   ├── ModuleModels.swift      # Progreso, quizzes, carga cognitiva
│   │   ├── SARTModels.swift        # Sesión y estímulos SART
│   │   ├── RetentionTestModels.swift # Tests de retención
│   │   └── UserLevel.swift         # Niveles y puntos
│   └── DesignSystem/
│       ├── Colors.swift            # Paleta de colores
│       ├── Typography.swift        # Tipografía
│       ├── Spacing.swift           # Tokens de espaciado
│       └── Components/             # PrimaryButton, CardView, MathText, etc.
├── Features/
│   ├── Onboarding/                 # Registro de participante
│   ├── Modules/
│   │   ├── Screens/                # Home, lista, detalle, quiz, progreso, perfil
│   │   └── Data/                   # 12 módulos de contenido algebraico
│   ├── SART/                       # Mini-SART (atención sostenida)
│   ├── RetentionTest/              # Pre-test y post-test (Formas A y B)
│   ├── Analytics/                  # Panel del investigador + exportación JSON
│   └── Survey/                     # Encuesta reflexiva final
└── Navigation/
    ├── RootView.swift              # Router principal
    └── MainTabView.swift           # TabBar con 4 pestañas
```

## Flujo del Usuario

1. **Onboarding:** código de participante → avatar → nivel → grupo
2. **Pre-test:** 20 preguntas sin retroalimentación (Forma A)
3. **Módulos:** 12 módulos en 3 unidades, cada uno con:
   - Explicación teórica con fórmulas
   - Ejemplo paso a paso
   - Quiz de 4 preguntas con retroalimentación
   - Escala de carga cognitiva (Leppink)
4. **Mini-SART:** tarea de atención en sesiones 2 y 4 de cada semana
5. **Post-test:** 20 preguntas (Forma B) al finalizar semana 6
6. **Encuesta reflexiva:** 12 ítems al final del estudio

## Exportación de Datos

1. Ve a **Perfil → Panel del Investigador**
2. PIN de acceso: `2026`
3. Presiona **Exportar Datos (JSON)** para exportar el participante actual
4. Presiona **Exportar Todos los Participantes** para exportar P01-P40
5. Usa el ShareSheet para enviar el archivo por AirDrop, correo o guardarlo

## Datos Recolectados

El JSON exportado incluye por participante:
- Código, avatar, nivel autodeclarado, grupo, fecha de inicio
- Progreso por módulo (estado, tiempo, intentos de quiz, puntajes)
- Sesiones Mini-SART (errores comisión/omisión, RT medio, DE del RT)
- Respuestas de carga cognitiva (intrínseca, extrínseca, germane)
- Tests de retención (respuestas, correcto/incorrecto, tiempo por ítem)
- Encuesta reflexiva (Likert + respuestas abiertas)
- Puntos, nivel, insignias, racha

## Notas para el Investigador

- **Grupo control:** solo ve onboarding, pre-test, post-test, escala Leppink y encuesta reflexiva. No ve gamificación.
- **Mini-SART:** timing preciso de 250ms estímulo + 900ms ISI. 180 estímulos, ~11% targets (dígito 3).
- **Sin conexión a internet requerida:** todos los datos se almacenan localmente.
- **Anonimato:** solo el código de participante identifica al usuario.
