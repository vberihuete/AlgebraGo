import SwiftUI

struct RootView: View {
    @Environment(AppState.self) private var appState

    var body: some View {
        Group {
            if appState.isOnboarded, appState.participant != nil {
                if appState.showPreTest {
                    RetentionTestScreen(
                        form: "A",
                        onComplete: {
                            appState.showPreTest = false
                        }
                    )
                } else if appState.needsSART {
                    SARTScreen(
                        version: appState.pendingSARTVersion,
                        weekNumber: appState.participant?.currentWeekNumber() ?? 1,
                        sessionNumber: appState.participant?.totalSessionsThisWeek() ?? 1,
                        onComplete: {
                            appState.needsSART = false
                        }
                    )
                } else if appState.showPostTest {
                    RetentionTestScreen(
                        form: "B",
                        onComplete: {
                            appState.showPostTest = false
                        }
                    )
                } else if appState.showReflexiveSurvey {
                    ReflexiveSurveyScreen(
                        isExperimental: appState.participant?.groupType == .experimental,
                        onComplete: {
                            appState.showReflexiveSurvey = false
                        }
                    )
                } else {
                    MainTabView()
                }
            } else {
                OnboardingFlow()
            }
        }
        .animation(.easeInOut, value: appState.isOnboarded)
    }
}
