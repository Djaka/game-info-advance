//
//  GameDetailRepository.swift
//  Games
//
//  Created by Djaka Permana on 06/08/23.
//

import Foundation
import RxSwift
import Core
import Favorite

public struct GameDetailRepository<
    GetDetailGameRemoteDataSoruce: RemoteDataSource,
    FavoriteLocalDataSoruce: LocalDataSource,
    Transformer: Mapper
>: Repository where
    GetDetailGameRemoteDataSoruce.Response == GameDetailResponse,
    GetDetailGameRemoteDataSoruce.Request == Int,
    FavoriteLocalDataSoruce.Response == FavoriteEntityModel,
    Transformer.Response == GameDetailResponse,
    Transformer.Entity == GameEntityModel,
    Transformer.Domain == GameDetailDomainModel
{
    
    public typealias Request = Int
    public typealias Response = GameDetailDomainModel
    
    private let remoteDataSource: GetDetailGameRemoteDataSoruce
    private let localeDataSource: FavoriteLocalDataSoruce
    private let mapper: Transformer
    
    public init(remoteDataSource: GetDetailGameRemoteDataSoruce, localeDataSource: FavoriteLocalDataSoruce, mapper: Transformer) {
        self.remoteDataSource = remoteDataSource
        self.localeDataSource = localeDataSource
        self.mapper = mapper
    }
    
    public func execute(request: Int?) -> Observable<GameDetailDomainModel> {
        Observable.combineLatest(
            remoteDataSource.execute(request: request).asObservable(),
            localeDataSource.get(request: nil).asObservable()
        )
        .map { (gameDetailResponse, gamesFavorite) in
            var isFavorite = false
            if gamesFavorite.contains(where: {$0.id == gameDetailResponse.id}) {
                isFavorite = true
            }
            
            let response = GameDetailResponse(
                id: gameDetailResponse.id ?? 0,
                slug: gameDetailResponse.slug ?? "",
                name: gameDetailResponse.name ?? "",
                nameOriginal: gameDetailResponse.nameOriginal ?? "",
                description: gameDetailResponse.description ?? "",
                released: gameDetailResponse.released ?? "",
                updated: gameDetailResponse.updated ?? "",
                backgroundImage: gameDetailResponse.backgroundImage ?? "",
                backgroundImageAdditional: gameDetailResponse.backgroundImageAdditional ?? "",
                website: gameDetailResponse.website ?? "",
                rating: gameDetailResponse.rating ?? 0.0,
                alternativeNames: gameDetailResponse.alternativeNames ?? [],
                reviewsCount: gameDetailResponse.reviewsCount ?? 0,
                parentPlatforms: gameDetailResponse.parentPlatforms ?? [],
                descriptionRaw: gameDetailResponse.descriptionRaw ?? "",
                isFavorite: isFavorite
            )
            
            return mapper.transformResponseToDomain(response: response)
        }
    }
}

