//
//  SmartMathApp.swift
//  SmartMath
//
//  Created by Roman on 04.01.2022.
//

import SwiftUI
import ResizableSheet

@main
struct SmartMathApp: App {
    var isAuthorized = false
    
//    static var windowScene: UIWindowScene? {
//        guard let scene = UIApplication.shared.connectedScenes.first,
//              let windowScene = scene as? UIWindowScene else {
//            return nil
//        }
//    
//        return windowScene
//    }
//    
    var body: some Scene {
        WindowGroup {
            if isAuthorized {
                TabBar(viewModel: TabBarViewModel()
//                       , windowScene: SmartMathApp.windowScene
                )
                    .preferredColorScheme(.light)
            }
            else {
                NavigationView {
                AuthorizationView()
                        .navigationBarHidden(true)
                        .preferredColorScheme(.light)
                }
            }
        }
        
    }
}
