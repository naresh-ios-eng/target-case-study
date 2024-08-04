//
//  SessionManagerTest.swift
//  ProductViewerTests
//
//  Created by Naresh on 04/08/24.
//  Copyright © 2024 Target. All rights reserved.
//

import XCTest
@testable import ProductViewer

final class SessionManagerTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
}

// MARK: - SessionManager test -

extension SessionManagerTest {
    
    func testDataTask() async throws {
        let response = try await SessionManager.shared.dataTask(route: ProductRoute.list, responseType: ProductListModel.self)
        /// Expecting the api to get succeeded
        XCTAssertNotNil(response.products)
    }
    
    func testDataParsingError() async throws {
        do {
            let response = try await SessionManager.shared.dataTask(route: ProductRoute.list, responseType: ProductModel.self)
            XCTAssertNil(response)
        } catch {
            /// This must thorw an error.
            XCTAssertTrue(true)
        }
    }
    
    func testTimeOutError() async throws {
        do {
            let route = SomeInvalidRoute.timeout
            let response = try await SessionManager.shared.dataTask(route: route, responseType: ProductListModel.self)
            
        } catch {
            /// This must thorw an request timeout error.
            XCTAssertEqual(error.localizedDescription, "The request timed out.")
        }
    }
    
    func testInvalidRequest() async throws {
        do {
            let route = SomeInvalidRoute.invalidRequest
            let response = try await SessionManager.shared.dataTask(route: route, responseType: ProductListModel.self)
        } catch {
            /// This must thorw an error.
            let sessionError = error as! SessionError
            XCTAssertEqual(sessionError, SessionError.invalidRequest)
        }
    }
}

enum SomeInvalidRoute: Routable {
    
    case timeout
    case invalidRequest

    var method: ProductViewer.MethodType {
        switch self {
        case .timeout:
            return .put
        case .invalidRequest:
            return .delete
        }
    }
    
    var endPoint: String {
        switch self {
        case .timeout:
            return "some/invalid/endpoint/for/timeout"
        case .invalidRequest:
            return " s o m e / i n v a l i d / r e q u e s t"
        }
    }
    
    var additionalHeaders: [String : String]? {
        nil
    }
    
    var parameters: [String : Any]? {
        nil
    }
    
    var queryParams: [String : String]? {
        nil
    }
}
