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
    @State var image: Image? = nil
    
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
                                if (image == nil) {
                                    Image(uiImage: UIImage(named: "camera")!)
                                        .resizable()
                                        .scaledToFit()
                                        .padding(reader.size.width / 18)
                                        .background(.ultraThinMaterial)
                                }
                                else {
                                    image?
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
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
                                TextField("", text: $viewModel.lastName)
                                    .placeholder(when: viewModel.lastName.isEmpty) {
                                        Text("Фамилия")
                                            .foregroundColor(.white.opacity(0.5))
                                    }
                                    .padding()
                                    .background(.ultraThinMaterial)
                                    .cornerRadius(reader.size.width / 25)
                                    .padding(.top, reader.size.width / 30)
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
                            TextField("", text: $viewModel.username)
                                .placeholder(when: viewModel.username.isEmpty) {
                                    Text("Псевдоним")
                                        .foregroundColor(.white.opacity(0.5))
                                }
                                .padding()
                                .background(.ultraThinMaterial)
                                .cornerRadius(reader.size.width / 25)
                                .padding(.top, reader.size.width / 30)
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
                            viewModel.registrerStart()
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
                        HStack {
                            Spacer()
                            Rectangle()
                                .fill(
                                    LinearGradient(
                                        gradient: Gradient(stops: [
                                            .init(color: .white, location: 0.4),
                                            .init(color: .clear, location: 1)
                                        ]),
                                        startPoint: .trailing,
                                        endPoint: .leading)
                                )
                                .frame(width: reader.size.width / 6, height: 1)
                            Spacer()
                            Text("Или через сервисы")
                            Spacer()
                            Rectangle()
                                .fill(
                                    LinearGradient(
                                        gradient: Gradient(stops: [
                                            .init(color: .white, location: 0.4),
                                            .init(color: .clear, location: 1)
                                        ]),
                                        startPoint: .leading,
                                        endPoint: .trailing)
                                )
                                .frame(width: reader.size.width / 6, height: 1)
                            Spacer()
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.top, reader.size.width / 12)
                        HStack(spacing: reader.size.width / 20) {
                            ForEach(viewModel.images, id: \.self) { name in
                                Button {
                                    
                                } label: {
                                    Image(uiImage: UIImage(named: name)!)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(maxWidth: .infinity)
                                }
                            }
                            .blendMode(.overlay)
                            .padding(reader.size.width / 40)
                            .background(VisualEffectView(effect: UIBlurEffect(style: .light)).opacity(0.35))
                            .cornerRadius(reader.size.width / 28.5)
                        }
                        .frame(height: reader.size.height / 14)
                        .padding(.top, reader.size.width / 28)
                        
                    }
                    .frame(width: reader.size.width / 1.3, alignment: .leading)
                    .padding(.top, reader.size.height / 25)
                    .foregroundColor(.white)
                    .font(.system(size: reader.size.width / 31))
                }
                NavigationLink(isActive: $viewModel.showCodeEnterScreen) {
                    DataChangeView(viewModel: DataChangeViewModel(cancelFunc: viewModel.registerConfirm), mode: .codeConfirm)
                } label: {
                    EmptyView()
                }

            }
        }
        .navigationBarHidden(true)
        .lineLimit(1)
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(sourceType: .photoLibrary) { image in
                self.image = Image(uiImage: image)
            }
        }
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
