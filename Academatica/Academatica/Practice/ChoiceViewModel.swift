//
//  ChoiceViewModel.swift
//  Academatica
//
//  Created by Roman on 11.03.2022.
//

import Foundation

struct ChoiceModel {
    var options: [String]
    var correctAnswers: [String]
}

class ChoiceViewModel: ObservableObject {
    var model: ChoiceModel
    
    init(model: ChoiceModel) {
        self.model = model
    }
}
