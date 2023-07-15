//
//  DatabaseError.swift
//  GameInfoAdvance
//
//  Created by Djaka Permana on 04/07/23.
//

import Foundation

enum DatabaseError: Error {
    case invalidInstance
    case errorRequest
    case unknown
    
    var message: String {
        switch self {
        case .invalidInstance:
            return "Database can't instance."
        case .errorRequest:
            return "Your request failed."
        case .unknown:
            return "Database error."
        }
    }
}
