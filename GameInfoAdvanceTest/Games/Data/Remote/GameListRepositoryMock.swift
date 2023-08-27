//
//  GameListRepositoryMock.swift
//  GameInfoAdvanceTest
//
//  Created by Djaka Permana on 27/08/23.
//

import Foundation
import RxSwift
import Core
import Games

public struct GameListRepositoryMock<
    GetListGameRemoteDataSourceMock: RemoteDataSource,
    Transformer: RemoteMapper
>: Repository where
    GetListGameRemoteDataSourceMock.Response == GamesResponse,
    GetListGameRemoteDataSourceMock.Request == GameParameterRequest,
    Transformer.Response == GameResponse,
    Transformer.Domain == GameDomainModel {
    
    public typealias Request = GameParameterRequest
    public typealias Response = [GameDomainModel]
    
    private let remoteDataSource: GetListGameRemoteDataSourceMock
    private let mapper: Transformer
    
    public init(remoteDataSourceMock: GetListGameRemoteDataSourceMock, mapper: Transformer) {
        self.remoteDataSource = remoteDataSourceMock
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
