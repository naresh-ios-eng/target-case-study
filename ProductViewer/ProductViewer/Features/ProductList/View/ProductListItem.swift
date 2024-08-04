//
//  ProductListCell.swift
//  ProductViewer
//
//  Created by Naresh on 03/08/24.
//  Copyright © 2024 Target. All rights reserved.
//

import UIKit

class ProductListItem: UICollectionViewCell {
        
    lazy var listItemView: ProductListItemView = {
        let view = ProductListItemView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        addAndPinSubview(contentView)
        
        contentView.addAndPinSubview(listItemView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not implemented")
    }
}


final class ProductListItemView: UIView {
    let productImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 8
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    let priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.numberOfLines = 0
        return label
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.numberOfLines = 0
        label.font = UIFont.medium
        label.textColor = .black
        return label
    }()
    
    let availablityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.numberOfLines = 0
        return label
    }()
    
    init() {
        super.init(frame: .zero)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        backgroundColor = .white
        
        addSubview(productImage)
        addSubview(priceLabel)
        addSubview(titleLabel)
        addSubview(availablityLabel)
        
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 140),
            productImage.heightAnchor.constraint(equalToConstant: 140),
            productImage.widthAnchor.constraint(equalTo: productImage.heightAnchor),
            productImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            productImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            
            priceLabel.leadingAnchor.constraint(equalTo: productImage.trailingAnchor, constant: 10),
            priceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            priceLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            priceLabel.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -10),
            
            titleLabel.leadingAnchor.constraint(equalTo: productImage.trailingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            titleLabel.bottomAnchor.constraint(equalTo: availablityLabel.topAnchor, constant: -10),

            availablityLabel.leadingAnchor.constraint(equalTo: productImage.trailingAnchor, constant: 10),
            availablityLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            availablityLabel.bottomAnchor.constraint(greaterThanOrEqualTo: bottomAnchor, constant: -5)
        ])
        priceLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        titleLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        availablityLabel.setContentHuggingPriority(.defaultLow, for: .vertical)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

extension ProductListItemView {
    func configure(for product: ProductModel) {
        titleLabel.text = product.title
        priceLabel.setPriceString(productModel: product)
        productImage.setImage(url: product.imageUrl)
        availablityLabel.setAvailability(productModel: product)
    }
}

extension ProductListItem: IdentityProvidable {
    static var id: String {
        return "ProductListItem"
    }
}
