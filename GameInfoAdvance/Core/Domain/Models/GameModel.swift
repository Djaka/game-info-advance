//
//  GameModel.swift
//  GameInfoAdvance
//
//  Created by Djaka Permana on 04/07/23.
//

import UIKit

class GameModel {
    var id: Int?
    var name: String?
    var released: String?
    var backgroundImage: String?
    var rating: Double?
    var isFavorite: Bool?
    var platformImages: [UIImageView]?
    
    init(id: Int? = nil, name: String? = nil, released: String? = nil, backgroundImage: String? = nil, rating: Double? = nil, isFavorite: Bool? = nil, platformImages: [UIImageView]? = nil) {
        self.id = id
        self.name = name
        self.released = released
        self.backgroundImage = backgroundImage
        self.rating = rating
        self.isFavorite = isFavorite
        self.platformImages = platformImages
    }
}
