//
//  GameFavoriteViewModel.swift
//  GameInfoAdvance
//
//  Created by Djaka Permana on 06/07/23.
//

import Foundation
import RxSwift
import RxCocoa
import Core
import Favorite

public class GameFavoriteViewModel {
    
    private var gameFavoriteUseCase: GetViewModel<String,
                                                  [FavoriteDomainModel],
                                                  Interactor<String,
                                                             [FavoriteDomainModel],
                                                             FavoriteListRepository<
                                                                FavoriteLocalDataSource,
                                                                FavoritesTransformer>
                                                  >
    >
    
    private var gameFavoriteRemoveUseCase: GetViewModel<Int,
                                                  Bool,
                                                  Interactor<Int,
                                                             Bool,
                                                             FavoriteRemoveRepository<
                                                                FavoriteLocalDataSource,
                                                                FavoritesTransformer>
                                                  >
    >
    
    var loadingStateObservable: Observable<Bool> {
        loadingState.asObservable()
    }
    
    var reloadGameFavoriteObservable: Observable<Void> {
        reloadGameFavorite.asObservable()
    }
    
    var errorObservable: Observable<String> {
        error.asObserver()
    }
    
    var successUnFavoritedObservable: Observable<(Bool, FavoriteDomainModel, IndexPath)> {
        successUnFavorited.asObservable()
    }
    
    var showFavoritesEmptyObservable: Observable<Bool> {
        showFavoritesEmpty.asObservable().map { show in
            return !show
        }
    }
    
    private let loadingState = BehaviorRelay<Bool>(value: true)
    private let reloadGameFavorite = PublishSubject<Void>()
    private let error = PublishSubject<String>()
    private let successUnFavorited = PublishSubject<(Bool, FavoriteDomainModel, IndexPath)>()
    private let showFavoritesEmpty = BehaviorRelay<Bool>(value: false)
    
    private let disposeBag = DisposeBag()
    
    private var favorites: [FavoriteDomainModel] = []
    
    init(gameFavoriteUseCase: Interactor<String, [FavoriteDomainModel], FavoriteListRepository<FavoriteLocalDataSource, FavoritesTransformer>>,
         gameFavoriteRemoveUseCase: Interactor<Int, Bool, FavoriteRemoveRepository<FavoriteLocalDataSource, FavoritesTransformer>>
    ) {
        self.gameFavoriteUseCase = GetViewModel(useCase: gameFavoriteUseCase)
        self.gameFavoriteRemoveUseCase = GetViewModel(useCase: gameFavoriteRemoveUseCase)
    }
    
    func getFavorites(keywoard: String = "") {
        self.loadingState.accept(true)
        
        gameFavoriteUseCase.getViewModel(request: keywoard)
            .observe(on: MainScheduler.instance)
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
    
    func removeFavoriteGame(with gameFavoriteModel: FavoriteDomainModel, indexPath: IndexPath) {
        gameFavoriteRemoveUseCase.getViewModel(request: gameFavoriteModel.id ?? 0)
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
    
    func getFavoriteGame(by index: Int) -> FavoriteDomainModel {
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
