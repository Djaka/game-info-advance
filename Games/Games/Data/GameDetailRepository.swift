//
//  GameDetailRepository.swift
//  Games
//
//  Created by Djaka Permana on 06/08/23.
//

import Foundation
import RxSwift
import Core

public struct GameDetailRepository<
    GetDetailGameRemoteDataSoruce: RemoteDataSource,
    Transformer: RemoteMapper
>: Repository where
    GetDetailGameRemoteDataSoruce.Response == GameDetailResponse,
    GetDetailGameRemoteDataSoruce.Request == Int,
    Transformer.Response == GameDetailResponse,
    Transformer.Domain == GameDetailDomainModel {
    
    public typealias Request = Int
    public typealias Response = GameDetailDomainModel
    
    private let remoteDataSource: GetDetailGameRemoteDataSoruce
    private let mapper: Transformer
    
    public init(remoteDataSource: GetDetailGameRemoteDataSoruce, mapper: Transformer) {
        self.remoteDataSource = remoteDataSource
        self.mapper = mapper
    }
    
    public func execute(request: Int?) -> Observable<GameDetailDomainModel> {
        remoteDataSource.execute(request: request).asObservable()
            .map { gameDetailResponse in
                return mapper.transformResponseToDomain(response: gameDetailResponse)
            }
    }
}
