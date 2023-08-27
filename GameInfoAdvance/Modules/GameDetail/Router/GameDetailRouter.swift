//
//  GameDetailRouter.swift
//  GameInfoAdvance
//
//  Created by Djaka Permana on 07/07/23.
//

import UIKit
import Favorite
import Games
import Core

class GameDetailRouter {
    static func createModule(with id: Int) -> UIViewController {
        let gameDetailUseCase: Interactor<
            Int,
            GameDetailDomainModel,
            GameDetailRepository<
                GetDetailGameRemoteDataSoruce,
                GameDetailTransformer
            >
        > = Injection.init().provideGameDetail()
        
        let gameFavoriteRemoveUseCase: Interactor<Int,
                                                  Bool,
                                                  FavoriteRemoveRepository<FavoriteLocalDataSource,
                                                                           FavoritesTransformer>
        > = Injection.init().provideGameRemoveFavorite()
        
        let gameFavoriteAddUseCase: Interactor<FavoriteEntityModel,
                                               Bool,
                                               FavoriteAddRepository<FavoriteLocalDataSource,
                                                                     FavoritesTransformer>
        > = Injection.init().provideGameAddFavorite()
        
        let gameFavoriteUseCase: Interactor<String,
                                            [FavoriteDomainModel],
                                            FavoriteListRepository<FavoriteLocalDataSource,
                                                                   FavoritesTransformer>
        > = Injection.init().provideGameFavorite()
        
        let gameDetailViewModel = GameDetailViewModel(
            gameDetailUseCase: gameDetailUseCase,
            gameFavoriteRemoveUseCase: gameFavoriteRemoveUseCase,
            gameFavoriteAddUseCase: gameFavoriteAddUseCase,
            gameFavoriteUseCase: gameFavoriteUseCase, gameId: id
        )
        
        let viewController = GameDetailViewController(gameDetailViewModel: gameDetailViewModel)
        return viewController
    }

    func backToPreviousePage(with view: UIViewController) {
        if let viewController = view as? GameDetailViewController {
            viewController.navigationController?.popToRootViewController(animated: true)
        }
    }
}
