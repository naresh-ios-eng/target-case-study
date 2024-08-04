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
                .font: AppFont.SFPro.bold(21).font,
                .foregroundColor: UIColor.targetRed
            ]
        )
        /// Registered price
        let regPriceString = NSAttributedString.init(
            string: " reg. " + (productModel.regularPrice?.displayString ?? ""),
            attributes: [
                .font: AppFont.SFPro.regular(12).font,
                .foregroundColor: UIColor.grayDarkest
            ]
        )
        /// Registered price
        let fulfillmentString = NSAttributedString.init(
            string: "\n" + (productModel.fulfillment ?? ""),
            attributes: [
                .font: AppFont.SFPro.regular(12).font,
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
                .font: AppFont.SFPro.regular(12).font,
                .foregroundColor: UIColor.targetTextGreen
            ]
        )
        /// Registered price
        let aisleString = NSAttributedString.init(
            string: " in aisle " + (productModel.aisle ?? ""),
            attributes: [
                .font: AppFont.SFPro.regular(12).font,
                .foregroundColor: UIColor.textLightGray
            ]
        )
        
        let combinedString = NSMutableAttributedString(attributedString: availability)
        combinedString.append(aisleString)
        
        self.attributedText = combinedString
    }

}
