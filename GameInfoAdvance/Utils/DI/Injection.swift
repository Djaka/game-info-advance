//
//  Injextion.swift
//  GameInfoAdvance
//
//  Created by Djaka Permana on 05/07/23.
//

import Foundation
import RealmSwift
import Core
import Games
import Favorite
import Profile

public class Injection {
    
    private let realm = try? Realm()
    
    func provideGames<U: UseCase>() -> U where U.Request == GameParameterRequest, U.Response == [GameDomainModel] {
        let remote = GetListGameRemoteDataSource(url: APIConstants.sharedInstance.baseURL, apiKey: APIConstants.sharedInstance.apiKey)
        let mapper = GamesTransformer()
        let repository = GameListRepository(remoteDataSource: remote, mapper: mapper)
        
        guard let interactor = Interactor(repository: repository) as? U else {
            fatalError("Check Injection")
        }
        return interactor
    }
    
    func provideGameDetail<U: UseCase>() -> U where U.Request == Int, U.Response == GameDetailDomainModel {
        let remote = GetDetailGameRemoteDataSoruce(url: APIConstants.sharedInstance.baseURL, apiKey: APIConstants.sharedInstance.apiKey)
        let mapper = GameDetailTransformer()
        let repository = GameDetailRepository(remoteDataSource: remote, mapper: mapper)
        
        guard let interactor = Interactor(repository: repository) as? U else {
            fatalError("Check Injection")
        }
        return interactor
    }

    func provideGameFavorite<U: UseCase>() -> U where U.Request == String, U.Response == [FavoriteDomainModel] {
        let local = FavoriteLocalDataSource(realm: realm)
        let mapper = FavoritesTransformer()
        let repository = FavoriteListRepository(localDataSource: local, mapper: mapper)
        
        guard let interactor = Interactor(repository: repository) as? U else {
            fatalError("Check Injection")
        }
        
        return interactor
    }
    
    func provideGameRemoveFavorite<U: UseCase>() -> U where U.Request == Int, U.Response == Bool {
        let local = FavoriteLocalDataSource(realm: realm)
        let mapper = FavoritesTransformer()
        let repository = FavoriteRemoveRepository(localDataSource: local, mapper: mapper)
        
        guard let interactor = Interactor(repository: repository) as? U else {
            fatalError("Check Injection")
        }
        
        return interactor
    }
    
    func provideGameAddFavorite<U: UseCase>() -> U where U.Request == FavoriteEntityModel, U.Response == Bool {
        let local = FavoriteLocalDataSource(realm: realm)
        let mapper = FavoritesTransformer()
        let repository = FavoriteAddRepository(localDataSource: local, mapper: mapper)
        
        guard let interactor = Interactor(repository: repository) as? U else {
            fatalError("Check Injection")
        }
        
        return interactor
    }

    func provideProfile<U: UseCase>() -> U where U.Request == Any, U.Response == ProfileDomainModel {
        let remote = ProfileRemoteDataSource()
        let local = ProfileLocalDataSource(realm: realm)
        let mapper = ProfileTransformer()
        let repository = ProfileRepository(remoteDataSource: remote, localDataSource: local, mapper: mapper)
        
        guard let interactor = Interactor(repository: repository) as? U else {
            fatalError("Check Injection")
        }
        
        return interactor
    }
    
    func provideEditProfile<U: UseCase>() -> U where U.Request == ProfileEntityModel, U.Response == Bool {
        let local = ProfileLocalDataSource(realm: realm)
        let repository = ProfileEditRepository(localDataSource: local)
        
        guard let interactor = Interactor(repository: repository) as? U else {
            fatalError("Check Injection")
        }
        
        return interactor
    }
}
