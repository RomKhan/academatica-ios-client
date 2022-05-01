//
//  TopicView.swift
//  SmartMath
//
//  Created by Roman on 11.01.2022.
//

import SwiftUI

struct TopicView: View {
    @StateObject var viewModel: TopicViewModel = TopicViewModel()
    @Binding var show: Bool
    @State private var heightOfset: CGFloat = 0
    @State private var startPractice = false
    @State private var showSheet = false
    @State private var showPractice = false
    var namespace: Namespace.ID
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Group {
                LinearGradient(
                    gradient: Gradient(
                        stops: [
                            .init(color: viewModel.colors[1], location: 0.4),
                            .init(color: viewModel.colors[2], location: 1)]),
                    startPoint: .topTrailing,
                    endPoint: .bottomLeading)
                    .offset(y: -UIScreen.main.bounds.height / 2)
                    .overlay(
                        AsyncImage(
                            url: viewModel.topicModel.imageUrl,
                            transaction: Transaction(animation: .spring()))
                        { phase in
                            switch phase {
                            case .success(let image):
                                Rectangle()
                                    .fill(.clear)
                                    .scaledToFill()
                                    .background(
                                        image
                                            .resizable()
                                            .scaledToFill()
                                    )
                            case .failure:
                                Rectangle()
                                    .fill(.black.opacity(0.5))
                                    .scaledToFill()
                                    .background(
                                        Image(systemName: "wifi.slash")
                                            .resizable()
                                            .scaledToFill()
                                            .padding(25)
                                            .foregroundColor(.white)
                                    )
                            case .empty:
                                EmptyView()
                            @unknown default:
                                EmptyView()
                            }
                        }
                            .blendMode(.overlay)
                            .offset(y: -UIScreen.main.bounds.height / 4.5)
                            .frame(maxHeight: UIScreen.main.bounds.height / 1.8)
                    )
                TopViewBackgroundBack()
                    .fill(viewModel.colors[0])
                    .offset(y: UIScreen.main.bounds.height * 0.43)
                TopViewBackgroundFront()
                    .fill(.white)
                    .offset(y: UIScreen.main.bounds.height * 0.43)
            }
            .animation(.easeOut, value: heightOfset)
            .offset(y: -heightOfset)
            .ignoresSafeArea()
            
            TrackableScrollView(showIndicators: false, contentOffset: $heightOfset) {
                HStack {
                    BuoysLeftCounter()
                    Spacer()
                    Button {
                        withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                            show.toggle()
                        }
                    } label: {
                        Image(systemName: "xmark")
                            .font(Font.system(size: 15, weight: .bold))
                            .frame(width: 30, height: 30)
                            .foregroundColor(.white)
                            .padding(2)
                            .background(.ultraThinMaterial)
                            .cornerRadius(100)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 20)
                FullTopicCardView(viewModel: viewModel, namespace: namespace)
                    .padding(.horizontal, 20)
                    .padding(.top, UIScreen.main.bounds.height / 4.9 - CGFloat(viewModel.topicModel.description.count) / 5)
                
                VStack(spacing: 0) {
                    ForEach(viewModel.classes) { classModel in
                        Button {
                            if classModel.isUnlocked {
                                CourseService.shared.currentClass = classModel
                                showSheet.toggle()
                            }
                        } label: {
                            VStack(spacing: 3) {
                                HStack {
                                    ZStack {
                                        LinearGradient(
                                            gradient: Gradient(
                                                stops: [
                                                    .init(color: ClassesColors(rawValue: classModel.isComplete ? 0 : classModel.isUnlocked ? 1 : 2)!.getSecondColor(), location: 0),
                                                    .init(color: ClassesColors(rawValue: classModel.isComplete ? 0 : classModel.isUnlocked ? 1 : 2)!.getFirstColor(), location: 0.8)]),
                                            startPoint: .topTrailing,
                                            endPoint: .bottomLeading)
                                            .mask {
                                                Circle()
                                                    .frame(width: 55)
                                            }
                                        Rectangle()
                                            .fill(.white)
                                            .mask {
                                                if classModel.isComplete {
                                                    Image("checked")
                                                        .resizable()
                                                        .scaledToFit()
                                                        .frame(width: 25, height: 25)
                                                } else if classModel.isUnlocked {
                                                    Image("clock")
                                                        .resizable()
                                                        .scaledToFit()
                                                        .frame(width: 25, height: 25)
                                                } else {
                                                    Image("locked")
                                                        .resizable()
                                                        .scaledToFit()
                                                        .frame(width: 25, height: 25)
                                                }
                                            }
                                    }
                                    .frame(width: 80)
                                    VStack(alignment: .leading, spacing: 5) {
                                        Spacer()
                                        if classModel.isComplete {
                                            Text("Завершён")
                                                .textCase(.uppercase)
                                                .font(.system(size: UIScreen.main.bounds.height / 67))
                                        } else if classModel.isUnlocked {
                                            Text("Разблокирован")
                                                .textCase(.uppercase)
                                                .font(.system(size: UIScreen.main.bounds.height / 67))
                                        } else {
                                            Text("Заблокирован")
                                                .textCase(.uppercase)
                                                .font(.system(size: UIScreen.main.bounds.height / 67))
                                        }
                                        Text(classModel.name)
                                            .font(.system(size: UIScreen.main.bounds.height / 50, weight: .heavy))
                                            .lineLimit(1)
                                        Text(classModel.description)
                                            .font(.system(size: UIScreen.main.bounds.height / 67))
                                            .lineLimit(1)
                                        Spacer()
                                    }
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                }
                                .frame(height: UIScreen.main.bounds.height / 10.5)
                                .padding(.horizontal, 10)
                                .padding(.top, 7)
                                Text("")
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 1)
                                    .background(Color(uiColor: UIColor(red: 89 / 255.0, green: 89 / 255.0, blue: 89 / 255.0, alpha: 1)))
                            }
                            .padding(.bottom, -1)
                        }
                        .foregroundColor(.black)
                    }
                }
                .frame(maxWidth: .infinity)
                .background(.white)
                .cornerRadius(UIScreen.main.bounds.height / 25)
                .padding(.horizontal, 20)
                .shadow(color: .black.opacity(0.25), radius: 25, x: 0, y: 0)
                .padding(.top, 30)
                Text("")
                    .frame(height: 30)
            }
            LessonView(viewModel: LessonViewModel(
                lesson: viewModel.selectedClass,
                        topicName: viewModel.topicModel.name),
                    showSheet: $showSheet)
                .offset(y: showSheet ? 0 : UIScreen.main.bounds.height * 1.5)
                .animation(.spring(), value: showSheet)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment:  .bottom)
        .matchedGeometryEffect(id: viewModel.topicModel.id, in: namespace)
        .onAppear() {
            if let currentTopic = CourseService.shared.currentTopic {
                viewModel.topicModel = currentTopic
                viewModel.loadClasses()
            }
        }
    }
}

struct TopicView_Previews: PreviewProvider {
    @Namespace static var namespace
    static var previews: some View {
        NavigationView {
        TopicView(viewModel: TopicViewModel(),
                  show: .constant(true),
                  namespace: namespace)
                .navigationBarHidden(true)
        }
    }
}

struct TopViewBackgroundBack: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height * 0.59
        path.move(to: CGPoint(x: width, y: 0.09935*height))
        path.addLine(to: CGPoint(x: width, y: 0.02232*height))
        path.addCurve(to: CGPoint(x: 0.896*width, y: 0.01188*height), control1: CGPoint(x: 0.96979*width, y: 0.01605*height), control2: CGPoint(x: 0.93506*width, y: 0.01188*height))
        path.addCurve(to: CGPoint(x: 0.384*width, y: 0.09935*height), control1: CGPoint(x: 0.73948*width, y: 0.01188*height), control2: CGPoint(x: 0.42667*width, y: 0.09935*height))
        path.addCurve(to: CGPoint(x: 0, y: 0.00077*height), control1: CGPoint(x: 0.35027*width, y: 0.09935*height), control2: CGPoint(x: 0.11073*width, y: 0.04266*height))
        path.addLine(to: CGPoint(x: 0, y: 0.06911*height))
        path.addLine(to: CGPoint(x: 0, y: height))
        path.addLine(to: CGPoint(x: 1.00133*width, y: height))
        path.addLine(to: CGPoint(x: 1.00133*width, y: 0.88553*height))
        path.addLine(to: CGPoint(x: width, y: 0.09935*height))
        path.closeSubpath()
        return path
    }
}

struct TopViewBackgroundFront: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height * 0.56
        path.move(to: CGPoint(x: 0, y: 0.08932*height))
        path.addLine(to: CGPoint(x: 0, y: 0.05132*height))
        path.addCurve(to: CGPoint(x: 0.31067*width, y: 0.00218*height), control1: CGPoint(x: 0.06649*width, y: 0.03017*height), control2: CGPoint(x: 0.15187*width, y: 0.00031*height))
        path.addCurve(to: CGPoint(x: 0.93733*width, y: 0.0817*height), control1: CGPoint(x: 0.496*width, y: 0.00436*height), control2: CGPoint(x: 0.74933*width, y: 0.11656*height))
        path.addCurve(to: CGPoint(x: width, y: 0.07026*height), control1: CGPoint(x: 0.96078*width, y: 0.07735*height), control2: CGPoint(x: 0.98147*width, y: 0.0736*height))
        path.addLine(to: CGPoint(x: width, y: 0.27342*height))
        path.addLine(to: CGPoint(x: width, y: 1.59913*height))
        path.addLine(to: CGPoint(x: 0, y: 1.59913*height))
        path.addLine(to: CGPoint(x: 0, y: 0.13508*height))
        path.addLine(to: CGPoint(x: 0, y: 0.08932*height))
        path.closeSubpath()
        return path
    }
}
