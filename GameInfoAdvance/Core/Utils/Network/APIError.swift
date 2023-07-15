//
//  APIError.swift
//  GameInfoAdvance
//
//  Created by Djaka Permana on 03/07/23.
//

import Foundation

enum APIError: Error {
    case decode
    case unAuthorize
    case forbidden
    case invalidUrl
    case internalServerError
    case unknown
    
    var message: String {
        switch self {
        case .decode:
            return "Error parsing data"
        case .forbidden:
            return "Access forbidden"
        case .unAuthorize:
            return "Unauthorize access"
        case .invalidUrl:
            return "Invalid URL"
        case .internalServerError:
            return "Internal server error"
        default:
            return "Something went wrong"
        }
    }
}
