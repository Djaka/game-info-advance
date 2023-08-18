//
//  GameModel.swift
//  Games
//
//  Created by Djaka Permana on 05/08/23.
//

import UIKit

public class GameDomainModel {
    public var id: Int?
    public var slug: String?
    public var name: String?
    public var released: String?
    public var backgroundImage: String?
    public var rating: Double?
    public var isFavorite: Bool?
    public var platformImages: [UIImageView]?
    
    public init(
        id: Int? = nil,
        slug: String? = nil,
        name: String? = nil,
        released: String? = nil,
        backgroundImage: String? = nil,
        rating: Double? = nil,
        isFavorite: Bool? = nil,
        platformImages: [UIImageView]? = nil
    ) {
        self.id = id
        self.slug = slug
        self.name = name
        self.released = released
        self.backgroundImage = backgroundImage
        self.rating = rating
        self.isFavorite = isFavorite
        self.platformImages = platformImages
    }
}
