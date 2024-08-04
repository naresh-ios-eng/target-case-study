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
    
    /// Color is hexa code
    var titleColor: Int {
        switch self {
        case .addToCart:
            0xFFFFFF
        case.buy:
            0xFFFFFF
        }
    }
    
    /// Action button background color
    var buttonBackgroundColor: Int {
        switch self {
        case .addToCart:
            0xCC0000
        case.buy:
            0xCC0000
        }
    }
    
    /// Action button background color
    var buttonFont: AppFont.SFPro {
        switch self {
        case .addToCart:
            AppFont.SFPro.regular(18)
        case.buy:
            AppFont.SFPro.regular(18)
        }
    }
}

/// This protocol provide a comunication between ActionView and it's container.
protocol ActionViewDelegate: AnyObject {
    
    /// This function would be triggered when the user tap on any action from detail screen. E,g Add to cart, add to watchlist, Buy now etc.
    /// - Parameter action: The type of action like Add to cart, add to watchlist, Buy now etc.
    func didTriggeredAction(action: Action)
}
