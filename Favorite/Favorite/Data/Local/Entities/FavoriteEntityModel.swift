//
//  FavoriteEntityModel.swift
//  Favorite
//
//  Created by Djaka Permana on 07/08/23.
//

import Foundation

public class FavoriteEntityModel {
    public var id: Int = 0
    public var slug: String = ""
    public var name: String = ""
    public var released: String = ""
    public var backgroundImage: String = ""
    public var rating: Double = 0.0
    public var parentPlatforms: String = ""
    
    public init() {
        
    }
}

public class FavoritesEntityModel {
    public var games: [FavoriteEntityModel] = []
}
