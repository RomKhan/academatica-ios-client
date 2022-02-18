//
//  HomeView.swift
//  SmartMath
//
//  Created by Roman on 04.01.2022.
//

import SwiftUI
import Combine
import ResizableSheet

enum practiceType {
    case completedPractive
    case recomendedPractice
    case customPractice
}

struct HomeView: View {
    @ObservedObject var viewModel = HomeViewModel()
    @State private var heightOfset: CGFloat = 0
    //    @State var state: ResizableSheetState = .hidden
    @State var selectedDetentIdentifier: UISheetPresentationController.Detent.Identifier? = .medium
    @State var state: Bool = false
    @State var practiceType: PracticeSheetState = .byCompletedLessons
    @State private var showConstructor = false
    @Binding var selected: ScreenType
    var body: some View {
        ZStack(alignment: .top) {
            AngleBackground()
                .offset(y: -heightOfset)
                .fill(LinearGradient(
                    gradient: Gradient(
                        stops: [
                            .init(color: Color(#colorLiteral(red: 0.0097277686, green: 0.9990763068, blue: 0.8794588447, alpha: 1)), location: 0),
                            .init(color: Color(#colorLiteral(red: 0.8598107696, green: 0, blue: 0.999384582, alpha: 1)), location: 0.6)]),
                    startPoint: .topTrailing,
                    endPoint: .bottomLeading)).ignoresSafeArea()
            
            TrackableScrollView(showIndicators: false, contentOffset: $heightOfset) {
                HStack(alignment: .top) {
                    BuoysLeftCounter()
                        .padding(.top, 3)
                    Spacer()
                    VStack() {
                        Button {
                            selected = .profile
                        } label: {
                            Image(uiImage: viewModel.userImage).resizable().scaledToFill().frame(width: 45, height: 45).cornerRadius(15)
                        }
                        .padding(5)
                        .background(.ultraThinMaterial)
                        .cornerRadius(17)
                        .shadow(radius: 10, y: 4)
                    }
                }.padding(.horizontal, 21).padding(.top, 5)
                Text("2 days streack")
                    .padding(.top, 75)
                    .font(.system(size: 13))
                    .padding(.horizontal, 20).textCase(.uppercase).foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text("Hello, Jason!")
                    .padding(.horizontal, 20)
                    .font(.system(size: 30).bold())
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text("ucomming lessons")
                    .bold()
                    .padding(.top, 1)
                    .padding(.horizontal, 20)
                    .font(.system(size: 13))
                    .textCase(.uppercase).foregroundColor(.white)
                CardStackVIew().padding(.horizontal, 20).frame(maxWidth: .infinity).frame(height: 160)
                Text("practice")
                    .textCase(.uppercase)
                    .padding(.top, 50)
                    .font(.system(size: 15).bold())
                    .padding(.horizontal, 20)
                    .textCase(.uppercase)
                    .frame(maxWidth: .infinity, alignment: .leading).zIndex(1)
                VStack(spacing: 16) {
                    ForEach(0...2, id: \.self) {index in
                        Button {
                            switch index {
                            case 0:
                                practiceType = .byCompletedLessons
                            case 1:
                                practiceType = .byRecomend
                            default:
                                practiceType = .custom
                            }
                            withAnimation {
                                state.toggle()
                            }
                            
                            //                            if index < 2 {
                            //                                state = .medium
                            //                            }
                            //                            else {
                            //                                state = .large
                            //                            }
                        } label: {
                            PracticeCardView(viewModel: viewModel.practiseCardsViewModels[index])
                                .padding(.horizontal, 20)
                        }
                    }
                }.frame(maxWidth: .infinity, alignment: .top)
                Text("").frame(height: 95)
            }
            if (state) {
                Rectangle()
                    .fill(.black.opacity(0.3))
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation {
                            state.toggle()
                        }
                    }
                
            }
        }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
        
        //            .resizableSheet($state) { builder in
        //                        builder.content { context in
        //                            HalfPracticeSheet(viewModel: HalfPracticeSheetModel(), sheetMode: $state, mode: practiceType)
        //                        }
        //                    }
            .navigationBarHidden(true)
            .detentSheet(isPresented: $state, preferredCornerRadius: 40, detents: practiceType == .custom ? [.medium(), .large()] : [.medium()], allowsDismissalGesture: true) {
//                if (practiceType == .custom) {
//                    CustomPracticeSheet()
//                }
//                else {
                HalfPracticeSheet(viewModel: HalfPracticeSheetModel(), sheetMode: $state, mode: $practiceType, showConstructor: $showConstructor)
//                }
            }
            .sheet(isPresented: $showConstructor) {
                CustomPracticeSheetView(showConstructor: $showConstructor)
            }
            .ignoresSafeArea()
        //            .sheet(isPresented: $state)
        //            {
        //                                            HalfPracticeSheet(viewModel: HalfPracticeSheetModel(), sheetMode: $state, mode: practiceType)
        //            }
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HomeView(selected: .constant(.home))
        }
    }
}

class HomeViewModel: ObservableObject {
    let userDataService = UserDataService()
    let practiseCardsViewModels = [
        PracticeCardViewModel(model: PracticeCardModel(title: "Completed Topics", countOfTasks: 10, imageName: "tick-inside-circle"),
                              colors: [
                                Color(uiColor: UIColor(
                                    red: 239 / 255.0,
                                    green: 147 / 255.0,
                                    blue: 126 / 255.0,
                                    alpha: 1)),
                                Color(uiColor: UIColor(
                                    red: 170 / 255.0,
                                    green: 30 / 255.0,
                                    blue: 245 / 255.0,
                                    alpha: 1)),
                                Color(uiColor: UIColor(
                                    red: 206 / 255.0,
                                    green: 92 / 255.0,
                                    blue: 182 / 255.0,
                                    alpha: 1))
                              ]),
        PracticeCardViewModel(model: PracticeCardModel(title: "Recomended Topics", countOfTasks: 10, imageName: "star"),
                              colors: [
                                Color(uiColor: UIColor(
                                    red: 126 / 255.0,
                                    green: 192 / 255.0,
                                    blue: 239 / 255.0,
                                    alpha: 1)),
                                Color(uiColor: UIColor(
                                    red: 30 / 255.0,
                                    green: 77 / 255.0,
                                    blue: 245 / 255.0,
                                    alpha: 1)),
                                Color(uiColor: UIColor(
                                    red: 92 / 255.0,
                                    green: 144 / 255.0,
                                    blue: 206 / 255.0,
                                    alpha: 1))
                              ]),
        PracticeCardViewModel(model: PracticeCardModel(title: "Custom Practice", countOfTasks: 10, imageName: "support"),
                              colors: [
                                Color(uiColor: UIColor(
                                    red: 236 / 255.0,
                                    green: 140 / 255.0,
                                    blue: 140 / 255.0,
                                    alpha: 1)),
                                Color(uiColor: UIColor(
                                    red: 249 / 255.0,
                                    green: 58 / 255.0,
                                    blue: 58 / 255.0,
                                    alpha: 1)),
                                Color(uiColor: UIColor(
                                    red: 245 / 255.0,
                                    green: 133 / 255.0,
                                    blue: 155 / 255.0,
                                    alpha: 1))
                              ])
    ]
    @Published var userImage: UIImage = #imageLiteral(resourceName: "young-girls")
    @Published var buoysLeftCount: Int = 5
    
    func fetchUserData() {
        
    }
}

struct AngleBackground: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height / 2
        path.move(to: CGPoint(x: -0.00267*width, y: 0.73804*height))
        path.addCurve(to: CGPoint(x: 0.06533*width, y: 0.84635*height), control1: CGPoint(x: -0.00267*width, y: 0.73804*height), control2: CGPoint(x: -0.00267*width, y: 0.81066*height))
        path.addCurve(to: CGPoint(x: 0.87867*width, y: 0.99748*height), control1: CGPoint(x: 0.13333*width, y: 0.88203*height), control2: CGPoint(x: 0.664*width, y: 0.96474*height))
        path.addCurve(to: CGPoint(x: 1.00267*width, y: 0.92569*height), control1: CGPoint(x: 0.98186*width, y: 1.01322*height), control2: CGPoint(x: 1.00267*width, y: 0.92569*height))
        path.addCurve(to: CGPoint(x: width, y: 0.90554*height), control1: CGPoint(x: 1.00267*width, y: 0.92569*height), control2: CGPoint(x: width, y: 0.91436*height))
        path.addCurve(to: CGPoint(x: width, y: -0.84005*height), control1: CGPoint(x: width, y: 0.81864*height), control2: CGPoint(x: width, y: -0.84005*height))
        path.addLine(to: CGPoint(x: -0.00267*width, y: -0.84005*height))
        path.addLine(to: CGPoint(x: 0, y: 0.71411*height))
        path.addLine(to: CGPoint(x: -0.00267*width, y: 0.73804*height))
        path.closeSubpath()
        return path
    }
}
