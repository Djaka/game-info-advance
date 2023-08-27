//
//  Injection.swift
//  GameInfoAdvanceTest
//
//  Created by Djaka Permana on 27/08/23.
//

import Foundation
import Core
import GameInfoAdvance
import Games
import Favorite
import Profile

extension Injection {
    
    func provideGamesMock<U: UseCase>() -> U where U.Request == GameParameterRequest, U.Response == [GameDomainModel] {
        let remote = GetListGameRemoteDataSourceMock()
        let mapper = GamesTransformer()
        let repository = GameListRepositoryMock(remoteDataSourceMock: remote, mapper: mapper)
        
        guard let interactor = Interactor(repository: repository) as? U else {
            fatalError("Check Injection")
        }
        return interactor
    }
    
    func provideGameDetailMock<U: UseCase>() -> U where U.Request == Int, U.Response == GameDetailDomainModel {
        let remote = GetDetailGameRemoteDataSourceMock()
        let mapper = GameDetailTransformer()
        let repository = GameDetailRepositoryMock(remoteDataSourceMock: remote, mapper: mapper)
        
        guard let interactor = Interactor(repository: repository) as? U else {
            fatalError("Check Injection")
        }
        return interactor
    }
    
    func provideGameFavoriteListMock<U: UseCase>() -> U where U.Request == String, U.Response == [FavoriteDomainModel] {
        let local = FavoriteLocalDataSourceMock()
        let mapper = FavoritesTransformer()
        let repository = FavoriteListRepositoryMock(localDataSourceMock: local, mapper: mapper)
        
        guard let interactor = Interactor(repository: repository) as? U else {
            fatalError("Check Injection")
        }
        
        return interactor
    }
    
    func provideGameAddFavoriteMock<U: UseCase>() -> U where U.Request == FavoriteEntityModel, U.Response == Bool {
        let local = FavoriteLocalDataSourceMock()
        let mapper = FavoritesTransformer()
        let repository = FavoriteAddRepositoryMock(localDataSourceMock: local, mapper: mapper)
        
        guard let interactor = Interactor(repository: repository) as? U else {
            fatalError("Check Injection")
        }
        
        return interactor
    }
    
    func provideGameRemoveFavoriteMock<U: UseCase>() -> U where U.Request == Int, U.Response == Bool {
        let local = FavoriteLocalDataSourceMock()
        let mapper = FavoritesTransformer()
        let repository = FavoriteRemoveRepositoryMock(localDataSourceMock: local, mapper: mapper)
        
        guard let interactor = Interactor(repository: repository) as? U else {
            fatalError("Check Injection")
        }
        
        return interactor
    }
    
    func provideProfileMock<U: UseCase>() -> U where U.Request == Any, U.Response == ProfileDomainModel {
        let remote = ProfileRemoteDataSourceMock()
        let local = ProfileLocalDataSourceMock()
        let mapper = ProfileTransformer()
        let repository = ProfileRepositoryMock(remoteDataSourceMock: remote, localDataSourceMock: local, mapper: mapper)
        
        guard let interactor = Interactor(repository: repository) as? U else {
            fatalError("Check Injection")
        }
        
        return interactor
    }
    
    func provideEditProfileMock<U: UseCase>() -> U where U.Request == ProfileEntityModel, U.Response == Bool {
        let local = ProfileLocalDataSourceMock()
        let repository = ProfileEditRepositoryMock(localDataSourceMock: local)
        
        guard let interactor = Interactor(repository: repository) as? U else {
            fatalError("Check Injection")
        }
        
        return interactor
    }
    
}
