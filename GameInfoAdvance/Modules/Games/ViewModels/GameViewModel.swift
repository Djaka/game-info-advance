//
//  GameViewModel.swift
//  GameInfoAdvance
//
//  Created by Djaka Permana on 05/07/23.
//

import Foundation
import RxSwift
import RxRelay

class GameViewModel {
    
    var loadingStateObservable: Observable<Bool> {
        loadingState.asObservable()
    }
    
    var reloadGamesObservable: Observable<Void> {
        reloadGames.asObservable()
    }
    
    var errorObservable: Observable<String> {
        error.asObserver()
    }
    
    var loadingFooterObservable: Observable<Bool> {
        loadingFooter.asObservable()
    }
    
    var successFavoritedObservable: Observable<(Bool, GameModel)> {
        successFavorited.asObservable()
    }
    
    var successUnFavoritedObservable: Observable<(Bool, GameModel)> {
        successUnFavorited.asObservable()
    }
    
    private var gameUseCase: GameUseCase
    
    private let loadingState = BehaviorRelay<Bool>(value: true)
    private let reloadGames = PublishSubject<Void>()
    private let error = PublishSubject<String>()
    private let loadingFooter = BehaviorRelay<Bool>(value: false)
    private let successFavorited = PublishSubject<(Bool, GameModel)>()
    private let successUnFavorited = PublishSubject<(Bool, GameModel)>()
    private var games: [GameModel] = []
    
    private var isLoading = false
    private var page = 1
    private var pageSize = 10
    private var keywoard = ""
    
    private var disposeBag = DisposeBag()
    
    init(gameUseCase: GameUseCase) {
        self.gameUseCase = gameUseCase
    }
    
    private func getGames(page: Int, pageSize: Int, search: String = "") {
        gameUseCase.getGames(page: page, pageSize: pageSize, search: search)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { games in
                let myGames = self.games + games
                self.games = myGames
                self.reloadGames.onNext(())
            }, onError: { error in
                self.error.onNext(error.localizedDescription)
            }, onCompleted: {
                self.loadingState.accept(false)
                self.loadingFooter.accept(false)
            })
            .disposed(by: disposeBag)
    }
    
    func loadMoreData() {
        if !self.loadingFooter.value {
            self.loadingFooter.accept(true)
            
            self.page += 1
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
                self.getGames(page: self.page, pageSize: self.pageSize, search: self.keywoard)
            })
        }
    }
    
    func refreshPage() {
        self.games = []
        self.reloadGames.onNext(())
        self.loadingState.accept(true)
        self.loadingFooter.accept(false)
        self.keywoard = ""
        self.page = 1
        self.getGames(page: page, pageSize: self.pageSize)
    }
    
    func searchGame(_ kewoard : String) {
        self.games = []
        self.loadingState.accept(true)
        self.loadingFooter.accept(false)
        self.keywoard = kewoard
        self.page = 1
        self.getGames(page: self.page, pageSize: self.pageSize, search: self.keywoard)
    }
    
    func addToFavoriteGame(with gameModel: GameModel) {
        gameUseCase.addFavoriteGame(gameModel)
            .subscribe(onNext: { success in
                self.games.first(where: { $0.id == gameModel.id })?.isFavorite = true
                self.successFavorited.onNext((success, gameModel))
            })
            .disposed(by: disposeBag)
            
    }
    
    func removeFavoriteGame(with gameModel: GameModel) {
        gameUseCase.removeFavoriteGame(with: gameModel.id ?? 0)
            .subscribe(onNext: { success in
                self.games.first(where: { $0.id == gameModel.id })?.isFavorite = false
                self.successUnFavorited.onNext((success, gameModel))
            })
            .disposed(by: disposeBag)
    }
    
    func numberOfRowItem() -> Int {
        return games.count
    }
    
    func getGame(by index: Int) -> GameModel {
        return games[index]
    }
}
