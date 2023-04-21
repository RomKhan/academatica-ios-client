//
//  AppConfiguration.swift
//  Academatica
//
//  Created by Vladislav on 21.04.2023.
//

import Foundation

struct AppConfiguration {
    static var environment: AppEnvironment = {
        if let configuration = Bundle.main.object(forInfoDictionaryKey: "Configuration") as? String {
            if configuration.contains("Staging") {
                return AppEnvironment.Staging
            }
        }
        
        return AppEnvironment.Production
    }()
}
