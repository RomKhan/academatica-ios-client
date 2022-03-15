//
//  ProgressBarViewModel.swift
//  SmartMath
//
//  Created by Roman on 09.01.2022.
//

import SwiftUI

class ProgressBarViewModel: ObservableObject {
    var percentages: CGFloat = 0
    
    init(percentages: CGFloat) {
        self.percentages = percentages
    }
}
