//
//  CardToolModel.swift
//  SmartMath
//
//  Created by Roman on 07.01.2022.
//

import Foundation

struct CardData : Identifiable {
    var id: Int
    var nameOfTopic: String
    var nameOfLesson: String
    var descriptionOfLesson: String
    var countOfLessons: Int
    var numberOfCurrentLesson: Int
    var expCount: Int
}
