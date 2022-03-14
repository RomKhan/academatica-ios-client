//
//  ClassModel.swift
//  Academatica
//
//  Created by Vladislav on 11.03.2022.
//

import Foundation

struct UpcomingClassModel: Decodable, Identifiable {
    let id: String
    let topicId: String
    let tierId: String
    let name: String
    let description: String
    let expReward: Int
    let imageUrl: URL?
    let theoryUrl: URL
    let problemNum: Int
    let isAlgebraClass: Bool
    let topicName: String
    let classNumber: Int
    let topicClassCount: Int
}
