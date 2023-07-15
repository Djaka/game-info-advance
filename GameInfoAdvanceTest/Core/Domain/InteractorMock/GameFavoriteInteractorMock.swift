//
//  GameFavoriteInteractorMock.swift
//  GameInfoAdvanceTest
//
//  Created by Djaka Permana on 15/07/23.
//

import Foundation
import RxSwift

@testable import GameInfoAdvance

class GameFavoriteInteractorMock: GameFavoriteUseCase {
    func getFavoriteGames() -> RxSwift.Observable<[GameInfoAdvance.GameFavoriteModel]> {
        return Observable<[GameFavoriteModel]>.create { observer in
            
            observer.onNext(gameFavoritesModelMock)
            return Disposables.create()
        }
    }
    
    func removeFavoriteGame(with id: Int) -> RxSwift.Observable<Bool> {
        return Observable<Bool>.create { observer in
            
            observer.onNext(true)
            return Disposables.create()
        }
    }
    
    func searchFavoriteGame(keywoard: String) -> RxSwift.Observable<[GameInfoAdvance.GameFavoriteModel]> {
        return Observable<[GameFavoriteModel]>.create { observer in
            
            observer.onNext(gameFavoritesModelMock)
            return Disposables.create()
        }
    }
    
    
}
