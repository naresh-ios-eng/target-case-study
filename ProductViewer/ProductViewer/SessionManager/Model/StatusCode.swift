//
//  StatusCode.swift
//  ProductViewer
//
//  Created by Naresh on 02/08/24.
//  Copyright © 2024 Target. All rights reserved.
//
import Foundation

/// Here we will define the status code as per the server configuration, like 200 for success, 401 for unauthorised access. You may ask your backend team and update the code if required.
public enum StatusCode: Int {
    case success = 200
    case badRequest = 403
    case serverError = 503
    case authoriztionFailed = 401
}
