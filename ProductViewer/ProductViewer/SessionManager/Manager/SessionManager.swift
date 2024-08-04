//
//  SessionManager.swift
//  ProductViewer
//
//  Created by Naresh on 02/08/24.
//  Copyright © 2024 Target. All rights reserved.
//

import Foundation
import Combine

final public class SessionManager: NSObject {
    
    /// This is the singleton instance of this class
    public static var shared = SessionManager()
    /// The shared session
    private var session: URLSession
    /// Configuration
    private var configuration: URLSessionConfiguration
    /// After one minute the api will return timeout error
    private var timeout: TimeInterval = 60
    /// This enviroment must be fetched from the current scheme we are running. As of now we are hardcoding this.
    private var enviroment: Enviroment
    /// If internet is not there then any api call happen then on connectivity it will call the api.
    private let waitsForConnectivity: Bool = true
    /// variable for refreing the publisher.
    private var cancellable: AnyCancellable?
    
    /// This will make this class as the singlton
    private override init() {
        /// ephemeral - a session configuration that uses no persistent storage for caches, cookies, or credentials.
        configuration = URLSessionConfiguration.ephemeral
        configuration.timeoutIntervalForRequest = timeout / 2
        configuration.timeoutIntervalForResource = timeout
        configuration.waitsForConnectivity = waitsForConnectivity
        session = URLSession.init(configuration: configuration)
        enviroment = .dev
    }
    
    //MARK: - ASYNC VERSION OF THE API HANDLER -
    
    /// This function will hit api and return the response in provided format
    /// - Parameters:
    ///   - route: api route information
    ///   - responseType: response type
    /// - Returns: desription
    public func dataTask<T: Codable>(route: Routable, responseType: T.Type) async throws -> T {
        /// Making the URL request.
        let urlRequest: URLRequest = try route.urlRequest(enviroment: self.enviroment)
        let (data, response) = try await session.data(for: urlRequest)
        guard let httpStatusCode = (response as? HTTPURLResponse)?.statusCode else {
            /// We didn't get the status code at all, there might be some erver related issue
            throw SessionError.internalServerError
        }
        guard let statusCode = StatusCode(rawValue: httpStatusCode) else {
            /// Status code is something else.
            throw SessionError.parsingError
        }
        switch statusCode {
        case .success:
            if !data.isEmpty {
                return try JSONDecoder().decode(T.self, from: data)
            } else {
                throw SessionError.parsingError
            }
        case .badRequest, .serverError:
            throw SessionError.internalServerError
        case .authoriztionFailed:
            // Here we need to refresh the token and make the api call again. We need to check if authorization failed for refresh api then logout the user.
            /// **As of now I am just throwing error, request interceptor would be introduced for retry machanism**
            throw SessionError.authorizationFailed
        }
    }
}
