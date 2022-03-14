//
//  ShowAchivementsViewModel.swift
//  Academatica
//
//  Created by Roman on 12.03.2022.
//

import Foundation

class ShowAchivementsViewModel: ObservableObject {
    @Published var achivements: [AchievementModel]
    var exitFunc: (() -> ())
    
    init(achivements: [AchievementModel], exit: @escaping (() -> ())) {
        self.exitFunc = exit
        self.achivements = achivements
    }
}
