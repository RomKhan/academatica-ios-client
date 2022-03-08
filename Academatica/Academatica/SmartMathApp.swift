//
//  SmartMathApp.swift
//  SmartMath
//
//  Created by Roman on 04.01.2022.
//

import SwiftUI
import ResizableSheet
import Alamofire
import Combine

@main
struct SmartMathApp: App {
    @State var authLoadShow: Bool = true
    @State var logoOpacity: CGFloat = 1
    @StateObject var viewModel = AcadematicaAppViewModel()
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                if (!authLoadShow) {
                    NavigationView {
                        ZStack {
                            NavigationLink(isActive: $viewModel.isAuthorized) {
                                TabBar()
                                    .navigationBarHidden(true)
                                    .onAppear {
                                        UserService.userSetup()
                                    }
                            } label: {
                                EmptyView()
                            }
                            
                            AuthorizationView()
                                .navigationBarHidden(true)
                        }
                    }
                    .onAppear {
                        withAnimation {
                            logoOpacity = 0
                        }
                    }
                    .preferredColorScheme(.light)
                }
                
                LogoScreen()
                    .opacity(logoOpacity)
                    .animation(.easeIn(duration: 0.2).delay(1), value: logoOpacity)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            UserService.shared.isAuthorized.value = UserService.accessToken == nil ? false : true
                            authLoadShow.toggle()
                        }
                    }
            }
        }
    }
}
