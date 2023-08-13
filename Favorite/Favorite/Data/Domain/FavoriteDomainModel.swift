//
//  FavoriteDomainModel.swift
//  Favorite
//
//  Created by Djaka Permana on 11/08/23.
//

import UIKit

public class FavoriteDomainModel {
    public var id: Int?
    public var name: String?
    public var released: String?
    public var backgroundImage: String?
    public var rating: Double?
    public var isFavorite: Bool?
    
    public init(id: Int? = nil, name: String? = nil, released: String? = nil, backgroundImage: String? = nil, rating: Double? = nil, isFavorite: Bool? = nil) {
        self.id = id
        self.name = name
        self.released = released
        self.backgroundImage = backgroundImage
        self.rating = rating
        self.isFavorite = isFavorite
    }
}
