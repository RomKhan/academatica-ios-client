//
//  ClassModel.swift
//  SmartMath
//
//  Created by Roman on 19.01.2022.
//

import Foundation

struct ClassModel : Identifiable, Decodable {
    var id: String
    var name: String
    var description: String
    var expReward: Int
    var imageUrl: URL?
    var theoryUrl: URL
    var problemNum: Int
    var topicName: String
    var isComplete: Bool
    var isUnlocked: Bool
}
