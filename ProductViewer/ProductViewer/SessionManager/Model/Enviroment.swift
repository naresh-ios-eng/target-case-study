//
//  Enviroment.swift
//  ProductViewer
//
//  Created by Naresh on 02/08/24.
//  Copyright © 2024 Target. All rights reserved.
//

import Foundation

@frozen public enum Enviroment {
    
    case dev
    /// Here we can define all our enviroments like **stage, qa, demo, prod etc**
    
    var baseUrl: String {
        switch self {
        case .dev:
            return "https://api.target.com"
        }
    }
}
