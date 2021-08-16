//
//  UrlSessionNetworkManager.swift
//  Reciplease
//
//  Created by Nathan on 22/10/2020.
//  Copyright © 2020 NathanChicha. All rights reserved.
//

import Foundation
import Alamofire



protocol NetworkManagerProtocol {
    func fetchResult<T: Decodable>(url: URL, completionHandler: @escaping (Result<T, NetworkManagerError>) -> Void)
}


class AlamofireNetworkManager: NetworkManagerProtocol {
    
    init(alamofireSession: AlamofireSessionProtocol = AlamofireSession()) {
        self.alamofireSession = alamofireSession
    }
    
    private let alamofireSession: AlamofireSessionProtocol
    
    func fetchResult<T: Decodable>(url: URL, completionHandler: @escaping (Result<T, NetworkManagerError>) -> Void) {
        

        let urlRequest = URLRequest(url: url)
        
        alamofireSession.fetch(urlRequest: urlRequest) { (response: DataResponse<T, AFError>) in
            
            switch response.result {
            case .failure(let error):
                print(error.localizedDescription)
                completionHandler(.failure(.unknownErrorOccured))
                return
            case .success(let response):
                completionHandler(.success(response))
                return
            }
        }
    }
}
