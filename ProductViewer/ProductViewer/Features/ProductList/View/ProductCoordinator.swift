//
//  ProductCoordinator.swift
//  ProductViewer
//
//  Created by Naresh on 03/08/24.
//  Copyright © 2024 Target. All rights reserved.
//

import UIKit

final class ProductCoordinator: ProductCoordinatable {
    
    var childCoordinators: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let serviceProvider = ProductApiServiceProvider()
        let viewModel = ProductListViewModel(apiServiceProvider: serviceProvider)
        let viewController = ProductListViewController(
            viewModel: viewModel,
            loaderProvidable: Loader.initialise()
        )
        viewController.coordinator = self
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    func navigateBack() {
        self.navigationController.popViewController(animated: true)
    }
    
    func openProductDetail(for product: ProductModel) {
        let serviceProvider = ProductApiServiceProvider()
        let viewModel = ProductDetailViewModel(product: product, apiServiceProvider: serviceProvider)
        let viewController = ProductDetailViewController(
            viewModel: viewModel,
            loaderProvidable: Loader.initialise()
        )
        viewController.coordinator = self
        self.navigationController.pushViewController(viewController, animated: true)
    }
}
