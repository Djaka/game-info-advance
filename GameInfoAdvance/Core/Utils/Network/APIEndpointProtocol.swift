//
//  APIEndpointProtocol.swift
//  GameInfoAdvance
//
//  Created by Djaka Permana on 03/07/23.
//

import Foundation
import Alamofire

protocol APIEndpointProtocol {
    var baseURL: URL { get }
    var path: String { get }
    var parameters: Parameters? { get }
    var httpMethod: HTTPMethod { get }
    var parameterEncoding: ParameterEncoding { get }
}

extension APIEndpointProtocol {
    func getDefaultparameter(authenticated: Bool = true) -> [String: Any] {
        var httpHeader: [String: String] = [:]
        
        if authenticated {
            httpHeader["key"] = APIConstants.sharedInstance.apiKey
        }
        
        return httpHeader
    }
}
