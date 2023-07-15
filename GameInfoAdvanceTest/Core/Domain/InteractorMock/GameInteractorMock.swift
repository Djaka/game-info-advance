//
//  GameInteractorMock.swift
//  GameInfoAdvanceTest
//
//  Created by Djaka Permana on 15/07/23.
//

import Foundation
import RxSwift

@testable import GameInfoAdvance

class GameInteractorMock: GameUseCase {
    func getGames(page: Int, pageSize: Int, search: String) -> Observable<[GameModel]> {
        return Observable<[GameModel]>.create { observer in
            
            observer.onNext(gameModels)
            return Disposables.create()
        }
    }
    
    func addFavoriteGame(_ gameModel: GameModel) -> Observable<Bool> {
        return Observable<Bool>.create { observer in
            
            observer.onNext(true)
            return Disposables.create()
        }
    }
    
    func removeFavoriteGame(with id: Int) -> Observable<Bool> {
        return Observable<Bool>.create { observer in
            
            observer.onNext(true)
            return Disposables.create()
        }
    }
}
