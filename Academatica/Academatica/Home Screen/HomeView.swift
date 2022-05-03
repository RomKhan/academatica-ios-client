//
//  HomeView.swift
//  SmartMath
//
//  Created by Roman on 04.01.2022.
//

import SwiftUI
import Combine

enum practiceType {
    case completedPractive
    case recomendedPractice
}

struct HomeView: View {
    @StateObject var viewModel = HomeViewModel()
    @State private var heightOfset: CGFloat = 0
    @State var selectedDetentIdentifier: UISheetPresentationController.Detent.Identifier? = .medium
    @State var state: Bool = false
    @State var practiceType: PracticeType = .completedLessons
    @State private var showConstructor = false
    @Binding var showClass: Bool
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
            Image(uiImage: UIImage(named: "HomeBackground")!)
                .resizable()
                .scaledToFit()
                .offset(y: -heightOfset)
            TrackableScrollView(showIndicators: false, contentOffset: $heightOfset) {
                HStack(alignment: .top) {
                    BuoysLeftCounter()
                        .padding(.top, 3)
                    Spacer()
                    VStack() {
                        Button {
                            selected = .profile
                        } label: {
                            AsyncImage(
                                url: UserService.shared.userModel?.profilePicUrl,
                                transaction: Transaction(animation: .spring()))
                            { phase in
                                switch phase {
                                case .empty:
                                    Rectangle().fill(.white)
                                        .blendMode(.overlay)
                                case .success(let image):
                                    image
                                        .resizable()
                                        .scaledToFill()
                                        .transition(.scale(scale: 0.1, anchor: .center))
                                case .failure:
                                    Image(systemName: "wifi.slash")
                                @unknown default:
                                    EmptyView()
                                }
                            }
                            .frame(width: 45, height: 45)
                            .cornerRadius(15)
                        }
                        .padding(5)
                        .background(.ultraThinMaterial)
                        .cornerRadius(17)
                        .shadow(radius: 10, y: 4)
                    }
                }.padding(.horizontal, 21).padding(.top, 5)
                ZStack {
                    if (viewModel.userState?.daysStreak == nil) {
                        RoundedRectangle(cornerRadius: 10).fill(.white)
                            .blendMode(.overlay)
                            .frame(width: UIScreen.main.bounds.size.width / 2.5, height: 15)
                    } else {
                        Text("\(viewModel.userState!.daysStreak) дней учебы подряд")
                            .font(.system(size: 13))
                        
                    }
                }
                .frame(height: 15)
                .padding(.top, 75)
                .padding(.horizontal, 20).textCase(.uppercase).foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
                .animation(.easeOut, value: viewModel.userState?.daysStreak)
                .transition(.opacity)
                
                ZStack {
                    if (viewModel.userModel?.firstName == nil) {
                        RoundedRectangle(cornerRadius: 10).fill(.white)
                            .blendMode(.overlay)
                            .frame(width: UIScreen.main.bounds.size.width / 2, height: 40)
                    } else {
                        Text("Привет, \(viewModel.userModel!.firstName)!")
                            .font(.system(size: 30).bold())
                            .foregroundColor(.white)
                        
                    }
                }
                .frame(height: 40)
                .padding(.horizontal, 20)
                .frame(maxWidth: .infinity, alignment: .leading)
                .animation(.easeOut, value: viewModel.userModel?.firstName)
                .transition(.opacity)
                
                Text("Предстоящие занятия")
                    .bold()
                    .padding(.top, UIScreen.main.bounds.size.height / 25)
                    .padding(.horizontal, 20)
                    .font(.system(size: 13))
                    .textCase(.uppercase).foregroundColor(.white)
                if (viewModel.cardStackStateIsLoaded && CourseService.shared.upcomingClasses.isEmpty) {
                    HStack(spacing: 20) {
                        Image("sad-face-in-rounded-square")
                            .resizable()
                            .scaledToFit()
                            .padding(.vertical, UIScreen.main.bounds.height / 20)
                            .padding(.leading, UIScreen.main.bounds.height / 20)
                            .blendMode(.overlay)
                        Text("Больше нет доступных уроков 🤷")
                            .font(.system(size: UIScreen.main.bounds.height / 60))
                            .multilineTextAlignment(.center)
                            .blendMode(.overlay)
                            .padding(.trailing, UIScreen.main.bounds.height / 20)
                    }
                    .transition(AnyTransition.opacity.animation(.easeIn(duration: 0.3)))
                    .background(
                        LinearGradient(
                            gradient: ColorService.gradients[3],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing)
                            .opacity(0.4)
                    )
                    .background(.ultraThinMaterial)
                    .cornerRadius(UIScreen.main.bounds.height / 30)
                    .padding(.horizontal, 20)
                    .frame(maxWidth: .infinity)
                    .frame(height: 180)
                    .shadow(color: .black.opacity(0.3), radius: 20, x: 0, y: 0)
                    .padding(.bottom, -20)
                    .offset(y: 10)
                } else {
                    HomeCardStackView(showClass: $showClass).padding(.horizontal, 20).frame(maxWidth: .infinity).frame(height: 160)
                        .transition(AnyTransition.opacity.animation(.easeInOut(duration: 0.3)))
                }
                Text("Практика")
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
                                practiceType = .completedLessons
                            case 1:
                                practiceType = .recomended
                            default:
                                practiceType = .custom
                            }
                            if viewModel.completedTopicsCount != 0 && (practiceType != .recomended || viewModel.recommendedTopicId != nil) {
                                withAnimation {
                                    state.toggle()
                                }
                            }
                        } label: {
                            PracticeCardView(viewModel: viewModel.practiseCardsViewModels[index], unlocked: $viewModel.practicesUnlocked)
                                .padding(.horizontal, 20)
                        }
                    }
                }.frame(maxWidth: .infinity, alignment: .top)
                Text("").frame(height: 95)
            }.gesture(DragGesture(minimumDistance: 30, coordinateSpace: .local))
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
            
            if practiceType == .recomended {
                NavigationLink(isActive: $viewModel.practiceShow) {
                    PracticeLoadView(viewModel: PracticeLoadViewModel(mode: practiceType, topicId: viewModel.recommendedTopicId), showPractice: .constant(true))
                        .navigationBarHidden(true)
                } label: {
                    EmptyView()
                }
            } else if practiceType == .completedLessons || practiceType == .custom {
                NavigationLink(isActive: $viewModel.practiceShow) {
                    PracticeLoadView(viewModel: PracticeLoadViewModel(mode: practiceType, topicId: nil), showPractice: .constant(true))
                        .navigationBarHidden(true)
                        .overlay(Color.black.opacity(viewModel.completedTopicsCount != 0 ? 0 : 0.5))
                        .overlay(
                            Image("locked")
                                .resizable()
                                .frame(width: 64, height: 64, alignment: .center)
                                .opacity(viewModel.completedTopicsCount != 0 ? 0 : 1)
                        )
                } label: {
                    EmptyView()
                }
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
        .navigationBarHidden(true)
        .detentSheet(isPresented: $state, preferredCornerRadius: 40, detents: practiceType == .custom ? [.medium(), .large()] : [.medium()], allowsDismissalGesture: true) {
            HalfPracticeSheet(viewModel: HalfPracticeSheetModel(), practiceShow: $viewModel.practiceShow, sheetMode: $state, mode: $practiceType, showConstructor: $showConstructor)
        }
        .sheet(isPresented: $showConstructor) {
            CustomPracticeSheetView(showConstructor: $showConstructor, practiceShow: $viewModel.practiceShow)
        }
        .ignoresSafeArea()
        .onAppear {
            viewModel.updateData()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HomeView(showClass: .constant(false), selected: .constant(.home))
        }
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
