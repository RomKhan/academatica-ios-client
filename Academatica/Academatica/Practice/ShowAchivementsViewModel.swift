//
//  ShowAchivementsViewModel.swift
//  Academatica
//
//  Created by Roman on 12.03.2022.
//

import Foundation
import Combine

class ShowAchivementsViewModel: ObservableObject {
    @Published var achivements: [AchievementModel]
    private var cancellables = Set<AnyCancellable>()
    var exitFunc: (() -> ())
    
    init(achivements: [AchievementModel], exit: @escaping (() -> ())) {
        self.exitFunc = exit
        self.achivements = achivements
        
        CourseService.shared.$lastAchievements.sink { [weak self] newValue in
            self?.achivements = newValue
        }.store(in: &cancellables)
    }
}
