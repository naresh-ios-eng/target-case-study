//
//  ProductListModel.swift
//  ProductViewer
//
//  Created by Naresh on 03/08/24.
//  Copyright © 2024 Target. All rights reserved.
//

import Foundation

struct ProductListModel: Codable {
    var products: [ProductModel]?
 
    private enum CodingKeys: String, CodingKey {
        case products
    }
}

struct ProductModel: Codable {
    var id: Int /// without id we should not parse the data.
    var title: String?
    var aisle: String?
    var productDesc: String?
    var imageUrl: String?
    var regularPrice: PriceModel?
    var salePrice: PriceModel?
    var fulfillment: String?
    var availability: AvailabilityStatus?
    
    private enum CodingKeys: String, CodingKey {
        case id, title, aisle, fulfillment, availability
        case productDesc = "description"
        case imageUrl = "image_url"
        case regularPrice = "regular_price"
        case salePrice = "sale_price"
    }
}

struct PriceModel: Codable {
    var amountInCents: Double
    var currencySymbol: String?
    var displayString: String?
    
    private enum CodingKeys: String, CodingKey {
        case amountInCents = "amount_in_cents"
        case currencySymbol = "currency_symbol"
        case displayString = "display_string"
    }
}

enum AvailabilityStatus: String, Codable {
    case inStock = "In stock"
    case outOfStock = "Out of stock"
}

