import Foundation

struct ModuleProgress: Codable, Identifiable {
    var id: String { moduleId }
    var moduleId: String
    var status: ModuleStatus
    var startDate: Date?
    var completionDate: Date?
    var timeSpentSeconds: Int
    var quizAttempts: [QuizAttempt]
    var cognitiveLoadScore: CognitiveLoadResponse?

    init(moduleId: String) {
        self.moduleId = moduleId
        self.status = .notStarted
        self.timeSpentSeconds = 0
        self.quizAttempts = []
    }
}

enum ModuleStatus: String, Codable {
    case notStarted = "not_started"
    case inProgress = "in_progress"
    case completed = "completed"
}

struct QuizAttempt: Codable, Identifiable {
    var id: UUID = UUID()
    var attemptNumber: Int
    var answers: [Int]
    var correctAnswers: [Int]
    var score: Double
    var timestamp: Date
}

// MARK: - Module Content Data

struct ModuleContent: Identifiable {
    var id: String
    var unitNumber: Int
    var moduleNumber: Int
    var title: String
    var explanation: [ExplanationStep]
    var example: StepByStepExample
    var quizQuestions: [QuizQuestion]
}

struct ExplanationStep: Identifiable {
    var id = UUID()
    var text: String
    var formula: String?
}

struct StepByStepExample: Identifiable {
    var id = UUID()
    var title: String
    var steps: [ExampleStep]
}

struct ExampleStep: Identifiable {
    var id = UUID()
    var stepNumber: Int
    var description: String
    var formula: String?
}

struct QuizQuestion: Identifiable {
    var id = UUID()
    var question: String
    var options: [String]
    var correctIndex: Int
    var explanationOnWrong: String
    var explanationOnWrongRetry: String
}

// MARK: - Cognitive Load Scale (Leppink et al., 2013)

struct CognitiveLoadResponse: Codable, Identifiable {
    var id: UUID = UUID()
    var moduleId: String
    var responses: [Int]   // 9 items, each 1-9
    var timestamp: Date

    var intrinsicLoad: Double {
        guard responses.count >= 3 else { return 0 }
        return Double(responses[0] + responses[1] + responses[2]) / 3.0
    }

    var extraneousLoad: Double {
        guard responses.count >= 6 else { return 0 }
        return Double(responses[3] + responses[4] + responses[5]) / 3.0
    }

    var germaneLoad: Double {
        guard responses.count >= 9 else { return 0 }
        return Double(responses[6] + responses[7] + responses[8]) / 3.0
    }
}
