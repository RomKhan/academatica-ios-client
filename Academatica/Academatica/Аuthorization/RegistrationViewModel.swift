//
//  RegistrationViewModel.swift
//  Academatica
//
//  Created by Roman on 16.02.2022.
//

import SwiftUI

class RegistrationViewModel: ObservableObject {
    var colors: [Color] = [
        Color(uiColor: UIColor(red: 0 / 255.0, green: 212 / 255.0, blue: 110 / 255.0, alpha: 1)),
        Color(uiColor: UIColor(red: 0 / 255.0, green: 212 / 255.0, blue: 110 / 255.0, alpha: 1)),
        Color(uiColor: UIColor(red: 248 / 255.0, green: 112 / 255.0, blue: 255 / 255.0, alpha: 1))
    ]
    var images = ["google", "Facebook", "apple"]
}
