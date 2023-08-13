//
//  FavoritesTransformer.swift
//  Favorite
//
//  Created by Djaka Permana on 12/08/23.
//

import Foundation
import Core

public struct FavoritesTransformer: LocalMapper {
    
    public typealias Entity = FavoriteEntityModel
    public typealias Domain = FavoriteDomainModel
    
    public init() {
        
    }
    
    public func transformEntityToDomain(entity: FavoriteEntityModel) -> FavoriteDomainModel {
            let favoriteDomainModel = FavoriteDomainModel(
                id: entity.id,
                name: entity.name,
                released: entity.released,
                backgroundImage: entity.backgroundImage,
                rating: entity.rating,
                isFavorite: true
            )
    
            return favoriteDomainModel
    }
    
    public func transformDomainToEntity(domain: FavoriteDomainModel) -> FavoriteEntityModel {
        let gameEntity = FavoriteEntityModel()
        gameEntity.id = domain.id ?? 0
        gameEntity.name = domain.name ?? ""
        gameEntity.released = domain.released ?? ""
        gameEntity.backgroundImage = domain.backgroundImage ?? ""
        gameEntity.rating = domain.rating ?? 0.0

        return gameEntity
    }
}
