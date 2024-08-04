//
//  ProductRoute.swift
//  ProductViewer
//
//  Created by Naresh on 03/08/24.
//  Copyright © 2024 Target. All rights reserved.
//

import Foundation

enum ProductRoute: Routable {
    
    case list
    case detail(id: Int)
    
    var method: MethodType {
        switch self {
        case.list:
            return .get
        case .detail(_):
            return .get
        }
    }
    
    var endPoint: String {
        switch self {
        case.list:
            return "/mobile_case_study_deals/v1/deals"
        case .detail(let productId):
            return "/mobile_case_study_deals/v1/deals/\(productId)"
        }
    }
    
    var additionalHeaders: [String : String]? {
        switch self {
        case.list:
            return nil
        case .detail(_):
            return nil
        }
    }
    
    var parameters: [String : Any]? {
        switch self {
        case.list:
            return nil
        case .detail(_):
            return nil
        }
    }
    
    var queryParams: [String : String]? {
        switch self {
        case.list:
            return nil
        case .detail(_):
            return nil
        }
    }
}
