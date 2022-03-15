//
//  DataChangeViewModel.swift
//  Academatica
//
//  Created by Roman on 13.02.2022.
//

import SwiftUI

enum DataChangeViewMode {
    case firstnameChange
    case lastnameCgange
    case nicknameChange
    case passwordChange
    case emailChange
    case codeConfirm
    
    static func getNavigationTitle(mode: DataChangeViewMode) -> String {
        switch(mode) {
        case .firstnameChange:
            return "Смена имени"
        case .lastnameCgange:
            return "Смена фамилии"
        case .nicknameChange:
            return "Смена псевдонима"
        case .passwordChange:
            return "Смена пароля"
        case .emailChange:
            return "Смена почты"
        case .codeConfirm:
            return "Подтверждение кода"
        }
    }
    
    static func getMessage(mode: DataChangeViewMode) -> String {
        switch(mode) {
        case .firstnameChange:
            return "Введите новое имя"
        case .lastnameCgange:
            return "Введите новую фамилию"
        case .nicknameChange:
            return "Введите новывй псевдоним"
        case .passwordChange:
            return "Введите новый пароль"
        case .emailChange:
            return "Введите новый адрес электронной почты"
        case .codeConfirm:
            return "Введите код подтверждения из письма на электронной почте"
        }
    }
    
    static func getPlaceholder(mode: DataChangeViewMode) -> String {
        switch(mode) {
        case .firstnameChange:
            return "Имя"
        case .lastnameCgange:
            return "Фамилия"
        case .nicknameChange:
            return "Никнейм"
        case .passwordChange:
            return "Пароль"
        case .emailChange:
            return "example@gmail.com"
        case .codeConfirm:
            return "Код из письма"
        }
    }
}

class DataChangeViewModel: ObservableObject {
    @Published var serverState = ServerState.none
    @Published var text: String = ""
    @Published var newPassword: String = ""
    @Published var newPasswordConfirm: String = ""
    @Published var showSecondaryMode = false {
        didSet {
            print(text, showSecondaryMode)
            print(Thread.callStackSymbols.joined(separator: "\n"))
        }
    }
    @Published var secondaryMode: DataChangeViewMode = .emailChange
    @Published var errorMessage: String = ""
    @Published var callback: ((Bool) -> ())?
    var confirmationCode: String = ""
    var colors: [Color] = [
        Color(uiColor: UIColor(red: 92 / 255.0, green: 0 / 255.0, blue: 149 / 255.0, alpha: 1)),
        Color(uiColor: UIColor(red: 81 / 255.0, green: 132 / 255.0, blue: 209 / 255.0, alpha: 1)),
        Color(uiColor: UIColor(red: 0 / 255.0, green: 212 / 255.0, blue: 110 / 255.0, alpha: 1))
    ]
    
    init() { }
    
    init(secondaryMode: DataChangeViewMode) {
        self.secondaryMode = secondaryMode
    }
    
    init(confirmationCode: String, callback: ((Bool) -> ())?) {
        self.confirmationCode = confirmationCode
        self.callback = callback
    }
    
    func cancel(mode: DataChangeViewMode) {
        serverState = .loading
        
        switch mode {
        case .firstnameChange:
            firstNameChange()
        case .lastnameCgange:
            lastNameChange()
        case .nicknameChange:
            userNameChange()
        case .passwordChange:
            passwordChange()
        case .emailChange:
            emailChange()
        case .codeConfirm:
            confirmCode()
        }
    }
    
    func firstNameChange() {
        errorMessage = ""
        serverState = .loading

        UserService.shared.changeFirstName(newFirstName: text) { [weak self] success in
            if success {
                self?.serverState = .success
            } else {
                self?.serverState = .error
                self?.errorMessage = "Что-то пошло не так"
            }
        }
    }

    func lastNameChange() {
        errorMessage = ""
        serverState = .loading

        UserService.shared.changeLastName(newLastName: text) { [weak self] success in
            if success {
                self?.serverState = .success
            } else {
                self?.serverState = .error
                self?.errorMessage = "Что-то пошло не так"
            }
        }
    }

    func userNameChange() {
        errorMessage = ""
        serverState = .loading

        UserService.shared.changeUsername(newUsername: text) { [weak self] success in
            if success {
                self?.serverState = .success
            } else {
                self?.serverState = .error
                self?.errorMessage = "Что-то пошло не так"
            }
        }
    }

    func confirmCode() {
        errorMessage = ""
        serverState = .loading

        switch secondaryMode {
        case .emailChange:
            UserService.shared.checkEmailConfirmationCode(text) { [weak self] success in
                if success {
                    self?.serverState = .none
                    self?.showSecondaryMode = true
                    self?.callback = { success in
                        if success {
                            self?.serverState = .success
                        }
                    }
                } else {
                    self?.serverState = .error
                    self?.errorMessage = "Код не прошёл проверку"
                }
            }
        case .passwordChange:
            UserService.shared.checkPasswordConfirmationCode(text) { [weak self] success in
                if success {
                    self?.serverState = .none
                    self?.showSecondaryMode = true
                    self?.callback = { success in
                        if success {
                            self?.serverState = .success
                        }
                    }
                } else {
                    self?.serverState = .error
                    self?.errorMessage = "Код не прошёл проверку"
                }
            }
        default:
            serverState = .error
            errorMessage = "INTERNAL: Неверный вторичный режим"
        }
    }

    func passwordChange() {
        serverState = .loading
        errorMessage = ""

        if newPassword != newPasswordConfirm {
            serverState = .error
            errorMessage = "Пароли не совпадают!"
            return
        }

        UserService.shared.changeUserPassword(oldPassword: text, newPassword: newPassword, newPasswordConfirm: newPasswordConfirm) { [weak self] success, error in
            if success {
                self?.serverState = .success
                self?.callback?(true)
            } else {
                self?.serverState = .error
                self?.callback?(false)
                if let error = error {
                    self?.errorMessage = error
                }
            }
        }
    }

    func emailChange() {
        errorMessage = ""
        serverState = .loading

        UserService.shared.changeUserEMail(confirmationCode: confirmationCode, newEmail: text) { [weak self] success, error in
            if success {
                self?.serverState = .success
                self?.callback?(true)
                UserService.shared.logOff()
                UserService.shared.authorizationNotification = "Подтвердите Ваш новый адрес"
            } else {
                self?.serverState = .error
                self?.callback?(false)
                if let error = error {
                    self?.errorMessage = error
                }
            }
        }
    }
}
