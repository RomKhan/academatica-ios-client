//
//  RegistrationViewModel.swift
//  Academatica
//
//  Created by Roman on 16.02.2022.
//

import SwiftUI

class RegistrationViewModel: ObservableObject {
    @Published var showCodeEnterScreen: Bool = false
    @Published var firstName: String = "" {
        didSet {
            updateButtonPublisher()
        }
    }
    
    @Published var lastName: String = "" {
        didSet {
            updateButtonPublisher()
        }
    }
    
    @Published var email: String = "" {
        didSet {
            updateButtonPublisher()
        }
    }
    
    @Published var username: String = "" {
        didSet {
            updateButtonPublisher()
        }
    }
    
    @Published var password: String = "" {
        didSet {
            updateButtonPublisher()
        }
    }
    
    @Published var confirmPassword: String = "" {
        didSet {
            updateButtonPublisher()
        }
    }
    
    @Published var isButtonEnabled: ButtonState = .disable
    @Published var serverState = ServerState.none
    
    var colors: [Color] = [
        Color(uiColor: UIColor(red: 0 / 255.0, green: 212 / 255.0, blue: 110 / 255.0, alpha: 1)),
        Color(uiColor: UIColor(red: 0 / 255.0, green: 212 / 255.0, blue: 110 / 255.0, alpha: 1)),
        Color(uiColor: UIColor(red: 248 / 255.0, green: 112 / 255.0, blue: 255 / 255.0, alpha: 1))
    ]
    var images = ["google", "Facebook", "apple"]
    
    func updateButtonPublisher() {
        if (firstName != "" &&
            lastName != "" &&
            email != "" &&
            username != "" &&
            password != "" &&
            confirmPassword != "") {
            isButtonEnabled = .active
        } else {
            isButtonEnabled = .disable
        }
    }
    
    func registrerStart() {
        serverState = .loading
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            UserService.registerStart(firstName: self?.firstName, lastName: self?.lastName, userName: self?.username, email: self?.email, password: self?.password)
            self?.showCodeEnterScreen.toggle()
        }
    }
    
    func registerConfirm(code: String?) {
        
        UserService.registerConfirm(code: code)
        
        serverState = .none
        firstName = ""
        lastName = ""
        email = ""
        username = ""
        password = ""
        confirmPassword = ""
    }
}
