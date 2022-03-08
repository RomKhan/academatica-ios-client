//
//  LeadBoardsViewModel.swift
//  SmartMath
//
//  Created by Roman on 16.01.2022.
//

import SwiftUI

class LeadBoardsViewModel: ObservableObject {
    static var themes = [
        [
            Color(uiColor: UIColor(red: 255 / 255.0, green: 168 / 255.0, blue: 0 / 255.0, alpha: 1)),
            Color(uiColor: UIColor(red: 255 / 255.0, green: 107 / 255.0, blue: 0 / 255.0, alpha: 1)),
            Color(uiColor: UIColor(red: 255 / 255.0, green: 185 / 255.0, blue: 80 / 255.0, alpha: 1)),
            Color(uiColor: UIColor(red: 242 / 255.0, green: 0 / 255.0, blue: 0 / 255.0, alpha: 1))
        ]
    ]
    
    var leadboardUsers: [UserModel] = [
        UserModel(id: UUID(), email: "asd", userName: "Петя", firstName: "Петя", lastName: "Петя", registereAt: "Неважно", profilePicURL: URL(string: "https://static.honeykidsasia.com/wp-content/uploads/2017/02/raising-a-teenager-in-Singapore-HERO.jpg")),
        UserModel(id: UUID(), email: "asd", userName: "Петя", firstName: "Петя", lastName: "Петя", registereAt: "Неважно", profilePicURL: URL(string: "https://static.honeykidsasia.com/wp-content/uploads/2017/02/raising-a-teenager-in-Singapore-HERO.jpg")),
        UserModel(id: UUID(), email: "asd", userName: "Петя", firstName: "Петя", lastName: "Петя", registereAt: "Неважно", profilePicURL: URL(string: "https://static.honeykidsasia.com/wp-content/uploads/2017/02/raising-a-teenager-in-Singapore-HERO.jpg")),
        UserModel(id: UUID(), email: "asd", userName: "Петя", firstName: "Петя", lastName: "Петя", registereAt: "Неважно", profilePicURL: URL(string: "https://static.honeykidsasia.com/wp-content/uploads/2017/02/raising-a-teenager-in-Singapore-HERO.jpg")),
        UserModel(id: UUID(), email: "asd", userName: "Петя", firstName: "Петя", lastName: "Петя", registereAt: "Неважно", profilePicURL: URL(string: "https://static.honeykidsasia.com/wp-content/uploads/2017/02/raising-a-teenager-in-Singapore-HERO.jpg")),
        UserModel(id: UUID(), email: "asd", userName: "Петя", firstName: "Петя", lastName: "Петя", registereAt: "Неважно", profilePicURL: URL(string: "https://static.honeykidsasia.com/wp-content/uploads/2017/02/raising-a-teenager-in-Singapore-HERO.jpg")),
        UserModel(id: UUID(), email: "asd", userName: "Петя", firstName: "Петя", lastName: "Петя", registereAt: "Неважно", profilePicURL: URL(string: "https://static.honeykidsasia.com/wp-content/uploads/2017/02/raising-a-teenager-in-Singapore-HERO.jpg")),
        UserModel(id: UUID(), email: "asd", userName: "Петя", firstName: "Петя", lastName: "Петя", registereAt: "Неважно", profilePicURL: URL(string: "https://static.honeykidsasia.com/wp-content/uploads/2017/02/raising-a-teenager-in-Singapore-HERO.jpg"))
    ]
    let userPlace = 723
    var colors: [Color] = []
    var peopleCounter = 1
    @State var isLoadingUsers = false
    
    init() {
        colors = LeadBoardsViewModel.themes[0]
    }
    
    func loadMoreUsersIfNeeded(currentItem item: UserModel) {
        if (item.id == leadboardUsers[leadboardUsers.count - 1].id && !isLoadingUsers) {
            isLoadingUsers.toggle()
            DispatchQueue.global().sync { [weak self] in
                self?.leadboardUsers.append(UserModel(id: UUID(),
                                                email: "asd",
                                                userName: "Петя",
                                                firstName: "Петя",
                                                lastName: "Петя",
                                                registereAt: "Неважно",
                                                profilePicURL: URL(string: "https://static.honeykidsasia.com/wp-content/uploads/2017/02/raising-a-teenager-in-Singapore-HERO.jpg"))
                )
                self?.isLoadingUsers.toggle()
            }
        }
    }
}
