//
//  ProductDetailCell.swift
//  ProductViewer
//
//  Created by Naresh on 03/08/24.
//  Copyright © 2024 Target. All rights reserved.
//

import UIKit

class ProductDetailCell: UITableViewCell {

    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var headingLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    private var productModel: ProductModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupUI()
    }
    
    public func bind(productModel: ProductModel) {
        self.productModel = productModel
        self.updateContent()
    }
    
    private func updateContent() {
        self.productImageView.setImage(url: productModel?.imageUrl)
        self.titleLabel.text = productModel?.title ?? ""
        if let productModel = productModel {
            priceLabel.setPriceString(productModel: productModel)
        }
        self.headingLabel.text = "Product detail"
        self.descriptionLabel.text = productModel?.productDesc ?? ""
    }
    
    private func setupUI() {
        self.productImageView.layer.cornerRadius = 8
        self.productImageView.layer.masksToBounds = true
        self.productImageView.layer.cornerRadius = 8
        self.productImageView.layer.masksToBounds = true
        self.productImageView.contentMode = .scaleAspectFit
        
        self.titleLabel.font = UIFont.Details.title
        self.titleLabel.textColor = .black
        
        self.headingLabel.font = UIFont.Details.emphasis
        self.headingLabel.textColor = .black
        self.headingLabel.numberOfLines = 0
        
        self.descriptionLabel.font = UIFont.Details.copy2
        self.descriptionLabel.textColor = .grayMedium
        self.descriptionLabel.numberOfLines = 0 
    }
}

// MARK: - Providing an identifier to this class -
extension ProductDetailCell: IdentityProvidable {
    static var id: String {
        return "ProductDetailCell"
    }
}
