//
//  APIConstants.swift
//  Games
//
//  Created by Djaka Permana on 05/08/23.
//

import Foundation

public final class GameAPIConstants {
    
    static let sharedInstance = GameAPIConstants()
    
    private var url: String?
    private var key: String?
    
    private init() {}
    
    var baseUrl: String {
        get {
            return self.url ?? ""
        }
        set {
            url = newValue
        }
    }
    
    var apiKey: String {
        get {
            return self.key ?? ""
        }
        set {
            key = newValue
        }
    }
}
