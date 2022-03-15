import SwiftUI
import Combine

class HomeViewModel: ObservableObject {
    let practiseCardsViewModels = [
        PracticeCardViewModel(model: PracticeCardModel(title: "Завершённые темы", countOfTasks: 10, imageName: "tick-inside-circle"),
                              colors: [
                                Color(uiColor: UIColor(
                                    red: 239 / 255.0,
                                    green: 147 / 255.0,
                                    blue: 126 / 255.0,
                                    alpha: 1)),
                                Color(uiColor: UIColor(
                                    red: 170 / 255.0,
                                    green: 30 / 255.0,
                                    blue: 245 / 255.0,
                                    alpha: 1)),
                                Color(uiColor: UIColor(
                                    red: 206 / 255.0,
                                    green: 92 / 255.0,
                                    blue: 182 / 255.0,
                                    alpha: 1))
                              ]),
        PracticeCardViewModel(model: PracticeCardModel(title: "Рекомендованная тема", countOfTasks: 10, imageName: "star"),
                              colors: [
                                Color(uiColor: UIColor(
                                    red: 126 / 255.0,
                                    green: 192 / 255.0,
                                    blue: 239 / 255.0,
                                    alpha: 1)),
                                Color(uiColor: UIColor(
                                    red: 30 / 255.0,
                                    green: 77 / 255.0,
                                    blue: 245 / 255.0,
                                    alpha: 1)),
                                Color(uiColor: UIColor(
                                    red: 92 / 255.0,
                                    green: 144 / 255.0,
                                    blue: 206 / 255.0,
                                    alpha: 1))
                              ])
    ]
    
    @Published var userModel: UserModel?
    @Published var userState: UserStateModel?
    @Published var recommendedTopicId: String?
    @Published var completedTopicsCount: Int = 0
    @Published var practicesUnlocked: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        UserService.shared.$userModel.sink { [weak self] newValue in
            self?.userModel = newValue
        }.store(in: &cancellables)
        
        UserStateService.shared.$userState.sink { [weak self] newValue in
            self?.userState = newValue
        }.store(in: &cancellables)
        
        CourseService.shared.$recommendedTopic.sink { [weak self] newValue in
            self?.recommendedTopicId = newValue?.id
            if self?.completedTopicsCount != 0 && self?.recommendedTopicId != nil {
                self?.practicesUnlocked = true
            } else {
                self?.practicesUnlocked = false
            }
        }.store(in: &cancellables)
        
        CourseService.shared.$completedTopicCount.sink { [weak self] newValue in
            self?.completedTopicsCount = newValue
            if self?.completedTopicsCount != 0 && self?.recommendedTopicId != nil {
                self?.practicesUnlocked = true
            } else {
                self?.practicesUnlocked = false
            }
        }.store(in: &cancellables)
    }
    
    func updateData() {
        UserService.shared.userSetup()
        UserStateService.shared.updateUserState()
        CourseService.shared.getRecommendedPracticeTopic()
        CourseService.shared.getCompletedTopicsCount()
    }
}
