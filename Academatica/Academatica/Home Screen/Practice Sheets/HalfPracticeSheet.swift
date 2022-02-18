//
//  HalfPracticeSheet.swift
//  SmartMath
//
//  Created by Roman on 18.02.2022.
//

import SwiftUI
import ResizableSheet

struct HalfPracticeSheet: View {
    @StateObject var viewModel: HalfPracticeSheetModel
//    @Binding var sheetMode: ResizableSheetState
    @Binding var sheetMode: Bool
    @Binding var mode: PracticeSheetState
    @Binding var showConstructor: Bool
    var body: some View {
        ZStack {
            Image(uiImage: UIImage(named: "PracticeByCompletedTopicsBackground")!)
                .resizable()
                .scaledToFill()
                .opacity(1)
                .blendMode(.softLight)
                .padding(-UIScreen.main.bounds.height / 5)
                .offset(y: -UIScreen.main.bounds.height / 15)
        VStack(alignment: .leading, spacing: 5) {
//            HStack(alignment: .top) {
                    Text("10 заданий".uppercased())
                        .font(.system(size: UIScreen.main.bounds.height / 45))
                    Text("\(mode.getTitle())")
                        .font(.system(size: UIScreen.main.bounds.height / 30, weight: .heavy))
//                Spacer()
//                Group {
//                Text("+3")
//                    .font(.system(size: UIScreen.main.bounds.height / 35))
//                Circle()
//                    .strokeBorder(.white, lineWidth: 10)
//                    .frame(width: 32, height: 32)
//                }
//                .padding(.top, UIScreen.main.bounds.height / 110)
//            }
            Spacer()
            Text(mode.getDescription())
                .opacity(0.8)
                .font(.system(size: UIScreen.main.bounds.height / 55))
            Button {
//                sheetMode = .hidden
                withAnimation {
                    sheetMode.toggle()
                }
                if (mode == .custom) {
                    showConstructor.toggle()
                }
            } label: {
                Text("Начать")
                    .font(.system(size: UIScreen.main.bounds.height / 53, weight: .bold))
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(viewModel.colors[0])
                    .cornerRadius(UIScreen.main.bounds.height / 50)
                    .shadow(color: viewModel.colors[1].opacity(0.5), radius: 8, x: 0, y: 4)
            }
            .padding(.horizontal, UIScreen.main.bounds.height / 30)
            .padding(UIScreen.main.bounds.height / 60)
            
        }
        .padding(UIScreen.main.bounds.height / 40)
        .padding(.top, 10)
        .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: .infinity, alignment: .leading)
        }
        .foregroundColor(.white)
        .background(
            LinearGradient(gradient: mode.getBackgroundGradient(), startPoint: .topTrailing, endPoint: .bottomLeading)
        )
    }
}

struct HalfPracticeSheet_Previews: PreviewProvider {
    static var previews: some View {
        HalfPracticeSheet(
            viewModel: HalfPracticeSheetModel(),
//            sheetMode: .constant(ResizableSheetState.hidden),
            sheetMode: .constant(false),
            mode: .constant(.custom), showConstructor: .constant(true))
    }
}
