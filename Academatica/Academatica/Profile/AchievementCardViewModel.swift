//
//  AchievemntCardViewModel.swift
//  SmartMath
//
//  Created by Roman on 15.01.2022.
//

import SwiftUI


class AchievementCardViewModel : ObservableObject {
    static var colorThemes = [
        [
            Color(uiColor: UIColor(red: 255 / 255.0, green: 26 / 255.0, blue: 136 / 255.0, alpha: 1)),
            Color(uiColor: UIColor(red: 87 / 255.0, green: 255 / 255.0, blue: 154 / 255.0, alpha: 1)),
            Color(uiColor: UIColor(red: 182 / 255.0, green: 125 / 255.0, blue: 143 / 255.0, alpha: 1)),
            Color(uiColor: UIColor(red: 184 / 255.0, green: 0 / 255.0, blue: 0 / 255.0, alpha: 1)).opacity(0.7)
        ],
        [
            Color(uiColor: UIColor(red: 87 / 255.0, green: 174 / 255.0, blue: 255 / 255.0, alpha: 1)),
            Color(uiColor: UIColor(red: 182 / 255.0, green: 26 / 255.0, blue: 255 / 255.0, alpha: 1)),
            Color(uiColor: UIColor(red: 125 / 255.0, green: 113 / 255.0, blue: 255 / 255.0, alpha: 1)),
            Color(uiColor: UIColor(red: 184 / 255.0, green: 0 / 255.0, blue: 0 / 255.0, alpha: 1)).opacity(0.7)
        ]
    ]
    var model: AchievementModel
    var colors: [Color] = [
        Color(uiColor: UIColor(red: 255 / 255.0, green: 26 / 255.0, blue: 136 / 255.0, alpha: 1)),
        Color(uiColor: UIColor(red: 87 / 255.0, green: 255 / 255.0, blue: 154 / 255.0, alpha: 1)),
        Color(uiColor: UIColor(red: 182 / 255.0, green: 125 / 255.0, blue: 143 / 255.0, alpha: 1)),
        Color(uiColor: UIColor(red: 184 / 255.0, green: 0 / 255.0, blue: 0 / 255.0, alpha: 1)).opacity(0.7)
    ]
    
    init(model: AchievementModel) {
        self.model = model
        colors = AchievementCardViewModel.colorThemes[Int.random(in: (0...1))]
        
    }
}

struct AchievementModel: Identifiable, Decodable {
    let id = UUID()
    let name: String
    let description: String
    let imageUrl: URL
    let achievedAmount: Int
    
    private enum CodingKeys: CodingKey {
        case name, description, imageUrl, achievedAmount
    }
}
