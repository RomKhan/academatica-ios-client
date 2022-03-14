//
//  PracticeModel.swift
//  Academatica
//
//  Created by Roman on 10.03.2022.
//

import Foundation

struct ProblemModel: Identifiable, Equatable, Decodable {
    let id: String
    let classId: String
    let topicId: String
    let description: String
    let task: String
    let problemType: String
    let options: [String]
    let imageUrl: URL?
    let correctAnswers: [String]
    let expression: String?
    let difficulty: Int
}
