//
//  GameFavoriteViewModel.swift
//  GameInfoAdvance
//
//  Created by Djaka Permana on 06/07/23.
//

import Foundation
import RxSwift
import RxCocoa

class GameFavoriteViewModel {
    
    var loadingStateObservable: Observable<Bool> {
        loadingState.asObservable()
    }
    
    var reloadGameFavoriteObservable: Observable<Void> {
        reloadGameFavorite.asObservable()
    }
    
    var errorObservable: Observable<String> {
        error.asObserver()
    }
    
    var successUnFavoritedObservable: Observable<(Bool, GameFavoriteModel, IndexPath)> {
        successUnFavorited.asObservable()
    }
    
    var showFavoritesEmptyObservable: Observable<Bool> {
        showFavoritesEmpty.asObservable().map{ show in
            return !show
        }
    }
    
    private let loadingState = BehaviorRelay<Bool>(value: true)
    private let reloadGameFavorite = PublishSubject<Void>()
    private let error = PublishSubject<String>()
    private let successUnFavorited = PublishSubject<(Bool, GameFavoriteModel, IndexPath)>()
    private let showFavoritesEmpty = BehaviorRelay<Bool>(value: false)
    
    private let disposeBag = DisposeBag()
    
    private var favorites: [GameFavoriteModel] = []
    
    private var gameFavoriteUseCase: GameFavoriteUseCase
    
    init(gameFavoriteUseCase: GameFavoriteUseCase) {
        self.gameFavoriteUseCase = gameFavoriteUseCase
    }
    
    private func getFavorites() {
        gameFavoriteUseCase.getFavoriteGames()
            .delay(.milliseconds(500), scheduler: MainScheduler.instance)
            .subscribe(onNext: { result in
                self.favorites = result
                self.reloadGameFavorite.onNext(())
                self.showFavoritesEmpty.accept(result.isEmpty)
            }, onError: {error in
                self.error.onNext(error.localizedDescription)
            }, onCompleted: {
                self.loadingState.accept(false)
            })
            .disposed(by: disposeBag)
    }
    
    private func getFavorites(with keywoard: String) {
        gameFavoriteUseCase.searchFavoriteGame(keywoard: keywoard)
            .delay(.milliseconds(500), scheduler: MainScheduler.instance)
            .subscribe(onNext: { result in
                self.favorites = result
                self.reloadGameFavorite.onNext(())
                self.showFavoritesEmpty.accept(result.isEmpty)
            }, onError: {error in
                self.error.onNext(error.localizedDescription)
            }, onCompleted: {
                self.loadingState.accept(false)
            })
            .disposed(by: disposeBag)
    }
    
    func searchFavoriteGame(keywoard: String) {
        self.loadingState.accept(true)
        if keywoard.isEmpty {
            getFavorites()
        } else {
            getFavorites(with: keywoard)
        }
    }
    
    func removeFavoriteGame(with gameFavoriteModel: GameFavoriteModel, indexPath: IndexPath) {
        gameFavoriteUseCase.removeFavoriteGame(with: gameFavoriteModel.id ?? 0)
            .subscribe(onNext: { success in
                self.favorites.remove(at: indexPath.row)
                self.successUnFavorited.onNext((success, gameFavoriteModel, indexPath))
                self.showFavoritesEmpty.accept(self.favorites.isEmpty)
            })
            .disposed(by: disposeBag)
    }
    
    func numberOfRowItem() -> Int {
        return favorites.count
    }
    
    func getFavoriteGame(by index: Int) -> GameFavoriteModel {
        return favorites[index]
    }
    
    func refreshPage() {
        self.favorites = []
        self.showFavoritesEmpty.accept(false)
        self.reloadGameFavorite.onNext(())
        self.loadingState.accept(true)
        getFavorites()
    }
}
