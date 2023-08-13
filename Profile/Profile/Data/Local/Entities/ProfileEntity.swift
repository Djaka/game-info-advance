//
//  ProfileEntity.swift
//  Profile
//
//  Created by Djaka Permana on 13/08/23.
//

import Foundation
import RealmSwift

class ProfileEntity: Object {
    @Persisted var id: Int = 0
    @Persisted var author: String = ""
    @Persisted var email: String = ""
    @Persisted var currentJob: String = ""
    @Persisted var contents: String = ""
    @Persisted var authorImage: String = ""
    
    public override static func primaryKey() -> String? {
        return "id"
    }
}
