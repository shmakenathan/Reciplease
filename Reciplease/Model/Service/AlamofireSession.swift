
import Foundation
import Alamofire



protocol AlamofireSessionProtocol {
    func fetch<T: Decodable>(urlRequest: URLRequest, completion: @escaping (DataResponse<T, AFError>) -> Void)
}

class AlamofireSession: AlamofireSessionProtocol {
    func fetch<T: Decodable>(urlRequest: URLRequest, completion: @escaping (DataResponse<T, AFError>) -> Void) {
        AF.request(urlRequest)
            .validate()
            .responseDecodable(of: T.self) { response in
                completion(response)
            }
    }
}
