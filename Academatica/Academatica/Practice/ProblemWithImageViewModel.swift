//
//  ProblemWithImageViewModel.swift
//  Academatica
//
//  Created by Roman on 12.03.2022.
//

import Foundation

struct ProblemWithImageModel {
    let imageUrl: URL?
    let correctAnswer: [String]
}

class ProblemWithImageViewModel: ObservableObject {
    let model: ProblemWithImageModel
    
    init(model: ProblemWithImageModel) {
        self.model = model
    }
}
