//
//  FavoriteRemoveRepository.swift
//  GameInfoAdvanceTest
//
//  Created by Djaka Permana on 27/08/23.
//

import Foundation
import Core
import Favorite
import RxSwift

public class FavoriteRemoveRepositoryMock<
    FavoriteLocalDataSourceMock: LocalDataSource,
    Transformer: LocalMapper
>: Repository where
    FavoriteLocalDataSourceMock.Response == FavoriteEntityModel,
    FavoriteLocalDataSourceMock.Request == Any,
    Transformer.Entity == FavoriteEntityModel,
    Transformer.Domain == FavoriteDomainModel {

    public typealias Request = Int
    public typealias Response = Bool
    
    private let localDataSource: FavoriteLocalDataSourceMock
    private let mapper: Transformer
    
    public init(localDataSourceMock: FavoriteLocalDataSourceMock, mapper: Transformer) {
        self.localDataSource = localDataSourceMock
        self.mapper = mapper
    }
    
    public func execute(request: Int?) -> Observable<Bool> {
        return localDataSource.delete(request: request ?? 0).asObservable()
    }
}
