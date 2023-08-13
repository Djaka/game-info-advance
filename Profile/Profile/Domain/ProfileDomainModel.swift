//
//  ProfileDomainModel.swift
//  Profile
//
//  Created by Djaka Permana on 13/08/23.
//

import Foundation

public class ProfileDomainModel {
    public var id: Int?
    public var author: String?
    public var email: String?
    public var currentJob: String?
    public var description: String?
    public var authorImage: String?
    
    public init(id: Int? = 0, author: String? = nil, email: String? = nil, currentJob: String? = nil, description: String? = nil, authorImage: String? = nil) {
        self.id = id
        self.author = author
        self.email = email
        self.currentJob = currentJob
        self.description = description
        self.authorImage = authorImage
    }
}
