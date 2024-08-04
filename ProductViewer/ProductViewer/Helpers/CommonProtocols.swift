//
//  CommonProtocols.swift
//  ProductViewer
//
//  Created by Naresh on 02/08/24.
//  Copyright © 2024 Target. All rights reserved.
//

import Foundation

/// This protocol is used to make the interation between the view model and the view controller.
protocol ViewInteractionDelegate: AnyObject {
    /// This function will be used to show / hide the loading indicator on controller when a aysn task started on view model side.
    func show(loading: Bool)
    /// This function will be used to reload the view controller ui.
    func reloadUserInterface()
    /// This function will be used to show the error toast on the controller side.
    func show(error: String)
    /// This function will be used to show the success toast on the controller side.
    func show(success: String)
}

/// This protocol ensure the confirming type must provide an id
protocol IdentityProvidable {
    associatedtype Identity
    static var id: Identity { get }
}
