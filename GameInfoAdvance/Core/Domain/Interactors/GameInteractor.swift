//
//  GameInteractor.swift
//  GameInfoAdvance
//
//  Created by Djaka Permana on 05/07/23.
//

import Foundation
import RxSwift

class GameInteractor: GameUseCase {
    private let repository: GameInfoRepositoryProtocol
    
    init(repository: GameInfoRepositoryProtocol) {
        self.repository = repository
    }
    
    func getGames(page: Int, pageSize: Int, search: String) -> Observable<[GameModel]> {
        return repository.getGames(page: page, pageSize: pageSize, search: search)
    }
    
    func addFavoriteGame(_ gameModel: GameModel) -> Observable<Bool> {
        let gameEntity = GameInfoMapper.gameModelToEntity(gameModel)
        return repository.addFavoriteGame(gameEntity: gameEntity)
    }
    
    func removeFavoriteGame(with id: Int) -> Observable<Bool> {
        return repository.removeFavoriteGame(id: id)
    }
}
