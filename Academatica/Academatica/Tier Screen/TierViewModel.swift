//
//  File.swift
//  SmartMath
//
//  Created by Roman on 09.01.2022.
//

import SwiftUI

class TierViewModel: ObservableObject {
    let TierCardModels: [TierModel] = [
        TierModel(
            id: "0",
            name: "4",
            description: "Introduction to geometry, units of measurement, simple equations, more about arithmetic operations.",
            imageUrl: "",
            finishedPercentage: 56,
            isFineshed: false),
        TierModel(
            id: "1",
            name: "5",
            description: "Introduction to geometry, units of measurement, simple equations, more about arithmetic operations.",
            imageUrl: "",
            finishedPercentage: 56,
            isFineshed: false),
        TierModel(
            id: "2",
            name: "6",
            description: "Introduction to geometry, units of measurement, simple equations, more about arithmetic operations.",
            imageUrl: "",
            finishedPercentage: 56,
            isFineshed: false),
        TierModel(
            id: "3",
            name: "7",
            description: "Introduction to geometry, units of measurement, simple equations, more about arithmetic operations.",
            imageUrl: "",
            finishedPercentage: 56,
            isFineshed: false)
    ]
    var countOfAlgebraTopics: Int = 4
    var countOfGeometryTopics: Int = 1
    var TopicModels: [TopicModel] = [
        TopicModel(id: "0",
                   name: "Units of measurement",
                   description: "fdsfd",
                   isAlgebraTopics: true,
                   imageURL: "",
                   isFineshed: false,
                   amountOfClasses: 5,
                   amoutTimeToComplete: 45),
        TopicModel(id: "1",
                   name: "Units of measurement",
                   description: "fdsfd",
                   isAlgebraTopics: true,
                   imageURL: "",
                   isFineshed: false,
                   amountOfClasses: 6,
                   amoutTimeToComplete: 45),
        TopicModel(id: "4",
                   name: "Units of measurement",
                   description: "fdsfd",
                   isAlgebraTopics: true,
                   imageURL: "",
                   isFineshed: false,
                   amountOfClasses: 1,
                   amoutTimeToComplete: 45),
        TopicModel(id: "5",
                   name: "Units of measurement",
                   description: "fdsfd",
                   isAlgebraTopics: true,
                   imageURL: "",
                   isFineshed: false,
                   amountOfClasses: 9,
                   amoutTimeToComplete: 45),
        TopicModel(id: "2",
                   name: "UwU",
                   description: "fdsfd",
                   isAlgebraTopics: false,
                   imageURL: "",
                   isFineshed: false,
                   amountOfClasses: 7,
                   amoutTimeToComplete: 45),
    ]
}
