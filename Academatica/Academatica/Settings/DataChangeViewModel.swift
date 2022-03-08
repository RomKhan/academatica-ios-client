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
            return "Введие код подтверждения из пиьма на электронной почте"
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
            return "код из пьима"
        }
    }
}

class DataChangeViewModel: ObservableObject {
    var cancelFunc: ((String) -> ())?
    @Published var serverState = ServerState.none
    @Published var text: String = ""
    var colors: [Color] = [
        Color(uiColor: UIColor(red: 92 / 255.0, green: 0 / 255.0, blue: 149 / 255.0, alpha: 1)),
        Color(uiColor: UIColor(red: 81 / 255.0, green: 132 / 255.0, blue: 209 / 255.0, alpha: 1)),
        Color(uiColor: UIColor(red: 0 / 255.0, green: 212 / 255.0, blue: 110 / 255.0, alpha: 1))
//        Color(uiColor: UIColor(red: 0 / 255.0, green: 255 / 255.0, blue: 117 / 255.0, alpha: 1)),
//        Color(uiColor: UIColor(red: 89 / 255.0, green: 89 / 255.0, blue: 89 / 255.0, alpha: 1))
    ]
    
    init() {}
    init(cancelFunc: ((String) -> ())?) {
        self.cancelFunc = cancelFunc
    }
    
    func cancel() {
        serverState = .loading
        cancelFunc?(text)
    }
}
