//
//  FavoriteModelMock.swift
//  GameInfoAdvanceTest
//
//  Created by Djaka Permana on 27/08/23.
//

import Foundation
import Favorite

func getFavoriteModel() -> FavoriteEntityModel {
    let favoriteModelMock = FavoriteEntityModel()
    favoriteModelMock.id = 3498
    favoriteModelMock.name = "Grand Theft Auto V"
    favoriteModelMock.released = "2013-09-17"
    favoriteModelMock.backgroundImage = "https://media.rawg.io/media/games/456/456dea5e1c7e3cd07060c14e96612001.jpg"
    favoriteModelMock.rating = 4.47
    
    return favoriteModelMock
}

func getFavoritesModel() -> [FavoriteEntityModel] {
    return [
        getFavoriteModel()
    ]
}

