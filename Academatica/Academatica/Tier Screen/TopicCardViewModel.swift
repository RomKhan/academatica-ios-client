//
//  File.swift
//  SmartMath
//
//  Created by Roman on 10.01.2022.
//

import SwiftUI

class TopicCardViewModel: ObservableObject {
    let gradient: Gradient =
    Gradient(stops: [
        .init(color: Color(uiColor: UIColor(red: 54 / 255.0, green: 153 / 255.0, blue: 208 / 255.0, alpha: 1)), location: -0.1),
        .init(color: Color(uiColor: UIColor(red: 131 / 255.0, green: 33 / 255.0, blue: 147 / 255.0, alpha: 1)), location: 1)
    ])
    var topicModel: TopicModel
    
    init(topicModel: TopicModel) {
        self.topicModel = topicModel
    }
}
