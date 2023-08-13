//
//  GameRequestParameter.swift
//  Games
//
//  Created by Djaka Permana on 05/08/23.
//

import Foundation

public struct GameParameterRequest {
    public var page: Int
    public var pageSize: Int
    public var search: String
    
    public init(page: Int, pageSize: Int, search: String) {
        self.page = page
        self.pageSize = pageSize
        self.search = search
    }
}
