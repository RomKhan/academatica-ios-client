//
//  AccountSettingsViewModel.swift
//  Academatica
//
//  Created by Roman on 13.02.2022.
//

import SwiftUI
import Combine

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
    var animationStart = false
    @Published var serverStatus = ServerState.none {
        didSet {
            if (serverStatus != .loading && !animationStart) {
                animationStart = true
                    withAnimation(.easeOut(duration: 2)) {
                        serverStatus = .none
                    }
                animationStart = false
            }
        }
    }
    @Published var serverMessgae: String = ""
    var colors: [Color] = [
        Color(uiColor: UIColor(red: 92 / 255.0, green: 0 / 255.0, blue: 149 / 255.0, alpha: 1)),
        Color(uiColor: UIColor(red: 81 / 255.0, green: 132 / 255.0, blue: 209 / 255.0, alpha: 1))
    ]
    
    @Published var userModel: UserModel?
    
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
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        UserService.shared.$userModel.sink { [weak self] newValue in
            if let newValue = newValue {
                self?.userModel = newValue
            }
        }.store(in: &cancellables)
    }
    
    func patchPicture(image: UIImage) {
        serverStatus = .loading
        UserService.shared.changeImage(newImage: image) { [weak self] state, message in
            if let message = message {
                self?.serverMessgae = message
            }
            
            if state {
                UserService.shared.userSetup()
                self?.serverStatus = .success
            } else {
                self?.serverStatus = .error
            }
        }
    }
}
