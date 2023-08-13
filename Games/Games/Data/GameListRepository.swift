//
//  GameInfoRepository.swift
//  Games
//
//  Created by Djaka Permana on 05/08/23.
//

import Foundation
import RxSwift
import Core
import Favorite

public struct GameListRepository<
    GetListGameRemoteDataSource: RemoteDataSource,
    FavoriteLocalDataSoruce: LocalDataSource,
    Transformer: Mapper
>: Repository where
    GetListGameRemoteDataSource.Response == GamesResponse,
    GetListGameRemoteDataSource.Request == GameParameterRequest,
    FavoriteLocalDataSoruce.Response == FavoriteEntityModel,
    Transformer.Response == GameResponse,
    Transformer.Entity == GameEntityModel,
    Transformer.Domain == GameDomainModel
{
    
    public typealias Request = GameParameterRequest
    public typealias Response = [GameDomainModel]
    
    private let remoteDataSource: GetListGameRemoteDataSource
    private let localDataSource: FavoriteLocalDataSoruce
    private let mapper: Transformer
    
    public init(remoteDataSource: GetListGameRemoteDataSource, localDataSource: FavoriteLocalDataSoruce, mapper: Transformer) {
        self.remoteDataSource = remoteDataSource
        self.localDataSource = localDataSource
        self.mapper = mapper
    }
    
    public func execute(request: GameParameterRequest?) -> Observable<[GameDomainModel]> {
        
        Observable.combineLatest(
            remoteDataSource.execute(request: request).asObservable(),
            localDataSource.get(request: nil) .asObservable()
        )
        .map { (gamesResponse, gamesFavorite) -> [GameDomainModel] in
            return gamesResponse.results.map { gameResponse in
                var isFavorite = false
                if gamesFavorite.contains(where: {$0.id == gameResponse.id}) {
                    isFavorite = true
                }
                
                let response = GameResponse(
                    id: gameResponse.id ?? 0,
                    slug: gameResponse.slug ?? "",
                    name: gameResponse.name ?? "",
                    released: gameResponse.released ?? "",
                    backgroundImage: gameResponse.backgroundImage ?? "",
                    rating: gameResponse.rating ?? 0.0,
                    updated: gameResponse.updated ?? "",
                    parentPlatforms: gameResponse.parentPlatforms ?? [],
                    isFavorite: isFavorite
                )

                return mapper.transformResponseToDomain(response: response)
            }
        }
    }
}
