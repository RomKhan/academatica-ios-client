//
//  Counter.swift
//  Academatica
//
//  Created by Roman on 05.01.2022.
//

import SwiftUI

struct BuoysLeftCounter: View {
    @StateObject var viewModel = BuoysLeftCounterViewModel()
    var body: some View {
        HStack(spacing: 7) {
            Image("buoy")
                .resizable()
                .scaledToFit()
                .frame(width: 32, height: 32)
            if (viewModel.amount == nil) {
                RoundedRectangle(cornerRadius: 10)
                    .fill(.white)
                    .blendMode(.overlay)
                    .frame(maxWidth: 36)
                    
            } else {
                Text("\(viewModel.amount ?? -1)").font(.system(size: 36, weight: .heavy)).foregroundColor(.white)
            }
        }
        .animation(.easeOut, value: viewModel.amount)
        .transition(.opacity)
        .frame(height: 40)
        .onAppear {
            viewModel.counterUpdate()
        }
    }
}

struct Counter_Previews: PreviewProvider {
    static var previews: some View {
        BuoysLeftCounter().background(.black)
    }
}
