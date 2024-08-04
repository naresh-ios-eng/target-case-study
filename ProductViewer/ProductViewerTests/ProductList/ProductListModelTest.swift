//
//  ProductListModelTest.swift
//  ProductViewerTests
//
//  Created by Naresh on 04/08/24.
//  Copyright © 2024 Target. All rights reserved.
//

import XCTest
@testable import ProductViewer

final class ProductListModelTest: XCTestCase {
    
    var parsable: FileParsable?
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        parsable = Parser()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        parsable = nil
    }
    
    func testJsonParsing() throws {
        let data = try parsable!.read(fileName: "ProductListJson", ext: "json")
        let json = try JSONDecoder().decode(ProductListModel.self, from: data)
        XCTAssertNotNil(json.products)
        XCTAssertFalse(json.products!.isEmpty)
    }
    
    func testProductModel() throws {
        
        let data = try parsable!.read(fileName: "ProductListJson", ext: "json")
        let json = try JSONDecoder().decode(ProductListModel.self, from: data)
        XCTAssertNotNil(json.products)
        XCTAssertFalse(json.products!.isEmpty)
        let product = json.products![0]
        /// Checking all the keys are mapped or not ?
        XCTAssertNotNil(product.title)
        XCTAssertNotNil(product.aisle)
        XCTAssertNotNil(product.productDesc)
        XCTAssertNotNil(product.imageUrl)
        XCTAssertNotNil(product.fulfillment)
        XCTAssertNotNil(product.availability)
    }
    
    func testPriceMode() throws {
        let data = try parsable!.read(fileName: "ProductListJson", ext: "json")
        let json = try JSONDecoder().decode(ProductListModel.self, from: data)
        XCTAssertNotNil(json.products)
        XCTAssertFalse(json.products!.isEmpty)
        let price = json.products![0].regularPrice
        XCTAssertNotNil(price)
        XCTAssertNotNil(price?.amountInCents)
        XCTAssertNotNil(price?.currencySymbol)
        XCTAssertNotNil(price?.displayString)
    }
    
    /// Test wheather
    func testInStockAvailability() throws {
        let data = try parsable!.read(fileName: "ProductListJson", ext: "json")
        let json = try JSONDecoder().decode(ProductListModel.self, from: data)
        XCTAssertNotNil(json.products)
        XCTAssertFalse(json.products!.isEmpty)
        let availability = json.products![0].availability
        XCTAssertEqual(availability, AvailabilityStatus.inStock)
    }
    
    func testOutOfStockAvailability() throws {
        let data = try parsable!.read(fileName: "ProductListJson", ext: "json")
        let json = try JSONDecoder().decode(ProductListModel.self, from: data)
        XCTAssertNotNil(json.products)
        XCTAssertFalse(json.products!.isEmpty)
        /// For seocnd item in product json we have set the outOfStock availability
        let availability = json.products![1].availability
        XCTAssertEqual(availability, AvailabilityStatus.outOfStock)
    }
}



