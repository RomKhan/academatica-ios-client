//
//  LessonsView.swift
//  SmartMath
//
//  Created by Roman on 04.01.2022.
//

import SwiftUI

struct TierView: View {
    @StateObject var viewModel: TierViewModel
    @State var heightOffset: CGFloat = 0
    @State var isAlgebra: Int = 0
    @State var topicsOfset: CGFloat = 0
    @Binding var show: Bool
    var namespace: Namespace.ID
    var body: some View {
        GeometryReader { reader in
            ZStack(alignment: .top) {
                LessonsAngleBackground()
                    .offset(y: -heightOffset)
                    .fill(LinearGradient(
                        gradient: Gradient(
                            stops: [
                                .init(color: Color(#colorLiteral(red: 1, green: 0.01462487131, blue: 0.45694381, alpha: 1)), location: 0),
                                .init(color: Color(#colorLiteral(red: 0.9612058997, green: 0.6234115958, blue: 0, alpha: 1)), location: 0.5)]),
                        startPoint: .topTrailing,
                        endPoint: .bottomLeading)).ignoresSafeArea()
                
                HStack {
                    if isAlgebra == 0 {
                        Text("Algebra Topics")
                            .textCase(.uppercase)
                            .font(.system(size: 13).bold())
                            .transition(AnyTransition.opacity.animation(.easeInOut(duration: 0.3)))
                    }
                    else {
                        Text("Geometry Topics")
                            .textCase(.uppercase)
                            .font(.system(size: 13).bold())
                            .transition(AnyTransition.opacity.animation(.easeInOut(duration: 0.3)))
                    }
                    Spacer()
                    Circle().fill(isAlgebra == 0 ? Color(uiColor: UIColor.systemGray) :
                                  Color(uiColor: UIColor.systemGray4))
                        .frame(width: 7, height: 7)
                        .animation(.spring(), value: isAlgebra)
                    Circle().fill(isAlgebra != 0 ? Color(uiColor: UIColor.systemGray) :
                                  Color(uiColor: UIColor.systemGray4))
                        .frame(width: 7, height: 7)
                        .animation(.spring(), value: isAlgebra)
                }
                .padding(.vertical, 10)
                .padding(.horizontal, 20)
                .background(Color.white)
                .padding(.top, 90 + reader.size.height / 3.8)
                .offset(y: heightOffset < 80 + reader.size.height / 3.8 ? -heightOffset : -(90 + reader.size.height / 3.8))
                .zIndex(2)
                .shadow(color: .white, radius: 20, x: 0, y: -20)
                TrackableScrollView(showIndicators: false, contentOffset: $heightOffset) {
                    ScrollViewReader { value in
                        HStack {
                            Text("Уровни")
                                .font(.system(size: 30, weight: .heavy))
                                .foregroundColor(.white)
                            Spacer()
                            BuoysLeftCounter()
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 12)
                        .padding(.bottom, 6)
                        TabView {
                            ForEach(viewModel.TierCardModels) { tierCardModel in
                                TierCardView(viewModel: TierCardViewModel(model: tierCardModel))
                                    .padding(.horizontal, 20)
                            }
                        }
                        .tabViewStyle(.page(indexDisplayMode: .never))
                        .frame(height: reader.size.height / 3.45)
                        TabView(selection: $isAlgebra) {
                            GeometryReader { readerInside in
                                VStack(spacing: 20) {
                                    ForEach(viewModel.TopicModels) { topicModel in
                                        if (topicModel.isAlgebraTopics) {
                                            TopicCardView(viewModel: TopicCardViewModel(topicModel: topicModel),
                                                          show: $show,
                                                          namespace: namespace)
                                                .frame(height: reader.size.height / 3.2)
                                                .padding(.horizontal, 20)
                                        }
                                    }
                                }
                                .offset(y: (isAlgebra != 0) && heightOffset > 90 + reader.size.height / 3.8 ? heightOffset - (90 + reader.size.height / 3.8) : 0)
                                .animation(isAlgebra == 1 ? .spring() : .none, value: isAlgebra)
                            }
                            .tag(0)
                            GeometryReader { readerInside in
                                VStack(spacing: 20) {
                                    ForEach(viewModel.TopicModels) { topicModel in
                                        if (!topicModel.isAlgebraTopics) {
                                            TopicCardView(viewModel: TopicCardViewModel(topicModel: topicModel),
                                                          show: $show,
                                                          namespace: namespace
                                            )
                                                .frame(height: reader.size.height / 3.2)
                                                .padding(.horizontal, 20)
                                        }
                                    }
                                    
                                }
                                .offset(y: (isAlgebra == 0) && heightOffset > 90 + reader.size.height / 3.8 ? heightOffset - (90 + reader.size.height / 3.8) : 0)
                                .animation(isAlgebra == 0 ? .spring() : .none, value: isAlgebra)
                            }
                            .tag(1)
                        }
                        .tabViewStyle(.page(indexDisplayMode: .never))
                        .padding(.top, 50)
                        .onChange(of: isAlgebra) { _ in
                            if (heightOffset >= 90 + reader.size.height / 3.8 ) {
                                value.scrollTo(0, anchor: .top)
                            }
                        }
                        .frame(height: 90 + max(reader.size.height - 90, CGFloat(isAlgebra == 0 ? viewModel.countOfAlgebraTopics : viewModel.countOfGeometryTopics) * (reader.size.height / 3.2 + 20) + 50), alignment: .top)
                        .id(0)
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        }
    }
}

struct LessonsView_Previews: PreviewProvider {
    @Namespace static var namespace
    static var previews: some View {
        TierView(viewModel: TierViewModel(), show: .constant(false), namespace: namespace)
            .previewInterfaceOrientation(.portrait)
    }
}

struct LessonsAngleBackground: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height / 2.7
        path.move(to: CGPoint(x: -0.00267*width, y: 0.66452*height))
        path.addCurve(to: CGPoint(x: 0.06533*width, y: 0.80323*height), control1: CGPoint(x: -0.00267*width, y: 0.66452*height), control2: CGPoint(x: -0.00267*width, y: 0.75753*height))
        path.addCurve(to: CGPoint(x: 0.87867*width, y: 0.99677*height), control1: CGPoint(x: 0.13333*width, y: 0.84893*height), control2: CGPoint(x: 0.664*width, y: 0.95484*height))
        path.addCurve(to: CGPoint(x: 1.00267*width, y: 0.90484*height), control1: CGPoint(x: 0.98186*width, y: 1.01694*height), control2: CGPoint(x: 1.00267*width, y: 0.90484*height))
        path.addCurve(to: CGPoint(x: width, y: 0.83065*height), control1: CGPoint(x: 1.00267*width, y: 0.90484*height), control2: CGPoint(x: width, y: 0.87258*height))
        path.addLine(to: CGPoint(x: width, y: -1.79677*height))
        path.addLine(to: CGPoint(x: 0, y: -1.79677*height))
        path.addLine(to: CGPoint(x: 0, y: 0.60323*height))
        path.addLine(to: CGPoint(x: -0.00267*width, y: 0.66452*height))
        path.closeSubpath()
        return path
    }
}
