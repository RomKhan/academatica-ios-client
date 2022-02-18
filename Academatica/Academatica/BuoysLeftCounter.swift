//
//  Counter.swift
//  Academatica
//
//  Created by Roman on 05.01.2022.
//

import SwiftUI

struct BuoysLeftCounter: View {
    var body: some View {
        HStack(spacing: 7) {
            Circle()
                .strokeBorder(.white, lineWidth: 10)
                .frame(width: 32, height: 32)
            Text("5").font(.system(size: 36, weight: .heavy)).foregroundColor(.white)
        }
    }
}

struct Counter_Previews: PreviewProvider {
    static var previews: some View {
        BuoysLeftCounter().background(.black)
    }
}
