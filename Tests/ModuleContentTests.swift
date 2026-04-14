import Testing
import Foundation
@testable import AlgebraGo

struct ModuleContentTests {

    // MARK: - Module Count

    @Test func allModules_has12Modules() {
        #expect(ModuleContentData.allModules.count == 12)
    }

    // MARK: - Unit Distribution

    @Test func unit1_has4Modules() {
        let unit1 = ModuleContentData.allModules.filter { $0.unitNumber == 1 }
        #expect(unit1.count == 4)
    }

    @Test func unit2_has4Modules() {
        let unit2 = ModuleContentData.allModules.filter { $0.unitNumber == 2 }
        #expect(unit2.count == 4)
    }

    @Test func unit3_has4Modules() {
        let unit3 = ModuleContentData.allModules.filter { $0.unitNumber == 3 }
        #expect(unit3.count == 4)
    }

    // MARK: - Module IDs

    @Test func allModules_haveUniqueIds() {
        let ids = ModuleContentData.allModules.map(\.id)
        let uniqueIds = Set(ids)
        #expect(ids.count == uniqueIds.count)
    }

    @Test func allModules_followIdConvention() {
        let expectedIds = ["1_1", "1_2", "1_3", "1_4",
                           "2_1", "2_2", "2_3", "2_4",
                           "3_1", "3_2", "3_3", "3_4"]
        let actualIds = ModuleContentData.allModules.map(\.id).sorted()
        #expect(actualIds == expectedIds.sorted())
    }

    // MARK: - Content Completeness

    @Test func allModules_haveExplanationSteps() {
        for module in ModuleContentData.allModules {
            #expect(!module.explanation.isEmpty,
                    "Module \(module.id) must have explanation steps")
        }
    }

    @Test func allModules_haveAtLeast3ExplanationSteps() {
        for module in ModuleContentData.allModules {
            #expect(module.explanation.count >= 3,
                    "Module \(module.id) should have at least 3 explanation steps, has \(module.explanation.count)")
        }
    }

    @Test func allModules_haveExampleWithAtLeast3Steps() {
        for module in ModuleContentData.allModules {
            #expect(module.example.steps.count >= 3,
                    "Module \(module.id) example should have at least 3 steps, has \(module.example.steps.count)")
        }
    }

    @Test func allModules_haveExactly4QuizQuestions() {
        for module in ModuleContentData.allModules {
            #expect(module.quizQuestions.count == 4,
                    "Module \(module.id) must have exactly 4 quiz questions, has \(module.quizQuestions.count)")
        }
    }

    @Test func allQuizQuestions_have4Options() {
        for module in ModuleContentData.allModules {
            for (i, question) in module.quizQuestions.enumerated() {
                #expect(question.options.count == 4,
                        "Module \(module.id) Q\(i+1) must have 4 options")
            }
        }
    }

    @Test func allQuizQuestions_haveValidCorrectIndex() {
        for module in ModuleContentData.allModules {
            for (i, question) in module.quizQuestions.enumerated() {
                #expect(question.correctIndex >= 0 && question.correctIndex <= 3,
                        "Module \(module.id) Q\(i+1) correctIndex \(question.correctIndex) out of range")
            }
        }
    }

    @Test func allQuizQuestions_haveExplanations() {
        for module in ModuleContentData.allModules {
            for (i, question) in module.quizQuestions.enumerated() {
                #expect(!question.explanationOnWrong.isEmpty,
                        "Module \(module.id) Q\(i+1) must have first attempt explanation")
                #expect(!question.explanationOnWrongRetry.isEmpty,
                        "Module \(module.id) Q\(i+1) must have retry explanation")
            }
        }
    }

    @Test func allModules_haveNonEmptyTitles() {
        for module in ModuleContentData.allModules {
            #expect(!module.title.isEmpty, "Module \(module.id) must have a title")
        }
    }

    // MARK: - ModuleProgress

    @Test func moduleProgress_defaultsToNotStarted() {
        let progress = ModuleProgress(moduleId: "1_1")
        #expect(progress.status == .notStarted)
        #expect(progress.timeSpentSeconds == 0)
        #expect(progress.quizAttempts.isEmpty)
        #expect(progress.cognitiveLoadScore == nil)
    }

    // MARK: - QuizAttempt

    @Test func quizAttempt_encodesAndDecodes() throws {
        let attempt = QuizAttempt(
            attemptNumber: 1,
            answers: [0, 2, 1, 3],
            correctAnswers: [0, 2, 1, 2],
            score: 0.75,
            timestamp: Date()
        )

        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        let data = try encoder.encode(attempt)

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let decoded = try decoder.decode(QuizAttempt.self, from: data)

        #expect(decoded.attemptNumber == 1)
        #expect(decoded.score == 0.75)
        #expect(decoded.answers == [0, 2, 1, 3])
        #expect(decoded.correctAnswers == [0, 2, 1, 2])
    }
}
