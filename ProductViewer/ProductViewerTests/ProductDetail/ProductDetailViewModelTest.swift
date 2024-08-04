//
//  ProductDetailViewModelTest.swift
//  ProductViewerTests
//
//  Created by Naresh on 04/08/24.
//  Copyright © 2024 Target. All rights reserved.
//

import XCTest
@testable import ProductViewer

final class ProductDetailViewModelTest: XCTestCase {

    var expectation: XCTestExpectation?
    var parsable: FileParsable?

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        parsable = Parser()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        parsable = nil
    }
}

// MARK: - ProductDetailViewModel test -
extension ProductDetailViewModelTest  {
    
    private func getProduct() throws -> ProductModel {
        let data = try parsable!.read(fileName: "ProductListJson", ext: "json")
        let json = try JSONDecoder().decode(ProductListModel.self, from: data)
        return json.products![0]
    }
 
    /// Test fetching the product detail from server,  entire flow.
    func testFetchProductDetailFlow() {
        expectation = XCTestExpectation(description: #function)
        /// While fetching the data the following flow must be executed.
        /// 1 Show loader
        /// 2 hide loader
        /// 3 reload data | show error
        expectation!.expectedFulfillmentCount = 3
        /// But intentiating the ProductListViewModel the api call will be triggered
        /// If we want to test the code without api then we have to create a mock class which will impleement ProductApiServiceProvidable protocol and provide some data.
        guard let product = try? self.getProduct() else {
            XCTAssertTrue(false)
            return
        }
        let viewModel = ProductDetailViewModel(product: product, apiServiceProvider: ProductApiServiceProvider())
        viewModel.set(delegate: self)
        XCTAssertNotNil(viewModel.product)
        wait(for: [expectation!], timeout: 60)
    }
    
    func testSetDelegate() {
        guard let product = try? self.getProduct() else {
            XCTAssertTrue(false)
            return
        }
        let viewModel = ProductDetailViewModel(product: product, apiServiceProvider: ProductApiServiceProvider())
        viewModel.set(delegate: self)
        XCTAssertTrue(self === viewModel.delegate)
    }
}


// MARK: - ProductListViewModel test, all delegates must be called on main thread -
extension ProductDetailViewModelTest: ViewInteractionDelegate  {
    func show(loading: Bool) {
        XCTAssertTrue(Thread.isMainThread)
        expectation?.fulfill()
    }
    
    func reloadUserInterface() {
        XCTAssertTrue(Thread.isMainThread)
        expectation?.fulfill()
    }
    
    func show(error: String) {
        XCTAssertTrue(Thread.isMainThread)
        expectation?.fulfill()
    }
    
    func show(success: String) {
        XCTAssertTrue(Thread.isMainThread)
    }
}
