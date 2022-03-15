//
//  TabBarViewModel.swift
//  Academatica
//
//  Created by Roman on 04.01.2022.
//

import Foundation
import SwiftUI
import Combine

struct Screen: Identifiable {
    let id = UUID()
    let image: String
    let type: ScreenType
}

enum ScreenType {
    case home
    case lesson
    case profile
    case leadboard
    
    var description : String {
        switch self {
        case .home: return "Главная"
        case .lesson: return "Уроки"
        case .profile: return "Профиль"
        case .leadboard: return "Лиги"
        }
    }
}

class TabBarViewModel : ObservableObject {
    private var screens: [Screen]
    var Screens: [Screen] {
        get {
            return screens
        }
    }
    init() {
        screens = [Screen(image: "house", type: .home),
                   Screen(image: "book.closed", type: .lesson),
                   Screen(image: "person", type: .profile),
                   Screen(image: "flag", type: .leadboard)]
    }
}
