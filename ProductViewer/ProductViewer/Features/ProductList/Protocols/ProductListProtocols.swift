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
    var products: [ProductModel] { get }
    var apiServiceProvider: ProductApiServiceProvidable { get }
    var delegate: ViewInteractionDelegate? { set get }
    
    init(apiServiceProvider: ProductApiServiceProvidable)
    func set(delegate: ViewInteractionDelegate?)
    func refreshData()
}

/// This protocol must ensure the confiming class must provide the product api related stuff.
protocol ProductApiServiceProvidable: AnyObject {
    func fetchProductList() async throws -> ProductListModel
    func fetchProductDetail(with id: Int) async throws -> ProductModel
}

protocol ProductCoordinatable: Coordinator {
    func openProductDetail(for product: ProductModel)
}

