//
//  GameFavoriteModel.swift
//  GameInfoAdvance
//
//  Created by Djaka Permana on 06/07/23.
//

import Foundation

class GameFavoriteModel {
    var id: Int?
    var name: String?
    var released: String?
    var backgroundImage: String?
    var rating: Double?
    var isFavorite: Bool?
    
    init(id: Int? = nil, name: String? = nil, released: String? = nil, backgroundImage: String? = nil, rating: Double? = nil, isFavorite: Bool? = nil) {
        self.id = id
        self.name = name
        self.released = released
        self.backgroundImage = backgroundImage
        self.rating = rating
        self.isFavorite = isFavorite
    }
}
