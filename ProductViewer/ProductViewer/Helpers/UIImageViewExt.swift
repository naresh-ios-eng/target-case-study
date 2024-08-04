//
//  UIImageViewExt.swift
//  ProductViewer
//
//  Created by Naresh on 04/08/24.
//  Copyright © 2024 Target. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {
    
    /// This function will set the image with url string
    /// - Parameters:
    ///   - url: url string
    ///   - placeholderImage: if url is in correct or there is some error while loading the show the placeholder
    func setImage(url: String?, placeholderImage: String = "ic_product_placeholder") {
        guard let url = URL.init(string: url ?? "") else {
            self.image = UIImage(named: "ic_product_placeholder")
            return
        }
        self.kf.setImage(
            with: url,
            placeholder: UIImage(named: "ic_product_placeholder"),
            options: [
                .loadDiskFileSynchronously,
                .cacheOriginalImage,
                .transition(.fade(0.25)),
            ],
            progressBlock: { receivedSize, totalSize in
                // Progress updated
            },
            completionHandler: { result in
                // Done
            }
        )
    }
}
