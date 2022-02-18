//
//  DataChangeView.swift
//  Academatica
//
//  Created by Roman on 13.02.2022.
//

import SwiftUI

struct DataChangeView: View {
    @StateObject var viewModel = DataChangeViewModel()
    @Environment(\.dismiss) var dismiss
    let mode: DataChangeViewMode
    @State var text: String = ""
    
    var body: some View {
        ScrollView {
            ZStack {
                Text(DataChangeViewMode.getNavigationTitle(mode: mode))
                    .font(.system(size: UIScreen.main.bounds.height / 50, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.vertical, 10)
                Button(action: {
                    dismiss()
                }, label: {
                    SmothArrow()
                        .fill(.white)
                        .frame(width: 11, height: 20)
                })
                    .frame(maxWidth: .infinity, alignment: .leading)
                
            }
            .padding(.horizontal, 26)
            Text(DataChangeViewMode.getMessage(mode: mode))
                .font(.system(size: UIScreen.main.bounds.height / 40, weight: .thin))
                .foregroundColor(.white)
                .shadow(color: .white.opacity(0.5), radius: 5, x: 0, y: 0)
                .padding(.top, UIScreen.main.bounds.height / 10)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 20)
            TextField("", text: $text)
                .placeholder(when: text.isEmpty) {
                    Text(DataChangeViewMode.getPlaceholder(mode: mode))
                        .opacity(0.8)
                        .selfSizeMask(
                            LinearGradient(
                                gradient: Gradient(colors: [viewModel.colors[0], .blue]),
                                startPoint: .bottomLeading,
                                endPoint: .topTrailing)
                        )
                        .blendMode(.overlay)
                }
                .padding(20)
                .background(.ultraThinMaterial)
                .cornerRadius(20)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.white, lineWidth: 4)
                        .shadow(color: .white.opacity(0.5), radius: 4, x: 0, y: 0)
                )
                .padding(.horizontal, 20)
                .padding(.top, 10)
                .foregroundColor(.white)
            if (!text.isEmpty) {
                withAnimation {
                    Button {
                        dismiss()
                    } label: {
                        Text("Подтвердить")
                            .font(.system(size: UIScreen.main.bounds.height / 50, weight: .heavy))
                            .foregroundColor(.white)
                            .padding(20)
                            .padding(.horizontal, 20)
                            .background(viewModel.colors[2])
                            .cornerRadius(25)
                            .shadow(color: viewModel.colors[2].opacity(0.5), radius: 8, x: 0, y: 8)
                    }
                    .padding(.top, UIScreen.main.bounds.height / 2.5)
                }
            }
        }
        .background(
            LinearGradient(
                gradient: Gradient(
                    stops: [
                        .init(color: viewModel.colors[0], location: 0),
                        .init(color: viewModel.colors[1], location: 1.1)
                    ]),
                startPoint: .topTrailing,
                endPoint: .bottomLeading)
        )
        .navigationBarHidden(true)
    }
}

struct DataChangeView_Previews: PreviewProvider {
    static var previews: some View {
        DataChangeView(mode: .emailChange)
    }
}

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {
            
            ZStack(alignment: alignment) {
                placeholder().opacity(shouldShow ? 1 : 0)
                self
            }
        }
    
    func selfSizeMask<T: View>(_ mask: T) -> some View {
        ZStack {
            self.opacity(0)
            mask.mask(self)
        }.fixedSize()
    }
}
