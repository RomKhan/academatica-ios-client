//
//  AuthorizationViewModel.swift
//  Academatica
//
//  Created by Roman on 16.02.2022.
//

import Foundation
import Combine

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
    @Published var serverState = ServerState.none
    @Published var notification: String = ""
    
    private var cancellables = Set<AnyCancellable>()
    
    public init() {
        UserService.shared.$authorizationNotification.sink { [weak self] newValue in
            self?.notification = newValue
        }.store(in: &cancellables)
    }
    
    func updateButtonPublisher() {
        if (email != "" && password != "") {
            isButtonEnabled = .active
        } else {
            isButtonEnabled = .disable
        }
    }
    
    func logIn(completion: @escaping (Bool, String?) -> Void) {
        serverState = .loading
        UserService.shared.logIn(email: email, password: password, completion: completion)
    }
}
