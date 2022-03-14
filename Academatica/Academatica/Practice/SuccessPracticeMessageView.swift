//
//  SuccessPracticeMessageView.swift
//  Academatica
//
//  Created by Roman on 11.03.2022.
//

import SwiftUI

struct SuccessPracticeMessageView: View {
    @StateObject var viewModel: SuccessPracticeMessageViewModel
    var body: some View {
        VStack {
            Text("Практика завершена".uppercased())
                .foregroundColor(.white)
                .font(.system(size: UIScreen.main.bounds.height / 35))
                .padding(.top, UIScreen.main.bounds.height / 25)
            LottieView(name: "practiceFinished", loopMode: .playOnce)
                .frame(height: UIScreen.main.bounds.width)
            Text("+\(viewModel.expCount) опыта".uppercased())
                .foregroundColor(Color(uiColor: UIColor(red: 0 / 255.0, green: 212 / 255.0, blue: 110 / 255.0, alpha: 1)))
                .font(.system(size: 25, weight: .heavy))
                .shadow(color: Color(uiColor: UIColor(red: 0 / 255.0, green: 212 / 255.0, blue: 110 / 255.0, alpha: 1)), radius: 10, x: 0, y: 0)
            if viewModel.buoysAdded {
                Text("+1 круг".uppercased())
                    .foregroundColor(Color.white)
                    .font(.system(size: 25, weight: .bold))
            }
            
            ZStack {
                Group {
                    if viewModel.serverState == .loading {
                        ProgressView()
                    } else if viewModel.serverState == .error {
                        Text("Нет доступа к сети")
                            .foregroundColor(.red)
                    }
                }
                .padding(.top, UIScreen.main.bounds.height / 20)
                
                if (viewModel.serverState == .none) {
                    Button {
                        viewModel.cancel()
                    } label: {
                        Text("Продолжить")
                            .font(.system(size: UIScreen.main.bounds.height / 52, weight: .bold))
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color(uiColor: UIColor(red: 0 / 255.0, green: 212 / 255.0, blue: 110 / 255.0, alpha: 1)))
                            .cornerRadius(UIScreen.main.bounds.height / 60)
                            .shadow(color: Color(uiColor: UIColor(red: 0 / 255.0, green: 212 / 255.0, blue: 110 / 255.0, alpha: 1)), radius: 8, x: 0, y: 4)
                    }
                    .offset(y: UIScreen.main.bounds.height / 6)
                    .padding(.horizontal, UIScreen.main.bounds.height / 25)
                } else if (viewModel.serverState == .error) {
                    VStack {
                        Button {
                            viewModel.cancel()
                        } label: {
                            Text("Попробовать еще раз")
                                .font(.system(size: UIScreen.main.bounds.height / 52, weight: .bold))
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color(uiColor: UIColor(red: 0 / 255.0, green: 212 / 255.0, blue: 110 / 255.0, alpha: 1)))
                                .cornerRadius(UIScreen.main.bounds.height / 60)
                                .shadow(color: Color(uiColor: UIColor(red: 0 / 255.0, green: 212 / 255.0, blue: 110 / 255.0, alpha: 1)), radius: 8, x: 0, y: 4)
                        }
                        Button {
                            viewModel.exitFunc()
                        } label: {
                            Text("Выйти")
                                .font(.system(size: UIScreen.main.bounds.height / 52, weight: .bold))
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(.red)
                                .cornerRadius(UIScreen.main.bounds.height / 60)
                                .shadow(color: Color(uiColor: UIColor(red: 255 / 255.0, green: 101 / 255.0, blue: 92 / 255.0, alpha: 1)), radius: 8, x: 0, y: 4)
                        }
                    }
                    .offset(y: UIScreen.main.bounds.height / 7.5)
                    .padding(.horizontal, UIScreen.main.bounds.height / 25)
                }
            }
        }
        .animation(.easeOut, value: viewModel.serverState)
        .transition(.opacity)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .onAppear() {
            viewModel.finish()
        }
    }
}

struct SuccessPracticeMessageView_Previews: PreviewProvider {
    static var previews: some View {
        SuccessPracticeMessageView(viewModel: SuccessPracticeMessageViewModel(exit: {}, cancelFunc: {_ in }, classId: nil, topicId: nil, mistakeCount: 0, practiceType: .completedLessons, dismiss: {}))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                LinearGradient(
                    gradient: Gradient(
                        stops: [
                            .init(color: Color(uiColor: UIColor(red: 0 / 255.0, green: 59 / 255.0, blue: 149 / 255.0, alpha: 1)), location: 0),
                            .init(color: Color(uiColor: UIColor(red: 132 / 255.0, green: 163 / 255.0, blue: 185 / 255.0, alpha: 1)), location: 1.1)
                        ]),
                    startPoint: .topTrailing,
                    endPoint: .bottomLeading)
            )
    }
}
