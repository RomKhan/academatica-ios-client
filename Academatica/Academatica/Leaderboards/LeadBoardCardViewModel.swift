//
//  LeadBoardCardViewModel.swift
//  SmartMath
//
//  Created by Roman on 16.01.2022.
//

import Foundation
import Combine

class LeadBoardCardViewModel : ObservableObject {
    @Published var leagueName: String = ""
    @Published var message: String?
    @Published var imageName: String?
    @Published var timeNow: String = "Заканчивается в следующее воскресение"
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        UserStateService.shared.$userLeaderboardState.sink { [weak self] newValue in
            switch newValue?.league {
            case .bronze:
                self?.leagueName = "Бронзовая"
                self?.imageName = "third"
                self?.message = "Победитель выигрывает 500 очков опыта!"
            case .silver:
                self?.leagueName = "Серебряная"
                self?.imageName = "second"
                self?.message = "Победитель выигрывает день бесконечных спасательных кругов!"
            case .gold:
                self?.leagueName = "Золотая"
                self?.imageName = "first"
                self?.message = "Победитель выигрывает неделю бесконечных спасательных кругов!"
            default:
                self?.leagueName = ""
                self?.imageName = ""
            }
        }.store(in: &cancellables)
    }
    
    func viewUpdate() {
        UserStateService.shared.updateUserLeaderboardState()
    }
}
