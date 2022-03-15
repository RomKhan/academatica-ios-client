//
//  TopicModel.swift
//  Academatica
//
//  Created by Roman on 10.01.2022.
//

import Foundation

struct TopicModel: Identifiable, Decodable {
    let id: String
    let name: String
    let description: String
    let isAlgebraTopic: Bool
    let imageUrl: URL?
    let isComplete: Bool
    let isUnlocked: Bool
    let completionRate: Int
    let classCount: Int
}
