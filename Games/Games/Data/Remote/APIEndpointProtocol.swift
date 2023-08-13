//
//  APIEndpointProtocol.swift
//  Games
//
//  Created by Djaka Permana on 05/08/23.
//

import Foundation
import Alamofire
import Core

extension APIEndpointProtocol {
    func getDefaultparameter(authenticated: Bool = true) -> [String: Any] {
        var httpHeader: [String: String] = [:]
        
        if authenticated {
            httpHeader["key"] = GameAPIConstants.sharedInstance.apiKey
        }
        
        return httpHeader
    }
}
