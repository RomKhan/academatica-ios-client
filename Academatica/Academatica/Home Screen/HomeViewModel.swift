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
                              ]),
        PracticeCardViewModel(model: PracticeCardModel(title: "Своя практика", countOfTasks: 10, imageName: "support"),
                              colors: [
                                Color(uiColor: UIColor(
                                    red: 236 / 255.0,
                                    green: 140 / 255.0,
                                    blue: 140 / 255.0,
                                    alpha: 1)),
                                Color(uiColor: UIColor(
                                    red: 249 / 255.0,
                                    green: 58 / 255.0,
                                    blue: 58 / 255.0,
                                    alpha: 1)),
                                Color(uiColor: UIColor(
                                    red: 245 / 255.0,
                                    green: 133 / 255.0,
                                    blue: 155 / 255.0,
                                    alpha: 1))
                              ])
    ]
    
    @Published var userModel: UserModel?
    @Published var userState: UserStateModel?
    @Published var recommendedTopicId: String?
    @Published var completedTopicsCount: Int = 0
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        updateData()
        
        UserService.shared.$userModel.sink { [weak self] newValue in
            self?.userModel = newValue
        }.store(in: &cancellables)
        
        UserStateService.shared.$userState.sink { [weak self] newValue in
            self?.userState = newValue
        }.store(in: &cancellables)
        
        CourseService.shared.$recommendedTopic.sink { [weak self] newValue in
            self?.recommendedTopicId = newValue?.id
        }.store(in: &cancellables)
        
        CourseService.shared.$completedTopicCount.sink { [weak self] newValue in
            self?.completedTopicsCount = newValue
        }.store(in: &cancellables)
    }
    
    func updateData() {
        UserService.shared.userSetup()
        UserStateService.shared.updateUserState()
        CourseService.shared.getRecommendedPracticeTopic()
        CourseService.shared.getCompletedTopicsCount()
    }
}
