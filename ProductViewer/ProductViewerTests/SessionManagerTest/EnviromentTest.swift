//
//  EnviromentTest.swift
//  ProductViewerTests
//
//  Created by Naresh on 04/08/24.
//  Copyright © 2024 Target. All rights reserved.
//

import XCTest
@testable import ProductViewer

final class EnviromentTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
}

// MARK: - Enviroment test -

extension EnviromentTest {
    
    func testDevEnviromentBaseUrl() {
        let env = Enviroment.dev
        XCTAssertEqual(env.baseUrl, "https://api.target.com")
    }
}
