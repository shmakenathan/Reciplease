//
//  NetworkManager.swift
//  Reciplease
//
//  Created by Nathan on 22/10/2020.
//  Copyright © 2020 NathanChicha. All rights reserved.
//

import Foundation

class NetworkManager {
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    let session: URLSession
    
    func fetchResult<T: Decodable>(url: URL, completionHandler: @escaping (Result<T, NetworkManagerError>) -> Void) {
        
        
    
        let task = session.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                completionHandler(.failure(.unknownErrorOccured))
                return
            }
            
            guard let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode else {
                completionHandler(.failure(.invalidResponseStatusCode))
                return
            }
            
            guard let data = data else {
                completionHandler(.failure(.noData))
                return
            }
            
            guard let result = try? JSONDecoder().decode(T.self, from: data) else {
                completionHandler(.failure(.couldNotDecodeJson))
                return
            }
            
            completionHandler(.success(result))
            
        }
        
        task.resume()
    }
}
