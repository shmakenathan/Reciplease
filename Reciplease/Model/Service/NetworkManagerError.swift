//
//  NetworkManagerError.swift
//  Reciplease
//
//  Created by Nathan on 22/10/2020.
//  Copyright © 2020 NathanChicha. All rights reserved.
//


import Foundation

enum NetworkManagerError: Error {
    case invalidResponseStatusCode
    case unknownErrorOccured
    case noData
    case couldNotDecodeJson
    
    var message: String {
        switch self {
        case .invalidResponseStatusCode: return "Invalid Response Status Code"
        case .couldNotDecodeJson: return "Unable to decode JSON file"
        case .noData: return "No data received"
        default: return "Unknown error"
        }
    }
    
}
