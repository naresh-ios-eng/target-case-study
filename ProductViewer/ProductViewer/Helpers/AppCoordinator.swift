//
//  AppCoordinator.swift
//  ProductViewer
//
//  Created by Naresh on 02/08/24.
//  Copyright © 2024 Target. All rights reserved.
//

import UIKit

/// This protocol is used to make the coordinator
protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    func start()
    func navigateBack()
}

final class AppCoordinator: Coordinator {
    
    var childCoordinators: [any Coordinator] = []
    
    var navigationController: UINavigationController
        
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let productCoordinator = ProductCoordinator(navigationController: navigationController)
        self.childCoordinators.append(productCoordinator)
        productCoordinator.start()
    }
    
    func navigateBack() {
        self.navigationController.popViewController(animated: true)
    }
}
