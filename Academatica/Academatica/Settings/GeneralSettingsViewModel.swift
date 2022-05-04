//
//  GeneralSettingsViewModel.swift
//  Academatica
//
//  Created by Roman on 11.02.2022.
//

import SwiftUI
import Combine

enum UserDefaultsKeys: String {
    case notifications
}

class GeneralSettingsViewModel: ObservableObject {
    var colors: [Color] = [
        Color(uiColor: UIColor(red: 189 / 255.0, green: 0 / 255.0, blue: 255 / 255.0, alpha: 1)),
        Color(uiColor: UIColor(red: 0 / 255.0, green: 240 / 255.0, blue: 255 / 255.0, alpha: 1)),
        Color(uiColor: UIColor(red: 0 / 255.0, green: 163 / 255.0, blue: 255 / 255.0, alpha: 1)),
        Color(uiColor: UIColor(red: 0 / 255.0, green: 255 / 255.0, blue: 117 / 255.0, alpha: 1)),
        Color(uiColor: UIColor(red: 89 / 255.0, green: 89 / 255.0, blue: 89 / 255.0, alpha: 1))
    ]
    
    @Published var toggle: Bool! {
        didSet {
            let defaults = UserDefaults.standard
            let key = UserDefaultsKeys.notifications.rawValue
            defaults.set(toggle, forKey: key)
        }
    }
    
    @Published var userModel: UserModel?
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        toggle = UserDefaults.standard.bool(forKey: UserDefaultsKeys.notifications.rawValue)
        UserService.shared.$userModel.sink { [weak self] newValue in
            if let newValue = newValue {
                self?.userModel = newValue
            }
        }.store(in: &cancellables)
    }
    
    func logOut() {
        UserService.shared.logOff()
    }
    
}
