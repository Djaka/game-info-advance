//
//  GameViewModel.swift
//  GameInfoAdvance
//
//  Created by Djaka Permana on 05/07/23.
//

import Foundation
import RxSwift
import RxRelay
import Core
import Games
import Favorite

public class GameViewModel {
    private var gameUseCase: GetViewModel<GameParameterRequest,
                                        [GameDomainModel],
                                        Interactor<GameParameterRequest,
                                                   [GameDomainModel],
                                                   GameListRepository<
                                                        GetListGameRemoteDataSource,
                                                        GamesTransformer>
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
    
    private var gameFavoriteAddUseCase: GetViewModel<FavoriteEntityModel,
                                                  Bool,
                                                  Interactor<FavoriteEntityModel,
                                                             Bool,
                                                             FavoriteAddRepository<
                                                                FavoriteLocalDataSource,
                                                                FavoritesTransformer>
                                                  >
    >
    
    private var gameFavoriteUseCase: GetViewModel<String,
                                                  [FavoriteDomainModel],
                                                  Interactor<String,
                                                             [FavoriteDomainModel],
                                                             FavoriteListRepository<
                                                                FavoriteLocalDataSource,
                                                                FavoritesTransformer>
                                                  >
    >
    
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
    
    var successFavoritedObservable: Observable<(Bool, GameDomainModel)> {
        successFavorited.asObservable()
    }
    
    var successUnFavoritedObservable: Observable<(Bool, GameDomainModel)> {
        successUnFavorited.asObservable()
    }
    
    private let loadingState = BehaviorRelay<Bool>(value: true)
    private let reloadGames = PublishSubject<Void>()
    private let error = PublishSubject<String>()
    private let loadingFooter = BehaviorRelay<Bool>(value: false)
    private let successFavorited = PublishSubject<(Bool, GameDomainModel)>()
    private let successUnFavorited = PublishSubject<(Bool, GameDomainModel)>()
    private var games: [GameDomainModel] = []
    
    private var isLoading = false
    private var page = 1
    private var pageSize = 10
    private var keywoard = ""
    private var favoriteTransformer: FavoritesTransformer
    
    private var disposeBag = DisposeBag()
    
    init(gameUseCase: Interactor<GameParameterRequest, [GameDomainModel], GameListRepository<GetListGameRemoteDataSource, GamesTransformer>>,
         gameFavoriteRemoveUseCase: Interactor<Int, Bool, FavoriteRemoveRepository<FavoriteLocalDataSource, FavoritesTransformer>>,
         gameFavoriteAddUseCase: Interactor<FavoriteEntityModel, Bool, FavoriteAddRepository<FavoriteLocalDataSource, FavoritesTransformer>>,
         gameFavoriteUseCase: Interactor<String, [FavoriteDomainModel], FavoriteListRepository<FavoriteLocalDataSource, FavoritesTransformer>>,
         favoriteTransformer: FavoritesTransformer = FavoritesTransformer()
    ) {
        self.gameUseCase = GetViewModel(useCase: gameUseCase)
        self.gameFavoriteRemoveUseCase = GetViewModel(useCase: gameFavoriteRemoveUseCase)
        self.gameFavoriteAddUseCase = GetViewModel(useCase: gameFavoriteAddUseCase)
        self.gameFavoriteUseCase = GetViewModel(useCase: gameFavoriteUseCase)
        self.favoriteTransformer = favoriteTransformer
    }
    
    private func getGames(page: Int, pageSize: Int, search: String = "") {
        let params = GameParameterRequest(page: page, pageSize: pageSize, search: search)
        
        Observable.combineLatest(gameFavoriteUseCase.getViewModel(request: nil).asObservable(), gameUseCase.getViewModel(request: params).asObservable())
            .map { (favorites, games) -> [GameDomainModel] in
                
                return games.map { gameResponse in
                    var isFavorite = false
                    if favorites.contains(where: {$0.id == gameResponse.id}) {
                        isFavorite = true
                    }
                    
                    let domainModel = GameDomainModel(
                        id: gameResponse.id ?? 0,
                        slug: gameResponse.slug ?? "",
                        name: gameResponse.name ?? "",
                        released: gameResponse.released ?? "",
                        backgroundImage: gameResponse.backgroundImage ?? "",
                        rating: gameResponse.rating ?? 0.0,
                        isFavorite: isFavorite,
                        platformImages: gameResponse.platformImages ?? []
                    )
                    
                    return domainModel
                }
            }
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
    
    func searchGame(_ kewoard: String) {
        self.games = []
        self.loadingState.accept(true)
        self.loadingFooter.accept(false)
        self.keywoard = kewoard
        self.page = 1
        self.getGames(page: self.page, pageSize: self.pageSize, search: self.keywoard)
    }
    
    func addToFavoriteGame(with gameModel: GameDomainModel) {
        
        let favoriteEntityModel = FavoriteEntityModel()
        favoriteEntityModel.id = gameModel.id ?? 0
        favoriteEntityModel.slug = gameModel.slug ?? ""
        favoriteEntityModel.name = gameModel.name ?? ""
        favoriteEntityModel.released = gameModel.released ?? ""
        favoriteEntityModel.backgroundImage = gameModel.backgroundImage ?? ""
        favoriteEntityModel.rating = gameModel.rating ?? 0.0
        
        gameFavoriteAddUseCase.getViewModel(request: favoriteEntityModel)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { success in
                self.games.first(where: { $0.id == gameModel.id })?.isFavorite = true
                self.successFavorited.onNext((success, gameModel))
            })
            .disposed(by: disposeBag)
            
    }
    
    func removeFavoriteGame(with gameModel: GameDomainModel) {
        gameFavoriteRemoveUseCase.getViewModel(request: gameModel.id ?? 0).subscribe(onNext: { success in
                self.games.first(where: { $0.id == gameModel.id })?.isFavorite = false
                self.successUnFavorited.onNext((success, gameModel))
            })
            .disposed(by: disposeBag)
    }
    
    func numberOfRowItem() -> Int {
        return games.count
    }
    
    func getGame(by index: Int) -> GameDomainModel {
        return games[index]
    }
}
