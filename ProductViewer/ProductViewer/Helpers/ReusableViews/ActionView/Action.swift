//
//  Action.swift
//  ProductViewer
//
//  Created by Naresh on 04/08/24.
//  Copyright © 2024 Target. All rights reserved.
//

import Foundation

/// Here we can define the actions like add to card, add to watch list, but now etc
enum Action: Int {
    case addToCart
    case buy

    var title: String {
        switch self {
        case .addToCart:
            "Add to cart"
        case.buy:
            "Buy"
        }
        
    }
}
