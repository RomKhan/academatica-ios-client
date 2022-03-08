//
//  CardSteckVIew.swift
//  SmartMath
//
//  Created by Roman on 07.01.2022.
//

import SwiftUI

struct CardStackVIew: View {
    
    @State var indexFront = 0
    @State var indexMiddle = 1
    @State var indexBack = 2
    @State var swipe = 0
    @StateObject var viewModel = CardStackVIewModel()
    
    var body: some View {
        GeometryReader { reader in
            ZStack {
                if (viewModel.cardData.isEmpty) {
                    ForEach((0...2), id: \.self) { index in
                        Rectangle()
                            .fill(.clear)
                            .frame(maxWidth: .infinity, maxHeight: 160, alignment: .leading)
                            .background(index == 0 ?
                                        Color(uiColor: UIColor(
                                            red: 239.0 / 255,
                                            green: 239.0 / 255,
                                            blue: 239.0 / 255,
                                            alpha: 0.2)) :
                                            index == 1 ?
                                        Color(uiColor: UIColor(
                                            red: 15.0 / 255,
                                            green: 205.0 / 255,
                                            blue: 246.0 / 255,
                                            alpha: 0.5)) :
                                        Color(uiColor: UIColor(
                                            red: 11.0 / 255,
                                            green: 76.0 / 255,
                                            blue: 243.0 / 255,
                                            alpha: 0.6)))
                            .background(.ultraThinMaterial)
                            .cornerRadius(30)
                            .offset(y: index == indexFront ? 30 :
                                        index == indexMiddle ? 15 :
                                        index == indexBack ? 0 : -15)
                            .offset(y: index == indexFront ? CGFloat(swipe) : 0)
                            .padding(.horizontal, index == indexFront ? 0 :
                                        index == indexMiddle ? 10 :
                                        index == indexBack ? 20 : 30)
                            .opacity(index == indexFront && swipe != 0 ? 1 - Double(swipe) / 20 : 1)
                            .zIndex(index == indexFront ? 0 :
                                        index == indexMiddle ? -1 :
                                        index == indexBack ? -2 : -3)
                    }
                } else {
                    ForEach((viewModel.cardData).reversed()) { tool in
                        CardView(tool: tool, mode:
                                    tool.id == indexFront ? .front :
                                    tool.id == indexMiddle ? .middle :
                                    tool.id == indexBack ? .back : .none)
                            .offset(y: tool.id == indexFront ? 30 :
                                        tool.id == indexMiddle ? 15 :
                                        tool.id == indexBack ? 0 : -15)
                            .offset(y: tool.id == indexFront ? CGFloat(swipe) : 0)
                            .padding(.horizontal, tool.id == indexFront ? 0 :
                                        tool.id == indexMiddle ? 10 :
                                        tool.id == indexBack ? 20 : 30)
                            .opacity(tool.id == indexFront && swipe != 0 ? 1 - Double(swipe) / 20 : 1)
                            .zIndex(tool.id == indexFront ? 0 :
                                        tool.id == indexMiddle ? -1 :
                                        tool.id == indexBack ? -2 : -3)
                    }
                }
            }
            .animation(.easeOut, value: viewModel.cardData.isEmpty)
            .transition(.opacity)
            .highPriorityGesture(DragGesture(minimumDistance: 0, coordinateSpace: .local).onChanged( {value in
                withAnimation(.spring(), {
                    if value.translation.height > 0 {
                        swipe = swipe < 10 ? swipe + 1 : 10
                    }
                    else if value.translation.height < 0 {
                        swipe = swipe > 0 ? swipe - 1 : 0
                    }
                })
            }).onEnded({ value in
                withAnimation(.spring()) {
                    if swipe > 3 && viewModel.cardData.count > 1 {
                        indexFront = (indexFront + 1) % viewModel.cardData.count
                        indexMiddle = (indexFront + 1) % viewModel.cardData.count
                        indexBack = (indexFront + 2) % viewModel.cardData.count
                    }
                    swipe = 0
                }
            }))
            .onAppear {
                viewModel.fillCardStack()
            }
        }
    }
}

struct CardSteckVIew_Previews: PreviewProvider {
    static var previews: some View {
        CardStackVIew()
            .background(LinearGradient(colors: [Color(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)), Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))], startPoint: .top, endPoint: .bottom))
    }
}
