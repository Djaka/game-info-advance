//
//  GameDetailDomainModel.swift
//  Games
//
//  Created by Djaka Permana on 06/08/23.
//

import UIKit

public class GameDetailDomainModel {
    public var id: Int?
    public var slug: String?
    public var name: String?
    public var released: String?
    public var backgroundImage: String?
    public var backgroundImageAdditional: String?
    public var rating: Double?
    public var description: String?
    public var platformImages: [UIImageView]?
    public var isFavorite: Bool?
    
    public init(id: Int? = nil, slug: String? = nil, name: String? = nil, released: String? = nil, backgroundImage: String? = nil, backgroundImageAdditional: String? = nil, rating: Double? = nil, description: String? = nil, platformImages: [UIImageView]? = nil, isFavorite: Bool? = nil) {
        self.id = id
        self.slug = slug
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
