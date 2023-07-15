//
//  GameFavoriteInteractor.swift
//  GameInfoAdvance
//
//  Created by Djaka Permana on 05/07/23.
//

import Foundation
import RxSwift

class GameFavoriteInteractor: GameFavoriteUseCase {
    private let repository: GameInfoRepositoryProtocol
    
    init(repository: GameInfoRepositoryProtocol) {
        self.repository = repository
    }
    
    func getFavoriteGames() -> Observable<[GameFavoriteModel]> {
        return repository.getFavoriteGames()
    }
    
    func removeFavoriteGame(with id: Int) -> Observable<Bool> {
        return repository.removeFavoriteGame(id: id)
    }
    
    func searchFavoriteGame(keywoard: String) -> Observable<[GameFavoriteModel]> {
        return repository.searchGameFavorite(keywoard: keywoard)
    }
    
}
