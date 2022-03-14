//
//  LoadingFile.swift
//  Academatica
//
//  Created by Roman on 10.03.2022.
//

import SwiftUI

struct LoadingView: View {
    @Binding var serverState: ServerState
    @Binding var errorMessage: String
    
    var body: some View {
        VStack {
            switch serverState {
            case .none:
                EmptyView()
            case .loading:
                LottieView(name: "loading", loopMode: .loop)
                    Group {
                    Text("Загрузка...")
                    }
                    .offset(y: -UIScreen.main.bounds.height / 4)
            case .success:
                LottieView(name: "success", loopMode: .playOnce)
            case .error:
                LottieView(name: "error", loopMode: .playOnce)
                    Text(errorMessage)
                    .foregroundColor(.red)
                    .offset(y: -UIScreen.main.bounds.height / 4)
            }
        }
        .transition(.opacity)
        .animation(.spring(), value: serverState)
    }
}

struct LoadingFile_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView(serverState: .constant(.success), errorMessage: .constant(""))
    }
}
