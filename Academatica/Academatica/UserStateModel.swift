//
//  UserStateModel.swift
//  Academatica
//
//  Created by Roman on 13.01.2022.
//

import Foundation

struct UserStateModel : Identifiable {
    var id: String
    var exp: Int
    var buoysLeft: Int
    var daysStreak: Int
    var lastClassFinishedAt: String
    var legue: String
}
