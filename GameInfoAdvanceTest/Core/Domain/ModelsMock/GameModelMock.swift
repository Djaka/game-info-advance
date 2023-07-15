//
//  GameModelMock.swift
//  GameInfoAdvanceTest
//
//  Created by Djaka Permana on 15/07/23.
//

import Foundation
@testable import GameInfoAdvance

var gameModel = GameModel(
    id: 3498,
    name: "Grand Theft Auto V",
    released: "2013-09-17",
    backgroundImage: "https://media.rawg.io/media/games/456/456dea5e1c7e3cd07060c14e96612001.jpg",
    rating: 4.47,
    isFavorite: false
)

var gameModels = [
    GameModel(
        id: 3498,
        name: "Grand Theft Auto V",
        released: "2013-09-17",
        backgroundImage: "https://media.rawg.io/media/games/456/456dea5e1c7e3cd07060c14e96612001.jpg",
        rating: 4.47,
        isFavorite: false
    ),
    GameModel(
        id: 3328,
        name: "The Witcher 3: Wild Hunt",
        released: "2015-05-18",
        backgroundImage: "https://media.rawg.io/media/games/618/618c2031a07bbff6b4f611f10b6bcdbc.jpg",
        rating: 4.66,
        isFavorite: false
    )
]
