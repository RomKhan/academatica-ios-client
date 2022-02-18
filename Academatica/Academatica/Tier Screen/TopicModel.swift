//
//  File.swift
//  SmartMath
//
//  Created by Roman on 10.01.2022.
//

import Foundation

struct TopicModel: Identifiable {
    let id: String
    let name: String
    let description: String
    let isAlgebraTopics: Bool
    let imageURL: String
    let isFineshed: Bool
    let amountOfClasses: Int
    let amoutTimeToComplete: Int
}
