//
//  StatusCodeTest.swift
//  ProductViewerTests
//
//  Created by Naresh on 04/08/24.
//  Copyright © 2024 Target. All rights reserved.
//

import XCTest
@testable import ProductViewer

final class StatusCodeTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
}

// MARK: - StatusCode test -

extension StatusCodeTest {
    
    func testSuccessCode() {
        XCTAssertEqual(StatusCode.success.rawValue, 200)
    }
    
    func testBadRequestCode() {
        XCTAssertEqual(StatusCode.badRequest.rawValue, 403)
    }
    
    func testServerErrorCode() {
        XCTAssertEqual(StatusCode.serverError.rawValue, 503)
    }
    
    func testAuthoriztionFailedCode() {
        XCTAssertEqual(StatusCode.authoriztionFailed.rawValue, 401)
    }
}
