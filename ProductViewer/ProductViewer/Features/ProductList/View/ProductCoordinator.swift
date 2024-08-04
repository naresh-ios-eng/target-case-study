//
//  ProductCoordinator.swift
//  ProductViewer
//
//  Created by Naresh on 03/08/24.
//  Copyright © 2024 Target. All rights reserved.
//

import UIKit

final class ProductCoordinator: ProductCoordinatable {
    
    /// The coordinators those are route from this coordinator.
    var childCoordinators: [Coordinator] = []
    
    /// The navigation controller object to navigate to some controller.
    var navigationController: UINavigationController
    
    /// This initialised to initialise the class with navigation controller.
    /// - Parameter navigationController: object of navigation controller.
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    /// This start method would be the entry point for any coordinater. It sepecifies the origin of the navigation.
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
    
    /// Going back to previous controller.
    func navigateBack() {
        self.navigationController.popViewController(animated: true)
    }
    
    
    /// This function would open the product detail screen.
    /// - Parameter product: product model.
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
