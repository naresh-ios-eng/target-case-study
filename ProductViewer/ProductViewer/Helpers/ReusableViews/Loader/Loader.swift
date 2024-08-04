//
//  Loader.swift
//  ProductViewer
//
//  Created by Naresh on 02/08/24.
//  Copyright © 2024 Target. All rights reserved.
//

import UIKit

/// This protocol impose confirming type to provide the loading feature.
protocol LoaderProvidable {
    var loaderTag: Int { get }
    func present(sender: UIView)
    func dismiss(sender: UIView)
}

// MARK: - Loader -
final class Loader: UIView {

    @IBOutlet weak var activityBackgroundView: UIView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
 
    static func initialise() -> Loader {
        guard let loader = Bundle.main.loadNibNamed("Loader", owner: nil)?.first as? Loader else {
            fatalError("Not initialised")
        }
        return loader
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.addActivityBackgroundViewShadow()
        self.setupActivityIndicatorView()
    }
    
    private func addActivityBackgroundViewShadow() {
        activityBackgroundView.backgroundColor = .white
        activityBackgroundView.layer.cornerRadius = 12
        activityIndicatorView.layer.masksToBounds = true
        activityBackgroundView.layer.shadowColor = UIColor.grayMedium.cgColor
        activityBackgroundView.layer.shadowOpacity = 1
        activityBackgroundView.layer.shadowOffset = CGSize.zero
        activityBackgroundView.layer.shadowRadius = 12
    }
    
    private func setupActivityIndicatorView() {
        self.activityIndicatorView.style = .large
        self.activityIndicatorView.color = .targetRed
        self.activityIndicatorView.startAnimating()
    }
}

// MARK: - Confirming to the Loader interface -
extension Loader: LoaderProvidable {
    
    var loaderTag: Int {
        return 251192
    }
    
    func present(sender: UIView) {
        /// check if loader is already showing ?
        if let loaderView = sender.viewWithTag(loaderTag) as? Loader {
            /// Just bring that to front for safety.
            sender.bringSubviewToFront(loaderView)
            return
        }
        self.tag = loaderTag
        sender.addAndCenterSubview(self)
    }
    
    func dismiss(sender: UIView) {
        // Check is loader is added then only remove the loader
        guard let loaderView = sender.viewWithTag(loaderTag) as? Loader else {
            return
        }
        loaderView.removeFromSuperview()
    }
}
