//
//  GameDetailModel.swift
//  GameInfoAdvance
//
//  Created by Djaka Permana on 04/07/23.
//

import UIKit

class GameDetailModel {
    var id: Int?
    var name: String?
    var released: String?
    var backgroundImage: String?
    var backgroundImageAdditional: String?
    var rating: Double?
    var description: String?
    var platformImages: [UIImageView]?
    var isFavorite: Bool?
    
    init(id: Int? = nil, name: String? = nil, released: String? = nil, backgroundImage: String? = nil, backgroundImageAdditional: String? = nil, rating: Double? = nil, description: String? = nil, platformImages: [UIImageView]? = nil, isFavorite: Bool? = nil) {
        self.id = id
        self.name = name
        self.released = released
        self.backgroundImage = backgroundImage
        self.backgroundImageAdditional = backgroundImageAdditional
        self.rating = rating
        self.description = description
        self.platformImages = platformImages
        self.isFavorite = isFavorite
    }
}
