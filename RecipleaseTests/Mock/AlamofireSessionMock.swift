import Foundation
import Alamofire

@testable import Reciplease

class AlamofireSessionSuccessMock: AlamofireSessionProtocol {
    func fetch<T: Decodable>(urlRequest: URLRequest, completion: @escaping (DataResponse<T, AFError>) -> Void) {
        let objectResponse = RecipeSearchResponse(count: 3, hits: [])
        
        let result = Result<T, AFError>.success(objectResponse as! T)
        
        let response = DataResponse(
            request: nil,
            response: nil,
            data: nil,
            metrics: nil,
            serializationDuration: 0.1,
            result: result
        )
        
        
        completion(response)
        
    }
}



class AlamofireSessionFailureMock: AlamofireSessionProtocol {
    func fetch<T: Decodable>(urlRequest: URLRequest, completion: @escaping (DataResponse<T, AFError>) -> Void) {
        
        let result = Result<T, AFError>.failure(.explicitlyCancelled)
        
        let response = DataResponse(
            request: nil,
            response: nil,
            data: nil,
            metrics: nil,
            serializationDuration: 0.1,
            result: result
        )
        
        
        completion(response)
        
    }
}
