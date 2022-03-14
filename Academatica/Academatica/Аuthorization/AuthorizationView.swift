//
//  AuthorizationView.swift
//  Academatica
//
//  Created by Roman on 16.02.2022.
//

import SwiftUI

struct AuthorizationView: View {
    @StateObject var viewModel = AuthorizationViewModel()
    
    var body: some View {
        GeometryReader { reader in
            ZStack {
                Background()
                ScrollView(showsIndicators: false) {
                    Image(uiImage: UIImage(named: "AuthImage")!)
                        .resizable()
                        .scaledToFit()
                        .frame(width: reader.size.width / 1.7)
                        .padding(.top, reader.size.width / 9)
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Привествуем!")
                            .font(.system(size: reader.size.width / 13, weight: .heavy))
                        Text("Войдите в свою четную запись")
                            .font(.system(size: reader.size.width / 25, weight: .thin))
                            .padding(.top, 14)
                        TextField("", text: $viewModel.email)
                            .placeholder(when: viewModel.email.isEmpty) {
                                Text("Адрес электронной почты")
                                    .foregroundColor(.white.opacity(0.5))
                            }
                            .padding()
                            .background(.ultraThinMaterial)
                            .cornerRadius(reader.size.width / 25)
                            .padding(.top, reader.size.width / 10)
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                        SecureField("", text: $viewModel.password)
                            .placeholder(when: viewModel.password.isEmpty) {
                                Text("Пароль")
                                    .foregroundColor(.white.opacity(0.5))
                            }
                            .padding()
                            .background(.ultraThinMaterial)
                            .cornerRadius(reader.size.width / 25)
                            .padding(.top, reader.size.width / 30)
                            .foregroundColor(.white)
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                        ZStack {
                            switch viewModel.serverState {
                            case .none:
                                EmptyView()
                            case .loading:
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle(tint: Color.white))
                            case .error:
                                Text("Попробуйте еще раз")
                                    .foregroundColor(.red)
                                    .font(.system(size: 12))
                            case .success:
                                EmptyView()
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: reader.size.width / 10)
                        Button {
                            viewModel.logIn() { success, message in
                                if !success {
                                    self.viewModel.email = ""
                                    self.viewModel.password = ""
                                    self.viewModel.serverState = .error
                                    if let message = message {
                                        self.viewModel.notification = message
                                    }
                                } else {
                                    self.viewModel.serverState = .success
                                }
                            }
                        } label: {
                            Text("Войти")
                                .font(.system(size: reader.size.width / 26.5, weight: .bold))
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(viewModel.isButtonEnabled.getColor())
                                .cornerRadius(reader.size.width / 25)
                                .shadow(color: viewModel.isButtonEnabled.getColor().opacity(0.5), radius: 8, x: 0, y: 4)
                        }
                        .disabled(viewModel.isButtonEnabled == .disable ? true : false)
                        
                        HStack {
                            Text("Еще нет аккаунта?")
                            NavigationLink {
                                RegistrationView()
                            } label: {
                                Text("Зарегистрируйтесь")
                                    .foregroundColor(Color(uiColor: UIColor(red: 248 / 255.0, green: 112 / 255.0, blue: 255 / 255.0, alpha: 1)))
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.top, reader.size.width / 28)
                        Text(viewModel.notification)
                        .padding(.top, reader.size.width / 28)
                        .frame(maxWidth: .infinity)
                        .lineLimit(2)
                    }
                    .frame(width: reader.size.width / 1.3, alignment: .leading)
                    .padding(.top, reader.size.height / 25)
                    .foregroundColor(.white)
                    .font(.system(size: reader.size.width / 31))
                }
            }
        }
    }
}

struct AuthorizationView_Previews: PreviewProvider {
    static var previews: some View {
        AuthorizationView()
    }
}
