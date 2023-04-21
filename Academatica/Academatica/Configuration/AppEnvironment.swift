//
//  Environment.swift
//  Academatica
//
//  Created by Vladislav on 21.04.2023.
//

import Foundation

enum AppEnvironment: String {
    case Staging = "staging"
    case Production = "production"
    
    var apiURL: String {
        switch self {
            case .Staging: return "http://127.0.0.1:8081"
            case .Production: return "https://news-platform.ru"
        }
    }
}
