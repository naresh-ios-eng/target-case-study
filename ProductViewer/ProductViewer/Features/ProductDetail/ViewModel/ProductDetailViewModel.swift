//
//  ProductDetailViewModel.swift
//  ProductViewer
//
//  Created by Naresh on 03/08/24.
//  Copyright © 2024 Target. All rights reserved.
//

import Foundation
import Combine

final public class ProductDetailViewModel: ProductDetailProvidable {
    
    private(set) var product: ProductModel
    
    var apiServiceProvider: any ProductApiServiceProvidable
    
    var delegate: (any ViewInteractionDelegate)?
    
    init(product: ProductModel, apiServiceProvider: ProductApiServiceProvidable) {
        self.product = product
        /// Product detail we need to remove, as the detail is showing the api endpoint
        self.product.productDesc = "\n\n\n\n\n\n\n\n\n"
        self.apiServiceProvider = apiServiceProvider
        self.refreshData()
    }
    
    func set(delegate: ViewInteractionDelegate?) {
        self.delegate = delegate
    }
    
    func refreshData() {
        Task { @MainActor [weak self] in
            guard let self = self else { return }
            do {
                self.delegate?.show(loading: true)
                self.product = try await self.apiServiceProvider.fetchProductDetail(with: self.product.id)
                self.delegate?.show(loading: false)
                self.delegate?.reloadUserInterface()
            } catch {
                self.delegate?.show(error: error.localizedDescription)
            }
        }
    }
    
    func didTriggeredAction(action: Action) {
        switch action {
        case .addToCart:
            print("Add the product to cart")
        case .buy:
            print("Buy product")
        }
    }
    
    convenience init() {
        fatalError("init() has not been implemented")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


