//
//  ProductApiServiceProviderTest.swift
//  ProductViewerTests
//
//  Created by Naresh on 04/08/24.
//  Copyright © 2024 Target. All rights reserved.
//

import XCTest
@testable import ProductViewer

final class ProductApiServiceProviderTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
}

// MARK: - ProductApiServiceProvider test -
extension ProductApiServiceProviderTest  {
    
    /// This function is dependent on the api, if it fails that means there is some issue with the api server.
    func testFetchProductList() async throws {
        let provider = ProductApiServiceProvider()
        let products = try await provider.fetchProductList()
        XCTAssertNotNil(products.products)
    }
    
    /// This function is dependent on the api, if it fails that means there is some issue with the api server.
    func testFetchProductWithId() async throws {
        let provider = ProductApiServiceProvider()
        let product = try await provider.fetchProductDetail(with: 1)
        XCTAssertNotNil(product)
    }
}
