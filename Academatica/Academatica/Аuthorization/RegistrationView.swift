//
//  RegistrationView.swift
//  Academatica
//
//  Created by Roman on 16.02.2022.
//

import SwiftUI

struct RegistrationView: View {
    @StateObject var viewModel = RegistrationViewModel()
    @Environment(\.dismiss) var dismiss
    @State var showImagePicker: Bool = false
    
    var body: some View {
        GeometryReader { reader in
            ZStack {
                Background()
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Регистрация")
                            .font(.system(size: reader.size.width / 13, weight: .heavy))
                        Text("Создайте новую учетную запись")
                            .font(.system(size: reader.size.width / 25, weight: .thin))
                            .padding(.top, 14)
                        HStack(spacing: reader.size.width / 25) {
                            Button {
                                showImagePicker.toggle()
                            } label: {
                                if let image = viewModel.image {
                                    Image(uiImage: image)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                } else {
                                    Image(uiImage: UIImage(named: "camera")!)
                                        .resizable()
                                        .scaledToFit()
                                        .padding(reader.size.width / 18)
                                        .background(.ultraThinMaterial)
                                }
                            }
                            .frame(
                                width: UIScreen.main.bounds.height / 8.05,
                                height: UIScreen.main.bounds.height / 8
                            )
                            .cornerRadius(reader.size.width / 25)
                            VStack(spacing: 0) {
                                TextField("", text: $viewModel.firstName)
                                    .placeholder(when: viewModel.firstName.isEmpty) {
                                        Text("Имя")
                                            .foregroundColor(.white.opacity(0.5))
                                    }
                                    .padding()
                                    .background(.ultraThinMaterial)
                                    .cornerRadius(reader.size.width / 25)
                                    .disableAutocorrection(true)
                                TextField("", text: $viewModel.lastName)
                                    .placeholder(when: viewModel.lastName.isEmpty) {
                                        Text("Фамилия")
                                            .foregroundColor(.white.opacity(0.5))
                                    }
                                    .padding()
                                    .background(.ultraThinMaterial)
                                    .cornerRadius(reader.size.width / 25)
                                    .padding(.top, reader.size.width / 30)
                                    .disableAutocorrection(true)
                            }
                        }
                        .padding(.top, reader.size.width / 10)
                        VStack(spacing: 0) {
                            TextField("", text: $viewModel.email)
                                .placeholder(when: viewModel.email.isEmpty) {
                                    Text("Адрес электронной почты")
                                        .foregroundColor(.white.opacity(0.5))
                                }
                                .padding()
                                .background(.ultraThinMaterial)
                                .cornerRadius(reader.size.width / 25)
                                .disableAutocorrection(true)
                                .autocapitalization(.none)
                            TextField("", text: $viewModel.username)
                                .placeholder(when: viewModel.username.isEmpty) {
                                    Text("Псевдоним")
                                        .foregroundColor(.white.opacity(0.5))
                                }
                                .padding()
                                .background(.ultraThinMaterial)
                                .cornerRadius(reader.size.width / 25)
                                .padding(.top, reader.size.width / 30)
                                .disableAutocorrection(true)
                                .autocapitalization(.none)
                        }
                        .padding(.top, reader.size.width / 18)
                        VStack(spacing: 0) {
                            SecureField("", text: $viewModel.password)
                                .placeholder(when: viewModel.password.isEmpty) {
                                    Text("Пароль")
                                        .foregroundColor(.white.opacity(0.5))
                                }
                                .padding()
                                .background(.ultraThinMaterial)
                                .cornerRadius(reader.size.width / 25)
                                .foregroundColor(.white)
                                .disableAutocorrection(true)
                                .autocapitalization(.none)
                            SecureField("", text: $viewModel.confirmPassword)
                                .placeholder(when: viewModel.confirmPassword.isEmpty) {
                                    Text("Подтвердите пароль")
                                        .foregroundColor(.white.opacity(0.5))
                                }
                                .padding()
                                .background(.ultraThinMaterial)
                                .cornerRadius(reader.size.width / 25)
                                .padding(.top, reader.size.width / 30)
                                .foregroundColor(.white)
                                .disableAutocorrection(true)
                                .autocapitalization(.none)
                        }
                        .padding(.top, reader.size.width / 18)

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
                        .frame(height: reader.size.width / 8)
                        
                        Button {
                            viewModel.signUp() { [self] success, message in
                                if success {
                                    self.viewModel.transitionToAuthScreen = true
                                    UserService.shared.authorizationNotification = "Подтвердите Ваш адрес для входа"
                                } else {
                                    if let message = message {
                                        self.viewModel.notification = message
                                    }
                                    self.viewModel.serverState = .error
                                }
                                self.viewModel.serverState = .success
                            }
                        } label: {
                            Text("Зарегистрироваться")
                                .font(.system(size: reader.size.width / 26.5, weight: .bold))
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(viewModel.isButtonEnabled.getColor())
                                .cornerRadius(reader.size.width / 25)
                                .shadow(color: viewModel.isButtonEnabled.getColor().opacity(0.5), radius: 8, x: 0, y: 4)
                        }
                        .disabled(viewModel.isButtonEnabled == .disable ? true : false)
                        
                        HStack {
                            Text("Уже есть аккаунт?")
                            Button {
                                dismiss()
                            } label: {
                                Text("Войдите")
                                    .foregroundColor(viewModel.colors[2])
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
                NavigationLink(isActive: $viewModel.transitionToAuthScreen) {
                    AuthorizationView()
                        .navigationBarHidden(true)
                } label: {
                    EmptyView()
                }.navigationBarBackButtonHidden(true)
            }
        }
        .navigationBarHidden(true)
        .lineLimit(1)
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(sourceType: .photoLibrary) { image in
                self.viewModel.image = image
            }
        }
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
