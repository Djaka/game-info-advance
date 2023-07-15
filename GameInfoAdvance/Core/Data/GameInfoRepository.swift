//
//  GameInfoRepository.swift
//  GameInfoAdvance
//
//  Created by Djaka Permana on 03/07/23.
//

import Foundation
import RxSwift

protocol GameInfoRepositoryProtocol {
    func getGames(page: Int, pageSize: Int, search: String) -> Observable<[GameModel]>
    func getGameDetail(with id: Int) -> Observable<GameDetailModel>
    func getFavoriteGames() -> Observable<[GameFavoriteModel]>
    func addFavoriteGame(gameEntity: GameEntity) -> Observable<Bool>
    func removeFavoriteGame(id: Int) -> Observable<Bool>
    func searchGameFavorite(keywoard: String) -> Observable<[GameFavoriteModel]>
    func getProfile() -> Observable<ProfileModel?>
    func updateProfile(profileModel: ProfileModel) -> Observable<Bool>
}

class GameInfoRepository: GameInfoRepositoryProtocol {
    
    typealias RecipesInstance = (RemoteDataSource, LocalDataSource) -> GameInfoRepository
    
    fileprivate let remote: RemoteDataSource
    fileprivate let local: LocalDataSource
    
    private init(remote: RemoteDataSource, local: LocalDataSource) {
        self.remote = remote
        self.local = local
    }
    
    static let sharedInstance: RecipesInstance = { remoteRepository, localRepository in
        return GameInfoRepository(remote: remoteRepository, local: localRepository)
    }
    
    func getGames(page: Int, pageSize: Int, search: String) -> Observable<[GameModel]> {
        
        Observable.combineLatest(remote.getGames(page: page, pageSize: pageSize, search: search).asObservable(), local.getFavoriteGames().asObservable())
            .map { (gamesResponse, gamesFavorite) -> [GameModel] in

                return gamesResponse.results.map { gameResponse in
                    var isFavorite = false
                    if gamesFavorite.contains(where: {$0.id == gameResponse.id}) {
                        isFavorite = true
                    }
                    return GameInfoMapper.gameResponseToGameModel(gameResponse, isFavorite)
                }
            }
    }
    
    func getGameDetail(with id: Int) -> Observable<GameDetailModel> {
        Observable.combineLatest(self.remote.getGamesDetail(with: id).asObservable(), local.getFavoriteGames().asObservable())
            .map { (gameDetailResponse, gamesFavorite) in
                var isFavorite = false
                if gamesFavorite.contains(where: {$0.id == gameDetailResponse.id}) {
                    isFavorite = true
                }
                return GameInfoMapper.gameDetailResponseToGameDetailModel(gameDetailResponse, isFavorite)
            }
    }
    
    func getFavoriteGames() -> Observable<[GameFavoriteModel]> {
        return local.getFavoriteGames().asObservable()
            .map { gameEntities in
                return gameEntities.map {
                    GameInfoMapper.gameEntityToGameFavoriteModel($0)
                }
            }
    }
    
    func addFavoriteGame(gameEntity: GameEntity) -> Observable<Bool> {
        return local.addFavoriteGame(from: gameEntity)
    }
    
    func removeFavoriteGame(id: Int) -> Observable<Bool> {
        return local.deleteFavoriteGame(by: id)
    }
    
    func searchGameFavorite(keywoard: String) -> Observable<[GameFavoriteModel]> {
        return local.getFavoriteGame(keywoard: keywoard).asObservable()
            .map { gameEntities in
                return gameEntities.map {
                    GameInfoMapper.gameEntityToGameFavoriteModel($0)
                }
            }
    }
    
    func getProfile() -> Observable<ProfileModel?> {
        return local.getProfile()
            .filter{
                $0 != nil
            }
            .ifEmpty(
                switchTo: self.remote.getProfile()
                    .map {
                        GameInfoMapper.profileToProfileModel($0)
                    }
                    .flatMap { profileModel in
                        self.local.updateProfile(from: profileModel)
                    }.filter {
                        $0
                    }
                    .flatMap { _ in
                        return self.local.getProfile()
                    }
            )
            .map { cacheModel in
                return GameInfoMapper.profileCacheModelToProfileModel(cacheModel)
            }
    }
    
    func updateProfile(profileModel: ProfileModel) -> Observable<Bool> {
        return local.updateProfile(from: profileModel)
    }
    
}
