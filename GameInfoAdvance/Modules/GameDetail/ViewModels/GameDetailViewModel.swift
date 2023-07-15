//
//  GameViewModel.swift
//  GameInfoAdvance
//
//  Created by Djaka Permana on 07/07/23.
//

import Foundation
import RxSwift
import RxRelay

class GameDetailViewModel {
    
    var loadingStateObservable: Observable<Bool> {
        loadingState.asObservable()
    }
    
    var errorObservable: Observable<String> {
        error.asObserver()
    }
    
    var successFavoritedObservable: Observable<(Bool, GameDetailModel)> {
        successFavorited.asObservable()
    }
    
    var successUnFavoritedObservable: Observable<(Bool, GameDetailModel)> {
        successUnFavorited.asObservable()
    }
    
    var gameDetailObservable: Observable<GameDetailModel?> {
        gameDetail.asObservable()
    }
    
    private var gameDetailUseCase: GameDetailUseCase
    private var gameId: Int
    private let loadGameDetail = PublishSubject<Void>()
    private let loadingState = BehaviorRelay<Bool>(value: true)
    private let error = PublishSubject<String>()
    private let successFavorited = PublishSubject<(Bool, GameDetailModel)>()
    private let successUnFavorited = PublishSubject<(Bool, GameDetailModel)>()
    private let gameDetail = BehaviorRelay<GameDetailModel?>(value: nil)
    
    private var disposeBag = DisposeBag()
    
    init(gameDetailUseCase: GameDetailUseCase, gameId: Int) {
        self.gameDetailUseCase = gameDetailUseCase
        self.gameId = gameId
    }
    
    func getGameDetail() {
        gameDetailUseCase.getGameDetail(with: gameId)
            .subscribe(onNext: { gameDetailModel in
                self.gameDetail.accept(gameDetailModel)
            }, onError: { error in
                self.error.onNext(error.localizedDescription)
            }, onCompleted: {
                self.loadingState.accept(false)
            })
            .disposed(by: disposeBag)
    }
    
    func addToFavoriteGame(with gameDetailModel: GameDetailModel) {
        gameDetailUseCase.addFavoriteGame(gameDetailModel)
            .subscribe(onNext: { success in
                self.successFavorited.onNext((success, gameDetailModel))
            })
            .disposed(by: disposeBag)
            
    }
    
    func removeFavoriteGame(with gameDetailModel: GameDetailModel) {
        gameDetailUseCase.removeFavoriteGame(with: gameDetailModel.id ?? 0)
            .subscribe(onNext: { success in
                self.successUnFavorited.onNext((success, gameDetailModel))
            })
            .disposed(by: disposeBag)
    }
    
}
