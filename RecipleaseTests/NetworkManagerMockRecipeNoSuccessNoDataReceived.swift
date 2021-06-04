//
//  NetworkManagerMockRecipeNoSuccessNoDataReceived.swift
//  RecipleaseTests
//
//  Created by Nathan on 10/12/2020.
//  Copyright © 2020 NathanChicha. All rights reserved.
//

import Foundation
@testable import Reciplease
class NetworkManagerMockRecipeNoSuccessNoDataReceive: NetworkManagerProtocol {
    func fetchResult<T>(url: URL, completionHandler: @escaping (Result<T, NetworkManagerError>) -> Void) where T : Decodable {
        completionHandler(.failure(.unknownErrorOccured))
        
    }
    
}
