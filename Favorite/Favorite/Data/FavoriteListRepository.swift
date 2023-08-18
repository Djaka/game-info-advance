//
//  FavoriteRepository.swift
//  Favorite
//
//  Created by Djaka Permana on 07/08/23.
//

import Foundation
import Core
import RxSwift

public class FavoriteListRepository<
    FavoriteLocalDataSoruce: LocalDataSource,
    Transformer: LocalMapper
>: Repository where
    FavoriteLocalDataSoruce.Response == FavoriteEntityModel,
    FavoriteLocalDataSoruce.Request == Any,
    Transformer.Entity == FavoriteEntityModel,
    Transformer.Domain == FavoriteDomainModel {

    public typealias Request = String
    public typealias Response = [FavoriteDomainModel]
    
    private let localDataSource: FavoriteLocalDataSoruce
    private let mapper: Transformer
    
    public init(localDataSource: FavoriteLocalDataSoruce, mapper: Transformer) {
        self.localDataSource = localDataSource
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
