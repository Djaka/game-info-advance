//
//  GameEntityModel.swift
//  Games
//
//  Created by Djaka Permana on 05/08/23.
//

import Foundation

public class GameEntityModel {
    var id: Int = 0
    var slug: String = ""
    var name: String = ""
    var released: String = ""
    var backgroundImage: String = ""
    var rating: Double = 0.0
    var parentPlatforms: String = ""
}

public class GamesModel {
    var games: [GameEntityModel] = []
}
