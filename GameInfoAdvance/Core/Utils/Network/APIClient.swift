//
//  APIClient.swift
//  GameInfoAdvance
//
//  Created by Djaka Permana on 03/07/23.
//

import Foundation
import Alamofire
import RxSwift

protocol APIClient {
    func request<T: Codable>(endpoint: APIEndpointProtocol, responseModel: T.Type) -> Observable<T>
}

extension APIClient {
    func request<T: Codable>(endpoint: APIEndpointProtocol, responseModel: T.Type) -> Observable<T> {
        
        return Observable<T>.create { observer in
            
            do {
                let urlRequest = try getUrlRequest(with: endpoint)
                
                let request = AF.request(urlRequest).responseDecodable(of: T.self) { response in
                    
                    switch response.result {
                    case .success(let value):
                        observer.onNext(value)
                        observer.onCompleted()
                        
                    case .failure(let error):
                        switch error.responseCode {
                        case 401:
                            observer.onError(APIError.unAuthorize)
                        case 403:
                            observer.onError(APIError.forbidden)
                        case 404:
                            observer.onError(APIError.invalidUrl)
                        case 500:
                            observer.onError(APIError.internalServerError)
                        default:
                            observer.onError(APIError.unknown)
                        }
                    }
                }
                
                return Disposables.create {
                    request.cancel()
                }
            } catch(let error) {
                observer.onError(error)
                return Disposables.create()
            }
        }
    }
    
    private func getUrlRequest(with endpoint: APIEndpointProtocol) throws -> URLRequest {
        let url = try endpoint.baseURL.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(endpoint.path))
        urlRequest.httpMethod = endpoint.httpMethod.rawValue
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        
        let encoding = endpoint.parameterEncoding
        
        return try encoding.encode(urlRequest, with: endpoint.parameters)
    }
}
