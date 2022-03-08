//
//  AccountSettingsViewModel.swift
//  Academatica
//
//  Created by Roman on 13.02.2022.
//

import SwiftUI

struct DisclosureRow: Identifiable {
    let id: Int
    var title: String
    var icon: String
    var subRows: [DataSettingsRow]
}

struct DataSettingsRow: Identifiable {
    let id = UUID()
    var title: String
    var isLast: Bool
    var settingsMode: DataChangeViewMode
}

class AccountSettingsViewModel: ObservableObject {
    var colors: [Color] = [
        Color(uiColor: UIColor(red: 92 / 255.0, green: 0 / 255.0, blue: 149 / 255.0, alpha: 1)),
        Color(uiColor: UIColor(red: 81 / 255.0, green: 132 / 255.0, blue: 209 / 255.0, alpha: 1))
//        Color(uiColor: UIColor(red: 0 / 255.0, green: 163 / 255.0, blue: 255 / 255.0, alpha: 1)),
//        Color(uiColor: UIColor(red: 0 / 255.0, green: 255 / 255.0, blue: 117 / 255.0, alpha: 1)),
//        Color(uiColor: UIColor(red: 89 / 255.0, green: 89 / 255.0, blue: 89 / 255.0, alpha: 1))
    ]
    let userModel = UserModel(id: UUID(),
                              email: "fsfd@gmail.com",
                              userName: "jreyers",
                              firstName: "Jaseon",
                              lastName: "Reyers",
                              registereAt: "312",
                              profilePicURL: URL(string: "https://static.honeykidsasia.com/wp-content/uploads/2017/02/raising-a-teenager-in-Singapore-HERO.jpg"))
    let disclosureRows = [
        DisclosureRow(id: 0, title: "Персональные данные", icon: "person.fill", subRows: [
            DataSettingsRow(title: "Имя", isLast: false, settingsMode: .firstnameChange),
            DataSettingsRow(title: "Фамилия", isLast: false, settingsMode: .lastnameCgange),
            DataSettingsRow(title: "Псевдоним", isLast: true, settingsMode: .nicknameChange)
        ]),
        DisclosureRow(id: 1, title: "Безопасность", icon: "lock.fill", subRows: [
            DataSettingsRow(title: "Пароль", isLast: false, settingsMode: .passwordChange),
            DataSettingsRow(title: "Почта", isLast: true, settingsMode: .emailChange)
        ])
    ]
}
