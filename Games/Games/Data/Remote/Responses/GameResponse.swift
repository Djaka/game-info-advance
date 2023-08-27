//
//  GameResponse.swift
//  Games
//
//  Created by Djaka Permana on 02/08/23.
//

import Foundation

// MARK: - GameResponse
public struct GamesResponse: Codable {
    public let results: [GameResponse]
    
    enum CodingKeys: String, CodingKey {
        case results = "results"
    }
}

// MARK: - Result
public struct GameResponse: Codable {
    let id: Int?
    let slug: String?
    let name: String?
    let released: String?
    let backgroundImage: String?
    let rating: Double?
    let updated: String?
    let parentPlatforms: [ParentPlatformResponse]?
    var isFavorite: Bool?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case slug = "slug"
        case name = "name"
        case released = "released"
        case backgroundImage = "background_image"
        case rating = "rating"
        case updated = "updated"
        case parentPlatforms = "parent_platforms"
    }
}
