//
//  NetworkManagerError.swift
//  Reciplease
//
//  Created by Nathan on 22/10/2020.
//  Copyright © 2020 NathanChicha. All rights reserved.
//


import Foundation

enum NetworkManagerError: Error {
    case unknownErrorOccured
    
    var message: String {
        return "Unknown error"
    }
    
}
