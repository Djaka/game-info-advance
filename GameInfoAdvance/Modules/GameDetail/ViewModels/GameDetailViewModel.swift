//
//  GameViewModel.swift
//  GameInfoAdvance
//
//  Created by Djaka Permana on 07/07/23.
//

import Foundation
import RxSwift
import RxRelay
import Core
import Games
import Favorite

class GameDetailViewModel {
    
    var loadingStateObservable: Observable<Bool> {
        loadingState.asObservable()
    }
    
    var errorObservable: Observable<String> {
        error.asObserver()
    }
    
    var successFavoritedObservable: Observable<(Bool, GameDetailDomainModel)> {
        successFavorited.asObservable()
    }
    
    var successUnFavoritedObservable: Observable<(Bool, GameDetailDomainModel)> {
        successUnFavorited.asObservable()
    }
    
    var gameDetailObservable: Observable<GameDetailDomainModel?> {
        gameDetail.asObservable()
    }
    
    private var gameDetailUseCase: GetViewModel<Int,
                                        GameDetailDomainModel,
                                        Interactor<Int,
                                                   GameDetailDomainModel,
                                                   GameDetailRepository<
                                                        GetDetailGameRemoteDataSoruce,
                                                        GameDetailTransformer>>>
    
    private var gameFavoriteRemoveUseCase: GetViewModel<Int,
                                                  Bool,
                                                  Interactor<Int,
                                                             Bool,
                                                             FavoriteRemoveRepository<
                                                                FavoriteLocalDataSoruce,
                                                                FavoritesTransformer>>>
    
    private var gameFavoriteAddUseCase: GetViewModel<FavoriteEntityModel,
                                                  Bool,
                                                  Interactor<FavoriteEntityModel,
                                                             Bool,
                                                             FavoriteAddRepository<
                                                                FavoriteLocalDataSoruce,
                                                                FavoritesTransformer>>>
    
    private var gameFavoriteUseCase: GetViewModel<String,
                                                  [FavoriteDomainModel],
                                                  Interactor<String,
                                                             [FavoriteDomainModel],
                                                             FavoriteListRepository<
                                                                FavoriteLocalDataSoruce,
                                                                FavoritesTransformer>
                                                  >
    >
    
    private var gameId: Int
    private let loadGameDetail = PublishSubject<Void>()
    private let loadingState = BehaviorRelay<Bool>(value: true)
    private let error = PublishSubject<String>()
    private let successFavorited = PublishSubject<(Bool, GameDetailDomainModel)>()
    private let successUnFavorited = PublishSubject<(Bool, GameDetailDomainModel)>()
    private let gameDetail = BehaviorRelay<GameDetailDomainModel?>(value: nil)
    
    private var disposeBag = DisposeBag()
    
    init(gameDetailUseCase: Interactor<Int, GameDetailDomainModel, GameDetailRepository<GetDetailGameRemoteDataSoruce, GameDetailTransformer>>,
         gameFavoriteRemoveUseCase: Interactor<Int, Bool, FavoriteRemoveRepository<FavoriteLocalDataSoruce, FavoritesTransformer>>,
         gameFavoriteAddUseCase: Interactor<FavoriteEntityModel, Bool, FavoriteAddRepository<FavoriteLocalDataSoruce, FavoritesTransformer>>,
         gameFavoriteUseCase: Interactor<String, [FavoriteDomainModel], FavoriteListRepository<FavoriteLocalDataSoruce, FavoritesTransformer>>,
         gameId: Int) {
        
        self.gameDetailUseCase = GetViewModel(useCase: gameDetailUseCase)
        self.gameFavoriteAddUseCase = GetViewModel(useCase: gameFavoriteAddUseCase)
        self.gameFavoriteRemoveUseCase = GetViewModel(useCase: gameFavoriteRemoveUseCase)
        self.gameFavoriteUseCase = GetViewModel(useCase: gameFavoriteUseCase)
        self.gameId = gameId
    }
    
    func getGameDetail() {
        Observable.combineLatest(
            gameDetailUseCase.getViewModel(request: gameId).asObservable(),
            gameFavoriteUseCase.getViewModel(request: nil).asObservable()
        ).map { (gameModel, gameFavorites) -> GameDetailDomainModel in
            var isFavorite = false
            if gameFavorites.contains(where: {$0.id == gameModel.id}) {
                isFavorite = true
            }

            let gameDetailDomainModel = GameDetailDomainModel(
                id: gameModel.id ?? 0,
                slug: gameModel.slug ?? "",
                name: gameModel.name ?? "",
                released: gameModel.released ?? "",
                backgroundImage: gameModel.backgroundImage ?? "",
                backgroundImageAdditional: gameModel.backgroundImageAdditional ?? "",
                rating: gameModel.rating ?? 0.0,
                description: gameModel.description ?? "",
                platformImages: gameModel.platformImages ?? [],
                isFavorite: isFavorite
            )
            return gameDetailDomainModel
        }.observe(on: MainScheduler.instance)
            .subscribe(onNext: { gameDetailModel in
                self.gameDetail.accept(gameDetailModel)
            }, onError: { error in
                self.error.onNext(error.localizedDescription)
            }, onCompleted: {
                self.loadingState.accept(false)
            })
            .disposed(by: disposeBag)
    }
    
    func addToFavoriteGame(with gameDetailModel: GameDetailDomainModel) {
        let favoriteEntityModel = FavoriteEntityModel()
        favoriteEntityModel.id = gameDetailModel.id ?? 0
        favoriteEntityModel.slug = gameDetailModel.slug ?? ""
        favoriteEntityModel.name = gameDetailModel.name ?? ""
        favoriteEntityModel.released = gameDetailModel.released ?? ""
        favoriteEntityModel.backgroundImage = gameDetailModel.backgroundImage ?? ""
        favoriteEntityModel.rating = gameDetailModel.rating ?? 0.0
        
        gameFavoriteAddUseCase.getViewModel(request: favoriteEntityModel)
            .subscribe(onNext: { success in
                self.successFavorited.onNext((success, gameDetailModel))
            })
            .disposed(by: disposeBag)
            
    }
    
    func removeFavoriteGame(with gameDetailModel: GameDetailDomainModel) {
        gameFavoriteRemoveUseCase.getViewModel(request: gameDetailModel.id ?? 0)
            .subscribe(onNext: { success in
                self.successUnFavorited.onNext((success, gameDetailModel))
            })
            .disposed(by: disposeBag)
    }
    
}
