//
//  ProductDetailProvidable.swift
//  ProductViewer
//
//  Created by Naresh on 03/08/24.
//  Copyright © 2024 Target. All rights reserved.
//

import Foundation

/// The protocol ensure the confirming class must provide the product list and other required things
protocol ProductDetailProvidable {
    var product: ProductModel { get }
    var apiServiceProvider: ProductApiServiceProvidable { get }
    var delegate: ViewInteractionDelegate? { set get }
    
    init(product: ProductModel, apiServiceProvider: ProductApiServiceProvidable)
    func set(delegate: ViewInteractionDelegate?)
    func refreshData()
    func didTriggeredAction(action: Action)
}


protocol ActionViewDelegate: AnyObject {
    func didTriggeredAction(action: Action)
}
