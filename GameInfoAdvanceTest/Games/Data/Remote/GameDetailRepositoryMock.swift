//
//  GameDetailRepositoryMock.swift
//  GameInfoAdvanceTest
//
//  Created by Djaka Permana on 27/08/23.
//

import Foundation
import RxSwift
import Core
import Games

public struct GameDetailRepositoryMock<
    GetDetailGameRemoteDataSourceMock: RemoteDataSource,
    Transformer: RemoteMapper
>: Repository where
    GetDetailGameRemoteDataSourceMock.Response == GameDetailResponse,
    GetDetailGameRemoteDataSourceMock.Request == Int,
    Transformer.Response == GameDetailResponse,
    Transformer.Domain == GameDetailDomainModel {
    
    public typealias Request = Int
    public typealias Response = GameDetailDomainModel
    
    private let remoteDataSource: GetDetailGameRemoteDataSourceMock
    private let mapper: Transformer
    
    public init(remoteDataSourceMock: GetDetailGameRemoteDataSourceMock, mapper: Transformer) {
        self.remoteDataSource = remoteDataSourceMock
        self.mapper = mapper
    }
    
    public func execute(request: Int?) -> Observable<GameDetailDomainModel> {
        remoteDataSource.execute(request: request).asObservable()
            .map { gameDetailResponse in
                return mapper.transformResponseToDomain(response: gameDetailResponse)
            }
    }
}
