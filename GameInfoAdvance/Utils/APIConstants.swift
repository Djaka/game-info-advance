//
//  APIConstants.swift
//  GameInfoAdvance
//
//  Created by Djaka Permana on 04/07/23.
//

import Foundation

public final class APIConstants {
    
    static let sharedInstance = APIConstants()
    
    var baseURL: String {
        do {
            return try AppConfig.value(for: "CF_BASE_URL")
        } catch (let error) {
            fatalError(error.localizedDescription)
        }
    }
    
    var apiKey: String {
        do {
            return try AppConfig.value(for: "CF_API_KEY")
        } catch (let error) {
            fatalError(error.localizedDescription)
        }
    }
}
