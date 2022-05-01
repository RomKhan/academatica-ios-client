//
//  TierCardViewModel.swift
//  SmartMath
//
//  Created by Roman on 09.01.2022.
//

import SwiftUI

class TierCardViewModel: ObservableObject {
    var model: TierModel = TierModel(
        id: "0",
        name: "1",
        description: "ewqe",
        completionRate: 56,
        isComplete: false,
        isUnlocked: true)
    
    init(model: TierModel) {
        self.model = model
    }
}
