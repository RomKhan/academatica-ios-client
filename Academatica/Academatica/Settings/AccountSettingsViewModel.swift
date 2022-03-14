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
    ]
    
    let disclosureRows = [
        DisclosureRow(id: 0, title: "Персональные данные", icon: "person.fill", subRows: [
            DataSettingsRow(title: "Имя", isLast: false, settingsMode: .firstnameChange),
            DataSettingsRow(title: "Фамилия", isLast: false, settingsMode: .lastnameCgange),
            DataSettingsRow(title: "Псевдоним", isLast: true, settingsMode: .nicknameChange)
        ]),
        DisclosureRow(id: 1, title: "Безопасность", icon: "lock.fill", subRows: [
            DataSettingsRow(title: "Пароль", isLast: false, settingsMode: .passwordChange),
            DataSettingsRow(title: "Почта", isLast: true, settingsMode: .codeConfirm)
        ])
    ]
    
    // Метод запроса с сервера apiUsersIdImagePatch
    func patchPicture(image: UIImage) {
        UserService.shared.userModel?.profilePicUrl = URL(string: "https://static01.nyt.com/images/2017/11/08/well/family/well-fam-damour/well-fam-damour-articleLarge.jpg?quality=75&auto=webp&disable=upscale")!
    }
}
