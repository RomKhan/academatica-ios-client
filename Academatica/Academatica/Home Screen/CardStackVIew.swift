//
//  CardSteckVIew.swift
//  SmartMath
//
//  Created by Roman on 07.01.2022.
//

import SwiftUI

struct CardStackVIew: View {
    @State var cardData = [
        CardData(
            id: 0, nameOfTopic: "Natural Numbers1",
            nameOfLesson: "Decimals",
            descriptionOfLesson: "Decimal numbers and decimal notation Decimal numbers and decimal notation Decimal numbers and decimal notation",
            countOfLessons: 4,
            numberOfCurrentLesson: 2,
            expCount: 100),
        CardData(
            id: 1, nameOfTopic: "Natural Numbers2",
            nameOfLesson: "Decimals",
            descriptionOfLesson: "Decimal numbers and decimal notation",
            countOfLessons: 4,
            numberOfCurrentLesson: 2,
            expCount: 100),
        CardData(
            id: 2, nameOfTopic: "Natural Numbers3",
            nameOfLesson: "Decimals",
            descriptionOfLesson: "Decimal numbers and decimal notation",
            countOfLessons: 4,
            numberOfCurrentLesson: 2,
            expCount: 100),
        CardData(
            id: 3, nameOfTopic: "Natural Numbers4",
            nameOfLesson: "Decimals",
            descriptionOfLesson: "Decimal numbers and decimal notation",
            countOfLessons: 4,
            numberOfCurrentLesson: 2,
            expCount: 100),
        CardData(
            id: 4, nameOfTopic: "Natural Numbers5",
            nameOfLesson: "Decimals",
            descriptionOfLesson: "Decimal numbers and decimal notation",
            countOfLessons: 4,
            numberOfCurrentLesson: 2,
            expCount: 100),
        CardData(
            id: 5, nameOfTopic: "Natural Numbers6",
            nameOfLesson: "Decimals",
            descriptionOfLesson: "Decimal numbers and decimal notation",
            countOfLessons: 4,
            numberOfCurrentLesson: 2,
            expCount: 100),
        CardData(
            id: 6, nameOfTopic: "Natural Numbers7",
            nameOfLesson: "Decimals",
            descriptionOfLesson: "Decimal numbers and decimal notation",
            countOfLessons: 4,
            numberOfCurrentLesson: 2,
            expCount: 100),
        CardData(
            id: 7, nameOfTopic: "Natural Numbers8",
            nameOfLesson: "Decimals",
            descriptionOfLesson: "Decimal numbers and decimal notation",
            countOfLessons: 4,
            numberOfCurrentLesson: 2,
            expCount: 100),
        CardData(
            id: 8, nameOfTopic: "Natural Numbers9",
            nameOfLesson: "Decimals",
            descriptionOfLesson: "Decimal numbers and decimal notation",
            countOfLessons: 4,
            numberOfCurrentLesson: 2,
            expCount: 100)
    ]
    
    @State var indexFront = 0
    @State var indexMiddle = 1
    @State var indexBack = 2
    @State var swipe = 0
    
    var body: some View {
        GeometryReader { reader in
            ZStack {
                ForEach((cardData).reversed()) { tool in
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
                    if swipe > 3 {
                        indexFront = (indexFront + 1) % cardData.count
                        indexMiddle = (indexFront + 1) % cardData.count
                        indexBack = (indexFront + 2) % cardData.count
                    }
                    swipe = 0
                }
            }))
        }
    }
}

struct CardSteckVIew_Previews: PreviewProvider {
    static var previews: some View {
        CardStackVIew()
            .background(LinearGradient(colors: [Color(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)), Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))], startPoint: .top, endPoint: .bottom))
    }
}
