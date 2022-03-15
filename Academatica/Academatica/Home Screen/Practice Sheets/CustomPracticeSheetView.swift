//
//  PracticeSheet.swift
//  SmartMath
//
//  Created by Roman on 18.02.2022.
//

import SwiftUI

struct CustomPracticeSheetView: View {
    @StateObject var viewModel = CustomPracticeSheetViewModel()
    @State var selectedTier: Int = 5
    @Binding var showConstructor: Bool
    @Binding var practiceShow: Bool
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            ZStack(alignment: .top) {
                CustomPracticeSheetBackground()
                    .fill(
                        LinearGradient(
                            colors: [.cyan, .pink],
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
                            // !!!!
                            practiceShow.toggle()
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
                        .padding(.vertical, UIScreen.main.bounds.height / 30)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                        ForEach((5...11), id: \.self) { index in
                            Text("Уровень \(index)")
                                .onTapGesture {
                                    withAnimation {
                                        selectedTier = index
                                    }
                                }
                                .padding(.horizontal, 20)
                                .padding(.vertical, 7)
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(.white, lineWidth: 2)
                                        .background(.ultraThinMaterial)
                                        .opacity(selectedTier == index ? 1 : 0)
                                        .cornerRadius(10)
                                        .shadow(color: .white.opacity(0.2), radius: 10, x: 0, y: 0)
                                )
                        }
                        .animation(.spring(), value: selectedTier)
                        .foregroundColor(.white)
                        }
                        .padding(.horizontal, 20)
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
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
        let height = rect.size.height / 3
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
