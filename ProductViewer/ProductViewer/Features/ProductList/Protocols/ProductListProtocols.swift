//
//  ProductListProvidable.swift
//  ProductViewer
//
//  Created by Naresh on 03/08/24.
//  Copyright © 2024 Target. All rights reserved.
//

import Foundation

/// The protocol ensure the confirming class must provide the product list and other required things
protocol ProductListProvidable: AnyObject {
    
    /// The list of products, the initiali value would be empity.
    var products: [ProductModel] { get }
    
    /// The apiServiceProvider protocol will allow the object to make api calls to get the product list or produce detail from server.
    var apiServiceProvider: ProductApiServiceProvidable { get }
    
    /// This interaction delegate make a communication from ViewModel (Confirming class) to ViewController to inform ViewController about the activity changes.
    var delegate: ViewInteractionDelegate? { set get }
    
    /// This initiliser would only way to initialise the confirming class.
    /// - Parameter apiServiceProvider: Api server provider to provide the api access for product list and detail.
    init(apiServiceProvider: ProductApiServiceProvidable)
    
    /// This function will set the interaction delegate to interact with controller.
    /// - Parameter delegate: The controller class object.
    func set(delegate: ViewInteractionDelegate?)
    
    /// This function will refresh the product list from index 0
    func refreshData()
}

/// This protocol must ensure the confiming class must provide the product api related stuff.
protocol ProductApiServiceProvidable: AnyObject {
    
    /// This function will fetch the list of products from server. In this function we can add the index and offset to provide the pagination support. Since as of now we don't have pagination so ommitted.
    /// - Returns: ProductListModel which will provide array of products.
    func fetchProductList() async throws -> ProductListModel
    
    /// This function will get the product detail by product id.
    /// - Parameter id: Product id
    /// - Returns: ProductModel which will provide complete information of product.
    func fetchProductDetail(with id: Int) async throws -> ProductModel
}


/// This protocol ensure the confirming type must provide the navigation to product detail screen.
protocol ProductCoordinatable: Coordinator {
    
    /// This function would be used to navigate to the product detail screen.
    /// - Parameter product: The product model.
    func openProductDetail(for product: ProductModel)
}

