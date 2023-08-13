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
        let gameDetailUseCase: Interactor<Int, GameDetailDomainModel, GameDetailRepository<GetDetailGameRemoteDataSoruce, FavoriteLocalDataSoruce, GameDetailTransformer>
        > = Injection.init().provideGameDetail()
        
        let gameFavoriteRemoveUseCase: Interactor<Int, Bool, FavoriteRemoveRepository<FavoriteLocalDataSoruce, FavoritesTransformer>
        > = Injection.init().provideGameRemoveFavorite()
        
        let gameFavoriteAddUseCase: Interactor<FavoriteEntityModel, Bool, FavoriteAddRepository<FavoriteLocalDataSoruce, FavoritesTransformer>
        > = Injection.init().provideGameAddFavorite()
        
        let gameDetailViewModel = GameDetailViewModel(gameDetailUseCase: gameDetailUseCase, gameFavoriteRemoveUseCase: gameFavoriteRemoveUseCase, gameFavoriteAddUseCase: gameFavoriteAddUseCase, gameId: id)
        let viewController = GameDetailViewController(gameDetailViewModel: gameDetailViewModel)
        return viewController
    }

    func backToPreviousePage(with view: UIViewController) {
        let viewController = view as! GameDetailViewController
        viewController.navigationController?.popToRootViewController(animated: true)
    }
}
