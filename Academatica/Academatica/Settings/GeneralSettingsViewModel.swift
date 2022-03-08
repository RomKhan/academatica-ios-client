//
//  GeneralSettingsViewModel.swift
//  Academatica
//
//  Created by Roman on 11.02.2022.
//

import SwiftUI

class GeneralSettingsViewModel: ObservableObject {
    var colors: [Color] = [
        Color(uiColor: UIColor(red: 189 / 255.0, green: 0 / 255.0, blue: 255 / 255.0, alpha: 1)),
        Color(uiColor: UIColor(red: 0 / 255.0, green: 240 / 255.0, blue: 255 / 255.0, alpha: 1)),
        Color(uiColor: UIColor(red: 0 / 255.0, green: 163 / 255.0, blue: 255 / 255.0, alpha: 1)),
        Color(uiColor: UIColor(red: 0 / 255.0, green: 255 / 255.0, blue: 117 / 255.0, alpha: 1)),
        Color(uiColor: UIColor(red: 89 / 255.0, green: 89 / 255.0, blue: 89 / 255.0, alpha: 1))
    ]
    let userModel = UserModel(id: UUID(),
                              email: "fsfd@gmail.com",
                              userName: "jreyers",
                              firstName: "Jaseon",
                              lastName: "Reyers",
                              registereAt: "312",
                              profilePicURL: URL(string: "https://static.honeykidsasia.com/wp-content/uploads/2017/02/raising-a-teenager-in-Singapore-HERO.jpg"))
}
