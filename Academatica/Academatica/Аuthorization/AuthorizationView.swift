//
//  AuthorizationView.swift
//  Academatica
//
//  Created by Roman on 16.02.2022.
//

import SwiftUI

struct AuthorizationView: View {
    @StateObject var viewModel = AuthorizationViewModel()
    @State var email: String = ""
    @State var password: String = ""
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
                        TextField("", text: $email)
                            .placeholder(when: email.isEmpty) {
                                Text("Адрес электронной почты")
                                    .foregroundColor(.white.opacity(0.5))
                            }
                            .padding()
                            .background(.ultraThinMaterial)
                            .cornerRadius(reader.size.width / 25)
                            .padding(.top, reader.size.width / 10)
                        SecureField("", text: $password)
                            .placeholder(when: password.isEmpty) {
                                Text("Пароль")
                                    .foregroundColor(.white.opacity(0.5))
                            }
                            .padding()
                            .background(.ultraThinMaterial)
                            .cornerRadius(reader.size.width / 25)
                            .padding(.top, reader.size.width / 30)
                            .foregroundColor(.white)
                        NavigationLink {
                            TabBar(viewModel: TabBarViewModel()
//                                   , windowScene: AcadematicaApp.windowScene
                            )
                        } label: {
                            Text("Войти")
                                .font(.system(size: reader.size.width / 26.5, weight: .bold))
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(viewModel.colors[0])
                                .cornerRadius(reader.size.width / 25)
                                .shadow(color: viewModel.colors[1].opacity(0.5), radius: 8, x: 0, y: 4)
                        }
                        .padding(.top, reader.size.width / 10)
                        
                        HStack {
                            Text("Еще нет аккаунта?")
                            NavigationLink {
                                RegistrationView()
                            } label: {
                                Text("Зарегистрируйтесь")
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
                
            }
        }
    }
}

struct AuthorizationView_Previews: PreviewProvider {
    static var previews: some View {
        AuthorizationView()
    }
}
