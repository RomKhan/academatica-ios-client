//
//  TierModel.swift
//  SmartMath
//
//  Created by Roman on 09.01.2022.
//

import Foundation

struct TierModel: Identifiable, Decodable {
    let id: String
    let name: String
    let description: String
    let completionRate: Int
    let isComplete: Bool
    let isUnlocked: Bool
}
