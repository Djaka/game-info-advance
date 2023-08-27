//
//  GameFavoriteRouter.swift
//  GameInfoAdvance
//
//  Created by Djaka Permana on 06/07/23.
//

import UIKit
import Core
import Favorite

class GameFavoriteRouter {
    static func createModule() -> UIViewController {
        let gameFavoriteUseCase: Interactor<String, [FavoriteDomainModel], FavoriteListRepository<FavoriteLocalDataSource, FavoritesTransformer>
        > = Injection.init().provideGameFavorite()
        
        let gameFavoriteRemoveUseCase: Interactor<Int, Bool, FavoriteRemoveRepository<FavoriteLocalDataSource, FavoritesTransformer>
        > = Injection.init().provideGameRemoveFavorite()
        
        let gameFavoriteViewModel = GameFavoriteViewModel(gameFavoriteUseCase: gameFavoriteUseCase, gameFavoriteRemoveUseCase: gameFavoriteRemoveUseCase)
        
        let viewController = GameFavoriteViewController(gameFavoriteViewModel: gameFavoriteViewModel)
        
        return viewController
    }
    
    func pushToDetail(with view: UIViewController, gameId: Int) {
        let detailViewController = GameDetailRouter.createModule(with: gameId)
        if let viewController = view as? GameFavoriteViewController {
            viewController.navigationController?.pushViewController(detailViewController, animated: true)
        }
    }
}
