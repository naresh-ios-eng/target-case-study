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
    
    /// The coordinators those are route from this coordinator.
    var childCoordinators: [Coordinator] { get set }
    
    /// The navigation controller object to navigate to some controller.
    var navigationController: UINavigationController { get set }
    
    /// This start method would be the entry point for any coordinater. It sepecifies the origin of the navigation.
    func start()
    
    /// Going back to previous controller
    func navigateBack()
}

final class AppCoordinator: Coordinator {
    
    /// The coordinators those are route from this coordinator.
    var childCoordinators: [any Coordinator] = []
    
    /// The navigation controller object to navigate to some controller.
    var navigationController: UINavigationController
        
    /// This initialised to initialise the class with navigation controller.
    /// - Parameter navigationController: object of navigation controller.
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    /// This start method would be the entry point for any coordinater. It sepecifies the origin of the navigation.
    func start() {
        let productCoordinator = ProductCoordinator(navigationController: navigationController)
        self.childCoordinators.append(productCoordinator)
        productCoordinator.start()
    }
    
    /// Going back to previous controller
    func navigateBack() {
        self.navigationController.popViewController(animated: true)
    }
}
