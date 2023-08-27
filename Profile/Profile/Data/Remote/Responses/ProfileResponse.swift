//
//  ProfileResponse.swift
//  Profile
//
//  Created by Djaka Permana on 13/08/23.
//

import Foundation

public struct ProfileResponse: Codable {
    public var profile: Profile
    
    enum CodingKeys: String, CodingKey {
        case profile = "data"
    }
}

public struct Profile: Codable {
    public var userId: Int?
    public var author: String?
    public var email: String?
    public var currentJob: String?
    public var description: String?
    public var authorImage: String?
    
    public enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case author = "author"
        case email = "email"
        case currentJob = "current_job"
        case description = "description"
        case authorImage = "author_image"
    }
}
