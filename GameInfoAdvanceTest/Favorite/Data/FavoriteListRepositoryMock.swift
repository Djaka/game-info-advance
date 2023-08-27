//
//  FavoriteListRepositoryMock.swift
//  GameInfoAdvanceTest
//
//  Created by Djaka Permana on 27/08/23.
//

import Foundation
import Core
import Favorite
import RxSwift

public class FavoriteListRepositoryMock<
    FavoriteLocalDataSourceMock: LocalDataSource,
    Transformer: LocalMapper
>: Repository where
    FavoriteLocalDataSourceMock.Response == FavoriteEntityModel,
    FavoriteLocalDataSourceMock.Request == Any,
    Transformer.Entity == FavoriteEntityModel,
    Transformer.Domain == FavoriteDomainModel {

    public typealias Request = String
    public typealias Response = [FavoriteDomainModel]
    
    private let localDataSource: FavoriteLocalDataSourceMock
    private let mapper: Transformer
    
    public init(localDataSourceMock: FavoriteLocalDataSourceMock, mapper: Transformer) {
        self.localDataSource = localDataSourceMock
        self.mapper = mapper
    }
    
    public func execute(request: String?) -> Observable<[FavoriteDomainModel]> {
        return localDataSource.get(request: request)
            .asObservable()
            .map { favorites in
                return favorites.map { entity in
                    return self.mapper.transformEntityToDomain(entity: entity)
                }
            }
    }
}
