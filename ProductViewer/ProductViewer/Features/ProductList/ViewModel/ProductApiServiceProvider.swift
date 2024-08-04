//
//  ProductListApiServiceProvider.swift
//  ProductViewer
//
//  Created by Naresh on 03/08/24.
//  Copyright © 2024 Target. All rights reserved.
//

import Foundation

/// This class is responsible to get the product list and details from the apis server.
final class ProductApiServiceProvider: ProductApiServiceProvidable {
    
    /// This function will fetch the product list from server and provide this to the called in async fashion
    /// - Returns: ProductListModel instance
    func fetchProductList() async throws -> ProductListModel {
        return try await SessionManager.shared.dataTask(
            route: ProductRoute.list,
            responseType: ProductListModel.self
        )
    }
    
    /// This function will fetch the product  from server and provide this to the called in async fashion
    /// - Returns: ProductModel instance
    /// - Parameter id: The product id to fetch
    func fetchProductDetail(with id: Int) async throws -> ProductModel {
        return try await SessionManager.shared.dataTask(
            route: ProductRoute.detail(id: id),
            responseType: ProductModel.self
        )
    }
}
