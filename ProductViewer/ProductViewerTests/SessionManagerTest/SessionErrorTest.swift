//
//  EnviromentTest.swift
//  ProductViewerTests
//
//  Created by Naresh on 04/08/24.
//  Copyright © 2024 Target. All rights reserved.
//

import XCTest
@testable import ProductViewer

final class SessionErrorTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
}

// MARK: - SessionError test -

extension SessionErrorTest {
    
    func testPasringErrorMessage() {
        XCTAssertEqual(SessionError.parsingError.message, "The data is not in the correct format. Please try agian later")
    }
    
    func testInvalidRequestMessage() {
        XCTAssertEqual(SessionError.invalidRequest.message, "The invalid request. Please try agian later")
    }
    
    func testAuthorizationFailedMessage() {
        XCTAssertEqual(SessionError.authorizationFailed.message, "Authorization failed")
    }
    
    func testInternalServerErrorMessage() {
        XCTAssertEqual(SessionError.internalServerError.message, "Somethihg went wrong. Please try again later")
    }
}

