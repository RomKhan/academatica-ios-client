//
//  File.swift
//  SmartMath
//
//  Created by Roman on 09.01.2022.
//

import Foundation

struct TierModel: Identifiable{
    let id: String
    let name: String
    let description: String
    let imageUrl: String
    let finishedPercentage: Int
    let isFineshed: Bool
}
