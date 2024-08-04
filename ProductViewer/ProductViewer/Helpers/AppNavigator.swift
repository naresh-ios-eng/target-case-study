//
//  AppNavigator.swift
//  ProductViewer
//
//  Created by Naresh on 02/08/24.
//  Copyright © 2024 Target. All rights reserved.
//

import UIKit

final class AppNavigator: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpNavigationBar()
    }
    
    private func setUpNavigationBar() {
        self.navigationBar.isTranslucent = true
    }
}
