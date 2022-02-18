//
//  ArrowButton.swift
//  SmartMath
//
//  Created by Roman on 09.01.2022.
//

import SwiftUI

struct ArrowButton: View {
    var body: some View {
//        Button {
//
//        } label: {
            NextArrow()
                .foregroundColor(.black)
//        }
    }
}

struct NextArrow: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0.94141*width, y: height))
        path.addLine(to: CGPoint(x: 0.05664*width, y: 0.61795*height))
        path.addLine(to: CGPoint(x: 0.05664*width, y: 0.47895*height))
        path.addLine(to: CGPoint(x: 0.94141*width, y: 0.0969*height))
        path.addLine(to: CGPoint(x: 0.94141*width, y: 0.27615*height))
        path.addLine(to: CGPoint(x: 0.26758*width, y: 0.54199*height))
        path.addLine(to: CGPoint(x: 0.26758*width, y: 0.5549*height))
        path.addLine(to: CGPoint(x: 0.94141*width, y: 0.82075*height))
        path.addLine(to: CGPoint(x: 0.94141*width, y: height))
        path.closeSubpath()
        return path
    }
}

struct ArrowButton_Previews: PreviewProvider {
    static var previews: some View {
        ArrowButton()
            .frame(width: 80, height: 100)
    }
}
