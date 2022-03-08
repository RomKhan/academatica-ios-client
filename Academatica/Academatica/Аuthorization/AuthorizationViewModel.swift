//
//  AuthorizationViewModel.swift
//  Academatica
//
//  Created by Roman on 16.02.2022.
//

import Foundation

enum ServerState {
    case none
    case loading
    case success
    case error
}

class AuthorizationViewModel: ObservableObject {
    @Published var email: String = "" {
        didSet {
            updateButtonPublisher()
        }
    }
    @Published var password: String = "" {
        didSet {
            updateButtonPublisher()
        }
    }
    @Published var isButtonEnabled: ButtonState = .disable
    var images = ["google", "Facebook", "apple"]
    
    func updateButtonPublisher() {
        if (email != "" && password != "") {
            isButtonEnabled = .active
        } else {
            isButtonEnabled = .disable
        }
    }
    
    @Published var serverState = ServerState.none
    
    func logIn() {
        serverState = .loading
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            UserService.logIn(userName: self?.email, password: self?.password)
            self?.serverState = .none
            self?.email = ""
            self?.password = ""
        }
    }
}
