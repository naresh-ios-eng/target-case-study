//
//  ProductDetailProvidable.swift
//  ProductViewer
//
//  Created by Naresh on 03/08/24.
//  Copyright © 2024 Target. All rights reserved.
//

import Foundation

/// The protocol ensure the confirming class must provide the product detail and other required things
protocol ProductDetailProvidable {
    
    /// The detail of the product, the initiali value would have some less information. e.g description would not be there etc..
    var product: ProductModel { get }
    
    /// The apiServiceProvider protocol will allow the object to make api calls to get the product detail from server.
    var apiServiceProvider: ProductApiServiceProvidable { get }
    
    /// This interaction delegate make a communication from ViewModel (Confirming class) to ViewController to inform ViewController about the activity changes.
    var delegate: ViewInteractionDelegate? { set get }
    
    /// This initiliser would only way to initialise the confirming class.
    /// - Parameters:
    ///   - product: the product model
    ///   - apiServiceProvider: the api service provider to provide the api services.
    init(product: ProductModel, apiServiceProvider: ProductApiServiceProvidable)
    
    /// This function will set the interaction delegate to interact with controller.
    /// - Parameter delegate: The controller class object.
    func set(delegate: ViewInteractionDelegate?)
    
    /// This function will refresh the product list from index 0
    func refreshData()
    
    /// This function would be triggered when the user tap on any action from detail screen. E,g Add to cart, add to watchlist, Buy now etc.
    /// - Parameter action: The type of action like Add to cart, add to watchlist, Buy now etc.
    func didTriggeredAction(action: Action)
}
