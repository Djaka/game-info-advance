//
//  GameDetailInteractor.swift
//  GameInfoAdvance
//
//  Created by Djaka Permana on 05/07/23.
//

import Foundation
import RxSwift

class GameDetailInteractor: GameDetailUseCase {
    private var repository: GameInfoRepositoryProtocol
    
    init(repository: GameInfoRepositoryProtocol) {
        self.repository = repository
    }
    
    func getGameDetail(with id: Int) -> Observable<GameDetailModel> {
        return repository.getGameDetail(with: id)
    }
    
    func addFavoriteGame(_ gameDetailModel: GameDetailModel) -> Observable<Bool> {
        let gameEntity = GameInfoMapper.gameDetailModelToEntity(gameDetailModel)
        return repository.addFavoriteGame(gameEntity: gameEntity)
    }
    
    func removeFavoriteGame(with id: Int) -> Observable<Bool> {
        return repository.removeFavoriteGame(id: id)
    }
    
}
