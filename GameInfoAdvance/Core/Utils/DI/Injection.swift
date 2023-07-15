//
//  Injextion.swift
//  GameInfoAdvance
//
//  Created by Djaka Permana on 05/07/23.
//

import Foundation
import RealmSwift

final class Injection {
    
    private func provideRepository() -> GameInfoRepositoryProtocol {
        let realm = try? Realm()
        
        let remote: RemoteDataSource = RemoteDataSource.sharedInstance
        let local: LocalDataSource = LocalDataSource.sharedInstance(realm)
        
        return GameInfoRepository.sharedInstance(remote, local)
    }
    
    func provideGames() -> GameUseCase {
        let repository = provideRepository()
        return GameInteractor(repository: repository)
    }
    
    func provideGameDetail() -> GameDetailUseCase {
        let repository = provideRepository()
        return GameDetailInteractor(repository: repository)
    }
    
    func provideGameFavorite() -> GameFavoriteUseCase {
        let repository = provideRepository()
        return GameFavoriteInteractor(repository: repository)
    }
    
    func provideProfile() -> ProfileUseCase {
        let repository = provideRepository()
        return ProfileInteractor(repository: repository)
    }
}
