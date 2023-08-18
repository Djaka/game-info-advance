//
//  GameInfoRepository.swift
//  Games
//
//  Created by Djaka Permana on 05/08/23.
//

import Foundation
import RxSwift
import Core

public struct GameListRepository<
    GetListGameRemoteDataSource: RemoteDataSource,
    Transformer: RemoteMapper
>: Repository where
    GetListGameRemoteDataSource.Response == GamesResponse,
    GetListGameRemoteDataSource.Request == GameParameterRequest,
    Transformer.Response == GameResponse,
    Transformer.Domain == GameDomainModel {
    
    public typealias Request = GameParameterRequest
    public typealias Response = [GameDomainModel]
    
    private let remoteDataSource: GetListGameRemoteDataSource
    private let mapper: Transformer
    
    public init(remoteDataSource: GetListGameRemoteDataSource, mapper: Transformer) {
        self.remoteDataSource = remoteDataSource
        self.mapper = mapper
    }
    
    public func execute(request: GameParameterRequest?) -> Observable<[GameDomainModel]> {
        remoteDataSource.execute(request: request).asObservable()
            .map { gamesResponse -> [GameDomainModel] in
                return gamesResponse.results.map { gameResponse in
                    return mapper.transformResponseToDomain(response: gameResponse)
                }
            }
    }
}
