//
//  GameEntity.swift
//  GameInfoAdvance
//
//  Created by Djaka Permana on 04/07/23.
//

import Foundation
import RealmSwift

class GameEntity: Object {
    @Persisted var id: Int = 0
    @Persisted var slug: String = ""
    @Persisted var name: String = ""
    @Persisted var released: String = ""
    @Persisted var backgroundImage: String = ""
    @Persisted var rating: Double = 0.0
    @Persisted var parentPlatforms: String = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

class Games: Object {
    @Persisted var games: List<GameEntity>
}
