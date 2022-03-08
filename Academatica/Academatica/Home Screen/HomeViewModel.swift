import SwiftUI

class HomeViewModel: ObservableObject {
    let practiseCardsViewModels = [
        PracticeCardViewModel(model: PracticeCardModel(title: "Completed Topics", countOfTasks: 10, imageName: "tick-inside-circle"),
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
        PracticeCardViewModel(model: PracticeCardModel(title: "Recomended Topics", countOfTasks: 10, imageName: "star"),
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
        PracticeCardViewModel(model: PracticeCardModel(title: "Custom Practice", countOfTasks: 10, imageName: "support"),
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
    
    @Published var daysStreak: Int? = UserService.daysStreak
    @Published var firstName: String? = UserService.userModel.firstName
    
    init() {
        updateData()
    }
    func updateData() {
        firstName = UserService.userModel.firstName
        apiUsersIdStateGet()
        
        
    }
    
    func apiUsersIdStateGet() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
            UserService.daysStreak = Int.random(in: (0...10))
            self?.daysStreak = UserService.daysStreak
        }
    }
}
