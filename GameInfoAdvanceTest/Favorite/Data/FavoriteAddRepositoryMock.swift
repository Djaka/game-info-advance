//
//  FavoriteAddRepositoryMock.swift
//  GameInfoAdvanceTest
//
//  Created by Djaka Permana on 27/08/23.
//

import Foundation
import Core
import Favorite
import RxSwift

public class FavoriteAddRepositoryMock<
    FavoriteLocalDataSourceMock: LocalDataSource,
    Transformer: LocalMapper
>: Repository where
    FavoriteLocalDataSourceMock.Response == FavoriteEntityModel,
    FavoriteLocalDataSourceMock.Request == Any,
    Transformer.Entity == FavoriteEntityModel,
    Transformer.Domain == FavoriteDomainModel {

    public typealias Request = FavoriteEntityModel
    public typealias Response = Bool
    
    private let localDataSource: FavoriteLocalDataSourceMock
    private let mapper: Transformer
    
    public init(localDataSourceMock: FavoriteLocalDataSourceMock, mapper: Transformer) {
        self.localDataSource = localDataSourceMock
        self.mapper = mapper
    }
    
    public func execute(request: FavoriteEntityModel?) -> Observable<Bool> {
        return localDataSource.add(entities: request!).asObservable()
    }
}
