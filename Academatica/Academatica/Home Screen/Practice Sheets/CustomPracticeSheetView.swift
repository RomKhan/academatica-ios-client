//
//  PracticeSheet.swift
//  SmartMath
//
//  Created by Roman on 18.02.2022.
//

import SwiftUI

struct CustomPracticeSheetView: View {
    @StateObject var viewModel = CustomPracticeSheetViewModel()
    @State var selectedTier: String = "5"
    @Binding var showConstructor: Bool
    @Binding var practiceShow: Bool
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            ZStack(alignment: .top) {
                CustomPracticeSheetBackground()
                    .fill(
                        LinearGradient(
                            gradient:
                                Gradient(stops: [
                                    .init(color:
                                            Color(uiColor: UIColor(
                                                red: 239 / 255.0,
                                                green: 147 / 255.0,
                                                blue: 126 / 255.0,
                                                alpha: 1)),
                                          location: 0),
                                    .init(color:
                                            Color(uiColor: UIColor(
                                                red: 170 / 255.0,
                                                green: 30 / 255.0,
                                                blue: 245 / 255.0,
                                                alpha: 1)),
                                          location: 0.7)
                                ]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing)
                    )
                    .frame(height: UIScreen.main.bounds.height)
                VStack(spacing: 0) {
                    ZStack {
                        Text("Конструктор практики")
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.white)
                            .font(.system(size: 18, weight: .bold))
                        Button {
                            showConstructor.toggle()
                        } label: {
                            Image(systemName: "xmark")
                                .font(Font.system(size: 15, weight: .bold))
                                .frame(width: 30, height: 30)
                                .foregroundColor(.white)
                                .padding(2)
                                .background(.ultraThinMaterial)
                                .cornerRadius(100)
                        }
                        .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, UIScreen.main.bounds.height / 30)
                    Text("Выберите темы".uppercased())
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.white)
                        .padding(.vertical, UIScreen.main.bounds.height / 28)
                    VStack {
                    if (viewModel.serverState == .loading) {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach((5...11), id: \.self) { index in
                                    Text("Уровень ?")
                                        .foregroundColor(.clear)
                                        .padding(.horizontal, 20)
                                        .padding(.vertical, 7)
                                        .background(
                                            RoundedRectangle(cornerRadius: 10)
                                                .stroke(.white, lineWidth: 2)
                                                .background(.ultraThinMaterial)
                                                .cornerRadius(10)
                                                .shadow(color: .white.opacity(0.2), radius: 10, x: 0, y: 0)
                                        )
                                }
                                .foregroundColor(.white)
                            }
                            .padding(.horizontal, UIScreen.main.bounds.height / 40)
                        }
                        .disabled(viewModel.tierCardModels.isEmpty ? true : false)
                        .blendMode(.overlay)
                        
                        CustomPracticeCardStackView(viewModel: CustomPracticeCardStackViewModel(tierId: "-1"))
                            .padding()
                            .frame(height: 190)
                    } else if (viewModel.serverState == .success) {
                        if (!viewModel.tierCardModels.isEmpty) {
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack {
                                    ForEach(viewModel.tierCardModels) { model in
                                        Text("Уровень \(model.name)")
                                            .onTapGesture {
                                                withAnimation {
                                                    viewModel.selectedTier = model
                                                }
                                            }
                                            .padding(.horizontal, 20)
                                            .padding(.vertical, 7)
                                            .background(
                                                RoundedRectangle(cornerRadius: 10)
                                                    .stroke(.white, lineWidth: 2)
                                                    .background(.ultraThinMaterial)
                                                    .opacity(viewModel.selectedTier != nil && viewModel.selectedTier!.id == model.id ? 1 : 0)
                                                    .cornerRadius(10)
                                                    .shadow(color: .white.opacity(0.2), radius: 10, x: 0, y: 0)
                                            )
                                    }
                                    .animation(.spring(), value: selectedTier)
                                    .foregroundColor(.white)
                                }
                                .onAppear(perform: {
                                    viewModel.selectedTier = viewModel.tierCardModels[0]
                                })
                                .padding(.horizontal, UIScreen.main.bounds.height / 40)
                            }
                            .disabled(viewModel.tierCardModels.isEmpty ? true : false)
                            .blendMode(.overlay)
                            
                            ZStack {
                                ForEach(viewModel.tierCardModels) { tier in
                                    CustomPracticeCardStackView(viewModel: CustomPracticeCardStackViewModel(tierId: tier.id))
                                        .opacity(viewModel.selectedTier != nil && tier.id == viewModel.selectedTier!.id ? 1 : 0)
                                        .padding()
                                }
                            }.frame(maxHeight: 190)
                        } else {
                            HStack(spacing: 20) {
                                Image("sad-face-in-rounded-square")
                                    .resizable()
                                    .scaledToFit()
                                    .padding(.vertical, UIScreen.main.bounds.height / 20)
                                    .padding(.leading, UIScreen.main.bounds.height / 20)
                                    .blendMode(.overlay)
                                Text("Больше нет доступных тем для выбора 🤷")
                                    .font(.system(size: UIScreen.main.bounds.height / 60))
                                    .multilineTextAlignment(.center)
                                    .blendMode(.overlay)
                                    .padding(.trailing, UIScreen.main.bounds.height / 20)
                            }
                            .frame(height: UIScreen.main.bounds.height / 4.4)
                            .frame(maxWidth: .infinity)
                            .background(.ultraThinMaterial)
                            .cornerRadius(UIScreen.main.bounds.height / 50)
                            .padding()
                            .shadow(color: .black.opacity(0.3), radius: 20, x: 0, y: 0)
                        }
                    } else {
                        HStack(spacing: 20) {
                            Image("warning")
                                .resizable()
                                .scaledToFit()
                                .padding(.vertical, UIScreen.main.bounds.height / 20)
                                .padding(.leading, UIScreen.main.bounds.height / 20)
                                .blendMode(.overlay)
                            Text("Не удалось загрузить данные с сервера 😰")
                                .font(.system(size: UIScreen.main.bounds.height / 60))
                                .multilineTextAlignment(.center)
                                .blendMode(.overlay)
                                .padding(.trailing, UIScreen.main.bounds.height / 20)
                        }
                        .frame(height: UIScreen.main.bounds.height / 4.4)
                        .frame(maxWidth: .infinity)
                        .background(.ultraThinMaterial)
                        .cornerRadius(UIScreen.main.bounds.height / 50)
                        .padding()
                        .shadow(color: .black.opacity(0.3), radius: 20, x: 0, y: 0)
                    }
                    }
                    .frame(height: UIScreen.main.bounds.height / 4)
                    
                }
                VStack {
                    if (viewModel.serverState == .loading) {
                        ProgressView("Идет загрузка...")
                            .font(.system(size: UIScreen.main.bounds.height / 55.6))
                            .padding(.top, UIScreen.main.bounds.height / 6)
                    }
                    else if (viewModel.choicedTopics.isEmpty && viewModel.serverState == .success) {
                        Text("Вы еще не выбрали ни одной темы 😔")
                            .padding(.top, UIScreen.main.bounds.height / 6)
                            .font(.system(size: UIScreen.main.bounds.height / 55.6, weight: .thin))
                    } else {
                        Text("Выбранные темы".uppercased())
                            .padding(.top, UIScreen.main.bounds.height / 35)
                            .padding(.bottom, -UIScreen.main.bounds.height / 75)
                            .font(.system(size: UIScreen.main.bounds.height / 55.6, weight: .medium))
                        VStack {
                            List {
                                ForEach(viewModel.choicedTopics) { model in
                                    ChoicedTopicView(viewModel: ChoicedTopicViewModel(model: model))
                                        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                                        .listRowSeparator(.hidden)
                                }
                                .onDelete { value in
                                    viewModel.removeTopicFromTheSelected(offsets: value)
                                }
                            }
                            .listStyle(PlainListStyle())
                            .onAppear {
                                UITableView.appearance().isScrollEnabled = false
                            }
                        }
                        .frame(height: UIScreen.main.bounds.height / 10 * CGFloat(viewModel.choicedTopics.count))
                        .cornerRadius(25)
                        .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 4)
                        .padding()
                        
                        Button {
                            showConstructor.toggle()
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                practiceShow.toggle()
                            }
                        } label: {
                            Text("Начать")
                                .font(.system(size: UIScreen.main.bounds.width / 26.5, weight: .bold))
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(ButtonState.active.getColor())
                                .cornerRadius(UIScreen.main.bounds.width / 25)
                                .shadow(color: ButtonState.active.getColor().opacity(0.5), radius: 8, x: 0, y: 4)
                                .foregroundColor(.white)
                                .padding(.horizontal, 100)
                        }
                    }
                }
                .padding(.top, UIScreen.main.bounds.height / 2.3)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .animation(.spring(), value: viewModel.serverState)
        }
    }
}

struct CustomPracticeSheet_Previews: PreviewProvider {
    static var previews: some View {
        CustomPracticeSheetView(showConstructor: .constant(true), practiceShow: .constant(true))
    }
}

struct CustomPracticeSheetBackground: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height / 2.6
        path.move(to: CGPoint(x: 0, y: 0.80972*height))
        path.addLine(to: CGPoint(x: 0, y: 0.90839*height))
        path.addCurve(to: CGPoint(x: 0.144*width, y: 0.86528*height), control1: CGPoint(x: 0.04763*width, y: 0.88151*height), control2: CGPoint(x: 0.09985*width, y: 0.86144*height))
        path.addCurve(to: CGPoint(x: 0.57067*width, y: 0.99444*height), control1: CGPoint(x: 0.256*width, y: 0.875*height), control2: CGPoint(x: 0.52*width, y: 0.99444*height))
        path.addCurve(to: CGPoint(x: width, y: 0.95029*height), control1: CGPoint(x: 0.61207*width, y: 0.99444*height), control2: CGPoint(x: 0.84761*width, y: 1.01485*height))
        path.addCurve(to: CGPoint(x: 1.004*width, y: 0.87639*height), control1: CGPoint(x: 1.01067*width, y: 0.94577*height), control2: CGPoint(x: 1.004*width, y: 0.87639*height))
        path.addLine(to: CGPoint(x: width, y: -1.49306*height))
        path.addLine(to: CGPoint(x: 0, y: -1.49306*height))
        path.addLine(to: CGPoint(x: 0, y: 0.80972*height))
        path.closeSubpath()
        return path
    }
}
