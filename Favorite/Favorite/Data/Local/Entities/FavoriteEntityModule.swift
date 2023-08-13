//
//  FavoriteEntityModule.swift
//  Favorite
//
//  Created by Djaka Permana on 07/08/23.
//

import Foundation
import RealmSwift

class FavoriteEntityModule: Object {
    @Persisted var id: Int = 0
    @Persisted var slug: String = ""
    @Persisted var name: String = ""
    @Persisted var released: String = ""
    @Persisted var backgroundImage: String = ""
    @Persisted var rating: Double = 0.0
    @Persisted var parentPlatforms: String = ""

    public override static func primaryKey() -> String? {
        return "id"
    }
}

class Favorites: Object {
    @Persisted var favorites: List<FavoriteEntityModule>
}
