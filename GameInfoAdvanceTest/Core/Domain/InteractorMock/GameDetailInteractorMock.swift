//
//  GameDetailInteractorMock.swift
//  GameInfoAdvanceTest
//
//  Created by Djaka Permana on 15/07/23.
//

import Foundation
import RxSwift

@testable import GameInfoAdvance

class GameDetailInteracotrMock: GameDetailUseCase {
    func getGameDetail(with id: Int) -> RxSwift.Observable<GameDetailModel> {
        
        return Observable<GameDetailModel>.create { observer in
            observer.onNext(gameDetailModelMock)
            return Disposables.create()
        }
    }
    
    func addFavoriteGame(_ gameDetailModel: GameDetailModel) -> RxSwift.Observable<Bool> {
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
