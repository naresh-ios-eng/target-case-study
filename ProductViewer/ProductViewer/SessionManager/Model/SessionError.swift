//
//  SessionError.swift
//  ProductViewer
//
//  Created by Naresh on 02/08/24.
//  Copyright © 2024 Target. All rights reserved.
//
import Foundation

/// These are the errors we can throw from api function if any sepecified condition met.
public enum SessionError: Error, Equatable {
    case parsingError
    case invalidRequest
    case internalServerError
    case authorizationFailed
    case error(code: Int, message: String)
    
    /// Here we will specify the message we need to show to the end user. The localisation can also be done here if needed.
    var message: String {
        switch self {
        case .parsingError:
            return "The data is not in the correct format. Please try agian later"
        case .invalidRequest:
            return "The invalid request. Please try agian later"
        case .internalServerError:
            return "Somethihg went wrong. Please try again later"
        case .error(_, let message):
            return message
        case .authorizationFailed:
            return "Authorization failed"
        }
    }
}
