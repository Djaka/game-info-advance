//
//  FavoriteRemoveRepository.swift
//  Favorite
//
//  Created by Djaka Permana on 12/08/23.
//

import Foundation
import Core
import RxSwift

public class FavoriteRemoveRepository<
    FavoriteLocalDataSource: LocalDataSource,
    Transformer: LocalMapper
>: Repository where
    FavoriteLocalDataSource.Response == FavoriteEntityModel,
    FavoriteLocalDataSource.Request == Any,
    Transformer.Entity == FavoriteEntityModel,
    Transformer.Domain == FavoriteDomainModel {

    public typealias Request = Int
    public typealias Response = Bool
    
    private let localDataSource: FavoriteLocalDataSource
    private let mapper: Transformer
    
    public init(localDataSource: FavoriteLocalDataSource, mapper: Transformer) {
        self.localDataSource = localDataSource
        self.mapper = mapper
    }
    
    public func execute(request: Int?) -> Observable<Bool> {
        return localDataSource.delete(request: request ?? 0).asObservable()
    }
}
