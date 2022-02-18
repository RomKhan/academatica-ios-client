//
//  CardView.swift
//  SmartMath
//
//  Created by Roman on 07.01.2022.
//

import SwiftUI

enum CardMode {
    case front
    case middle
    case back
    case none
}

struct CardView: View {
    var tool: CardData
    var mode: CardMode
    var body: some View {
        
        VStack(alignment: .leading, spacing: 0) {
            Text(tool.nameOfLesson)
                .font(.system(size: 20).bold())
                .padding(5)
                .padding(.horizontal, 15)
                .padding(.top, 15)
            Text("\(tool.nameOfTopic.uppercased()) - \(tool.numberOfCurrentLesson) out of \(tool.countOfLessons)")
                .font(.system(size: 10))
                .padding(.horizontal, 20)
                .foregroundStyle(Color.black.opacity(0.65))
            Spacer()
            Text(tool.descriptionOfLesson)
                .padding(7)
                .padding(.horizontal, 13)
                .lineLimit(3)
                .foregroundStyle(Color.black.opacity(0.65))
                .font(.system(size: 11))
            Text("+\(tool.expCount) EXP")
                .padding(.bottom, 20)
                .padding(.leading, 20)
                .foregroundColor(Color(uiColor: UIColor(red: 0, green: 212 / 255.0, blue: 110 / 255.0, alpha: 1)))
                .font(.system(size: 12).bold())
        }
        .frame(maxWidth: .infinity, maxHeight: 160, alignment: .leading)
        .background(mode == .front ?
                    Color(uiColor: UIColor(
                        red: 239.0 / 255,
                        green: 239.0 / 255,
                        blue: 239.0 / 255,
                        alpha: 0.2)) :
                        mode == .middle ?
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
        .opacity(mode == .none ? 0 : 1)
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(tool: CardData(
            id: 0, nameOfTopic: "Natural Numbers",
            nameOfLesson: "Decimals",
            descriptionOfLesson: "Decimal numbers and decimal notation",
            countOfLessons: 4,
            numberOfCurrentLesson: 2,
            expCount: 100), mode: .middle)
            .padding()
            .background(LinearGradient(colors: [Color(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)), Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))], startPoint: .top, endPoint: .bottom))
    }
}
