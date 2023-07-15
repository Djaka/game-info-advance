//
//  ProfileResponse.swift
//  GameInfoAdvance
//
//  Created by Djaka Permana on 09/07/23.
//

import Foundation

struct ProfileResponse: Codable {
    var profile: Profile
    
    enum CodingKeys: String, CodingKey {
        case profile = "data"
    }
}

struct Profile: Codable {
    var author: String?
    var email: String?
    var currentJob: String?
    var description: String?
    var authorImage: String?
    
    enum CodingKeys: String, CodingKey {
        case author = "author"
        case email = "email"
        case currentJob = "current_job"
        case description = "description"
        case authorImage = "author_image"
    }
}
