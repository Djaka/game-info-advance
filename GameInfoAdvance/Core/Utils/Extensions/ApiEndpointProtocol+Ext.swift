//
//  ApiEndpointProtocol+Ext.swift
//  GameInfoAdvance
//
//  Created by Djaka Permana on 04/07/23.
//

import Foundation

extension APIEndpointProtocol {
    func getDefaultparameter(authenticated: Bool = true) -> [String: Any] {
        var httpHeader: [String: String] = [:]
        
        if authenticated {
            httpHeader["key"] = APIConstants.sharedInstance.apiKey
        }
        
        return httpHeader
    }
}
