//
//  CircleProgressBar.swift
//  SmartMath
//
//  Created by Roman on 13.01.2022.
//

import SwiftUI

struct CircleProgressBar: View {
    var progress: Float
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 10)
                .opacity(0.3)
                .foregroundColor(Color.white)
                .blendMode(.overlay)
            
            
                    Circle()
                        .trim(from: 0.0, to: CGFloat(min(self.progress, 1.0)))
                        .stroke(style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
                        .fill(LinearGradient(gradient: Gradient(stops: [
                            .init(color: Color(uiColor: UIColor(red: 0, green: 1, blue: 72 / 255.0, alpha: 1)), location: 0),
                            .init(color: Color(uiColor: UIColor(red: 29 / 255.0, green: 195 / 255.0, blue: 76 / 255.0, alpha: 1)), location: 1)
                        ]),
                                       startPoint: .topLeading,
                                       endPoint: .bottomTrailing))
                        .rotationEffect(Angle(degrees: 270.0))

            Text(String(format: "%.0f%%", min(self.progress, 1.0)*100.0))
                .font(.title3)
                .foregroundColor(Color(uiColor: UIColor(red: 0, green: 1, blue: 72 / 255.0, alpha: 1)))
                .bold()
        }
    }
}

struct CircleProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        CircleProgressBar(progress: 0.8)
            .background(LinearGradient(colors: [Color(#colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)), Color(#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1))], startPoint: .top, endPoint: .bottom))
    }
}
