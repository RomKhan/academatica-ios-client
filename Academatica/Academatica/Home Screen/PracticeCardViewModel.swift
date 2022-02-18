//
//  PracticeCardViewModel.swift
//  SmartMath
//
//  Created by Roman on 08.01.2022.
//

import SwiftUI

class PracticeCardViewModel : ObservableObject {
    var model: PracticeCardModel = PracticeCardModel(title: "error", countOfTasks: -1)
    var colors: [Color] = [
        Color(uiColor: UIColor.red),
        Color(uiColor: UIColor.blue),
        Color(uiColor: UIColor.green)
    ]
    
    init(model: PracticeCardModel, colors: [Color]) {
        self.model = model
        self.colors = colors
    }
}
