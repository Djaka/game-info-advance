//
//  ProfileModel.swift
//  GameInfoAdvance
//
//  Created by Djaka Permana on 09/07/23.
//

import Foundation

class ProfileModel {
    var author: String?
    var email: String?
    var currentJob: String?
    var description: String?
    var authorImage: String?
    
    init(author: String? = nil, email: String? = nil, currentJob: String? = nil, description: String? = nil, authorImage: String? = nil) {
        self.author = author
        self.email = email
        self.currentJob = currentJob
        self.description = description
        self.authorImage = authorImage
    }
}
