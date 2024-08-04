//
//  ProductListViewModel.swift
//  ProductViewer
//
//  Created by Naresh on 03/08/24.
//  Copyright © 2024 Target. All rights reserved.
//

import Foundation

final class ProductListViewModel: ProductListProvidable {
    
    /// This interaction delegate make a communication from ViewModel (Confirming class) to ViewController to inform ViewController about the activity changes.
    weak var delegate: (any ViewInteractionDelegate)?

    /// The apiServiceProvider protocol will allow the object to make api calls to get the product list or produce detail from server.
    private(set) var apiServiceProvider: any ProductApiServiceProvidable
    
    /// The list of products, the initiali value would be empity.
    private(set) var products: [ProductModel] = []
        
    /// This initiliser would only way to initialise the confirming class.
    /// - Parameter apiServiceProvider: Api server provider to provide the api access for product list and detail.
    init(apiServiceProvider: any ProductApiServiceProvidable) {
        self.apiServiceProvider = apiServiceProvider
        self.fetchProducts()
    }
    
    /// This function will set the interaction delegate to interact with controller.
    /// - Parameter delegate: The controller class object.
    func set(delegate: (any ViewInteractionDelegate)?) {
        self.delegate = delegate
    }
    
    /// This function will refresh the product list from index 0
    func refreshData() {
        self.fetchProducts()
    }
    
    /// This function will fetch the product list asynchronously and calle the interatiion delegates.
    private func fetchProducts() {
        Task { @MainActor [weak self] in
            guard let self = self else { return }
            do {
                self.delegate?.show(loading: true)
                self.products = try await self.apiServiceProvider.fetchProductList().products ?? []
                self.delegate?.show(loading: false)
                self.delegate?.reloadUserInterface()
            } catch {
                self.delegate?.show(loading: false)
                self.delegate?.show(error: error.localizedDescription)
            }
        }
    }
}
