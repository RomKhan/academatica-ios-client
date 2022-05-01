//
//  CustumPracticeCardStackView.swift
//  Academatica
//
//  Created by Roman on 27.04.2022.
//

import SwiftUI

struct CustomPracticeCardStackView: View {
    
    @State var indexFront = 0
    @State var indexMiddle = 1
    @State var indexBack = 2
    @State var swipeVertical = 0
    @State var swipeHorizontal = 0
    @StateObject var viewModel: CustomPracticeCardStackViewModel
    
    var body: some View {
        GeometryReader { reader in
            
            if (viewModel.cardData.isEmpty) {
                ZStack {
                    ForEach((0...2), id: \.self) { index in
                        Rectangle()
                            .fill(.clear)
                            .frame(maxWidth: .infinity, maxHeight: 125, alignment: .leading)
                            .background(index == 0  ?
                                        Color(uiColor: UIColor(
                                            red: 239.0 / 255,
                                            green: 239.0 / 255,
                                            blue: 239.0 / 255,
                                            alpha: 0.2)) :
                                            index == 1 ?
                                        Color(uiColor: UIColor(
                                            red: 239 / 255.0,
                                            green: 147 / 255.0,
                                            blue: 126 / 255.0,
                                            alpha: 1)) :
                                        Color(uiColor: UIColor(
                                            red: 170 / 255.0,
                                            green: 30 / 255.0,
                                            blue: 245 / 255.0,
                                            alpha: 1)))
                            .background(.ultraThinMaterial)
                            .cornerRadius(30)
                            .offset(y: index == indexFront ? 30 :
                                        index == indexMiddle ? 15 :
                                        index == indexBack ? 0 : -15)
                            .offset(y: index == indexFront ? CGFloat(swipeVertical) : 0)
                            .padding(.horizontal, index == indexFront ? 0 :
                                        index == indexMiddle ? 10 :
                                        index == indexBack ? 20 : 30)
                            .opacity(index == indexFront && swipeVertical != 0 ? 1 - Double(swipeVertical) / 20 : 1)
                            .zIndex(index == indexFront ? 0 :
                                        index == indexMiddle ? -1 :
                                        index == indexBack ? -2 : -3)
                    }
                }
                .onAppear(perform: {
                    indexFront = 0
                    indexMiddle = 1
                    indexBack = 2
                })
            } else {
                ZStack {
                    ForEach(Array(zip((viewModel.cardData).indices, (viewModel.cardData))), id: \.0) { (index, tool) in
                        CustomPracticeCardView(tool: tool, mode:
                                                index == indexFront ? .front :
                                                index == indexMiddle ? .middle :
                                                index == indexBack ? .back : .none)
                            .offset(y: index == indexFront ? 30 :
                                        index == indexMiddle ? 15 :
                                        index == indexBack ? 0 : -15)
                            .offset(x: index == indexFront ? CGFloat(swipeHorizontal) : 0, y: index == indexFront ? CGFloat(swipeVertical) : 0)
                            .padding(.horizontal, index == indexFront ? 0 :
                                        index == indexMiddle ? 10 :
                                        index == indexBack ? 20 : 30)
                            .opacity(index == indexFront && swipeVertical != 0 ? max(0.8, 1 - Double(swipeVertical) / 20) : 1)
                            .zIndex(index == indexFront ? 0 :
                                        index == indexMiddle ? -1 :
                                        index == indexBack ? -2 : -3)
                            .highPriorityGesture(DragGesture(minimumDistance: 0, coordinateSpace: .local).onChanged( {value in
                                withAnimation(.spring(), {
                                    if (Int(value.translation.height) != 0) {
                                        swipeVertical = Int(value.translation.height) / abs(Int(value.translation.height)) * min(abs(Int(value.translation.height)), 30)
                                    }
                                    if (Int(value.translation.width) != 0) {
                                        swipeHorizontal = Int(value.translation.width) / abs(Int(value.translation.width)) * min(abs(Int(value.translation.width)), 50)
                                    }
                                })
                            }).onEnded({ value in
                                withAnimation(.spring()) {
                                    if swipeVertical > 3 && swipeVertical < 80 && viewModel.cardData.count > 1 && abs(swipeHorizontal) < 10 {
                                        indexFront = (indexFront + 1) % viewModel.cardData.count
                                        indexMiddle = (indexFront + 1) % viewModel.cardData.count
                                        indexBack = (indexFront + 2) % viewModel.cardData.count
                                    } else if swipeHorizontal >= 10 {
                                        viewModel.choiceTopic(index: indexFront)
                                        if (viewModel.cardData.count > 0) {
                                        indexFront = (indexFront + 1) % viewModel.cardData.count
                                        indexMiddle = (indexFront + 1) % viewModel.cardData.count
                                        indexBack = (indexFront + 2) % viewModel.cardData.count
                                        }
                                    }
                                    swipeVertical = 0
                                    swipeHorizontal = 0
                                }
                            }))
                    }
                }
                .animation(.easeOut, value: viewModel.cardData.isEmpty)
                .transition(.opacity)
            }
            
        }
    }
}

struct CustomPracticeCardStackView_Previews: PreviewProvider {
    static var previews: some View {
        CustomPracticeCardStackView(viewModel: CustomPracticeCardStackViewModel(tierId: "1"))
            .background(LinearGradient(colors: [Color(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)), Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))], startPoint: .top, endPoint: .bottom))
    }
}

