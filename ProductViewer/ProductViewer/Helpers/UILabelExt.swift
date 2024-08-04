//
//  UILabelExt.swift
//  ProductViewer
//
//  Created by Naresh on 04/08/24.
//  Copyright © 2024 Target. All rights reserved.
//

import UIKit

extension UILabel {
    
    /// This function will set the price label in some predefined attributed way.
    /// - Parameter productModel: the product model from which the price and other information will get collected
    func setPriceString(productModel: ProductModel) {
        /// Price string
        let priceString = NSAttributedString.init(
            string: productModel.regularPrice?.displayString ?? "",
            attributes: [
                .font: UIFont.largeBold,
                .foregroundColor: UIColor.targetRed
            ]
        )
        /// Registered price
        let regPriceString = NSAttributedString.init(
            string: " reg. " + (productModel.regularPrice?.displayString ?? ""),
            attributes: [
                .font: UIFont.small,
                .foregroundColor: UIColor.grayDarkest
            ]
        )
        /// Registered price
        let fulfillmentString = NSAttributedString.init(
            string: "\n" + (productModel.fulfillment ?? ""),
            attributes: [
                .font: UIFont.small,
                .foregroundColor: UIColor.textLightGray
            ]
        )
        
        let combinedString = NSMutableAttributedString(attributedString: priceString)
        combinedString.append(regPriceString)
        combinedString.append(fulfillmentString)
        
        self.attributedText = combinedString
    }
    
    
    /// This function will set the availability status in some predefined requrement.
    /// - Parameter productModel: the product model from which the price and other information will get collected
    func setAvailability(productModel: ProductModel) {
        /// Availability string
        let availability = NSAttributedString.init(
            string: productModel.availability?.rawValue ?? "",
            attributes: [
                .font: UIFont.small,
                .foregroundColor: UIColor.targetTextGreen
            ]
        )
        /// Registered price
        let aisleString = NSAttributedString.init(
            string: " in aisle " + (productModel.aisle ?? ""),
            attributes: [
                .font: UIFont.small,
                .foregroundColor: UIColor.textLightGray
            ]
        )
        
        let combinedString = NSMutableAttributedString(attributedString: availability)
        combinedString.append(aisleString)
        
        self.attributedText = combinedString
    }

}
