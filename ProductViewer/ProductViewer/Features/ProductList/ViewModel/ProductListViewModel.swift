//
//  ProductListViewModel.swift
//  ProductViewer
//
//  Created by Naresh on 03/08/24.
//  Copyright © 2024 Target. All rights reserved.
//

import Foundation

final class ProductListViewModel: ProductListProvidable {
    
    weak var delegate: (any ViewInteractionDelegate)?

    private(set) var apiServiceProvider: any ProductApiServiceProvidable
    
    private(set) var products: [ProductModel] = []
        
    init(apiServiceProvider: any ProductApiServiceProvidable) {
        self.apiServiceProvider = apiServiceProvider
        self.fetchProducts()
    }
    
    func set(delegate: (any ViewInteractionDelegate)?) {
        self.delegate = delegate
    }
    
    func refreshData() {
        self.fetchProducts()
    }
    
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
