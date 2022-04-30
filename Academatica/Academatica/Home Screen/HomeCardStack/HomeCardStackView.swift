//
//  CardSteckView.swift
//  SmartMath
//
//  Created by Roman on 07.01.2022.
//

import SwiftUI

struct HomeCardStackView: View {
    
    @State var indexFront = 0
    @State var indexMiddle = 1
    @State var indexBack = 2
    @State var swipe = 0
    @StateObject var viewModel = HomeCardStackViewModel()
    @Binding var showClass: Bool
    
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
                    ForEach(Array(zip((viewModel.cardData).reversed().indices, (viewModel.cardData).reversed())), id: \.0) { (index, tool) in
                        HomeCardView(tool: tool, mode:
                                    index == indexFront ? .front :
                                    index == indexMiddle ? .middle :
                                    index == indexBack ? .back : .none)
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
                                
                                if value.translation.height == 0 && value.translation.width == 0 {
                                    CourseService.shared.currentClass = ClassModel(id: tool.id, name: tool.name, description: tool.description, expReward: tool.expReward, imageUrl: tool.imageUrl, theoryUrl: tool.theoryUrl, problemNum: tool.problemNum, topicName: tool.topicName, isComplete: false, isUnlocked: true)
                                    withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                                        showClass.toggle()
                                    }
                                }
                            }))
                    }
                }
            }
            .animation(.easeOut, value: viewModel.cardData.isEmpty)
            .transition(.opacity)
            .onAppear {
                viewModel.fillCardStack()
            }
        }
    }
}

struct CardStackView_Previews: PreviewProvider {
    static var previews: some View {
        HomeCardStackView(showClass: .constant(false))
            .background(LinearGradient(colors: [Color(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)), Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))], startPoint: .top, endPoint: .bottom))
    }
}
