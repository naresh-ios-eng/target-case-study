//
//  TestProductRoute.swift
//  ProductViewerTests
//
//  Created by Naresh on 04/08/24.
//  Copyright © 2024 Target. All rights reserved.
//

import XCTest
@testable import ProductViewer

final class ProductRouteTest: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
}

// MARK: - ProductRoute related tests -

extension ProductRouteTest {
    
    func testProductListRoute() {
        let route = ProductRoute.list
        XCTAssertEqual(route.method, MethodType.get)
        XCTAssertEqual(route.endPoint, "/mobile_case_study_deals/v1/deals")
        XCTAssertNil(route.additionalHeaders)
        XCTAssertNil(route.parameters)
        XCTAssertNil(route.queryParams)
    }
    
    func testProductDetailRoute() {
        let id = 1
        let route = ProductRoute.detail(id: id)
        XCTAssertEqual(route.method, MethodType.get)
        XCTAssertEqual(route.endPoint, "/mobile_case_study_deals/v1/deals/\(id)")
        XCTAssertNil(route.additionalHeaders)
        XCTAssertNil(route.parameters)
        XCTAssertNil(route.queryParams)
    }
}
