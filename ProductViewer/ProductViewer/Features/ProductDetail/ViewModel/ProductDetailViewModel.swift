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
    
    /// The detail of the product, the initiali value would have some less information. e.g description would not be there etc..
    private(set) var product: ProductModel
    
    /// The apiServiceProvider protocol will allow the object to make api calls to get the product detail from server.
    var apiServiceProvider: any ProductApiServiceProvidable
    
    /// This interaction delegate make a communication from ViewModel (Confirming class) to ViewController to inform ViewController about the activity changes.
    var delegate: (any ViewInteractionDelegate)?
    
    /// This initiliser would only way to initialise the confirming class.
    /// - Parameters:
    ///   - product: the product model
    ///   - apiServiceProvider: the api service provider to provide the api services.
    init(product: ProductModel, apiServiceProvider: ProductApiServiceProvidable) {
        self.product = product
        /// Product detail we need to remove, as the detail is showing the api endpoint
        self.product.productDesc = "\n\n\n\n\n\n\n\n\n"
        self.apiServiceProvider = apiServiceProvider
        self.refreshData()
    }
    
    convenience init() {
        fatalError("init() has not been implemented")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// This function will set the interaction delegate to interact with controller.
    /// - Parameter delegate: The controller class object.
    func set(delegate: ViewInteractionDelegate?) {
        self.delegate = delegate
    }
    
    /// This function will refresh the product list from index 0
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
    
    /// This function would be triggered when the user tap on any action from detail screen. E,g Add to cart, add to watchlist, Buy now etc.
    /// - Parameter action: The type of action like Add to cart, add to watchlist, Buy now etc.
    func didTriggeredAction(action: Action) {
        switch action {
        case .addToCart:
            print("Add the product to cart")
        case .buy:
            print("Buy product")
        }
    }
}
