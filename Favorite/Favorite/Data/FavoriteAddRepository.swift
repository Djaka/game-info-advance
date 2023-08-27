//
//  FavoriteAddRepository.swift
//  Favorite
//
//  Created by Djaka Permana on 12/08/23.
//

import Foundation
import Core
import RxSwift

public class FavoriteAddRepository<
    FavoriteLocalDataSource: LocalDataSource,
    Transformer: LocalMapper
>: Repository where
    FavoriteLocalDataSource.Response == FavoriteEntityModel,
    FavoriteLocalDataSource.Request == Any,
    Transformer.Entity == FavoriteEntityModel,
    Transformer.Domain == FavoriteDomainModel {

    public typealias Request = FavoriteEntityModel
    public typealias Response = Bool
    
    private let localDataSource: FavoriteLocalDataSource
    private let mapper: Transformer
    
    public init(localDataSource: FavoriteLocalDataSource, mapper: Transformer) {
        self.localDataSource = localDataSource
        self.mapper = mapper
    }
    
    public func execute(request: FavoriteEntityModel?) -> Observable<Bool> {
        return localDataSource.add(entities: request!).asObservable()
    }
}
