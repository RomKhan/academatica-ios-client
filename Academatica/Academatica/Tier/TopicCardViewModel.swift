//
//  File.swift
//  SmartMath
//
//  Created by Roman on 10.01.2022.
//

import SwiftUI

class TopicCardViewModel: ObservableObject {
    let gradient: Gradient = ColorService.getRandomGradient()
    
    var topicModel: TopicModel
    
    init(topicModel: TopicModel) {
        self.topicModel = topicModel
    }
}
