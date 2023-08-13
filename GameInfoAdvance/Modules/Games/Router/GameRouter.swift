//
//  GameRouter.swift
//  GameInfoAdvance
//
//  Created by Djaka Permana on 05/07/23.
//

import UIKit
import Core
import Games
import Favorite

class GameRouter {
    static func createModule() -> UIViewController {
        let gameUseCase: Interactor<GameParameterRequest, [GameDomainModel], GameListRepository<GetListGameRemoteDataSource, FavoriteLocalDataSoruce, GamesTransformer>
        > = Injection.init().provideGames()
        
        let gameFavoriteRemoveUseCase: Interactor<Int, Bool, FavoriteRemoveRepository<FavoriteLocalDataSoruce, FavoritesTransformer>
        > = Injection.init().provideGameRemoveFavorite()
        
        let gameFavoriteAddUseCase: Interactor<FavoriteEntityModel, Bool, FavoriteAddRepository<FavoriteLocalDataSoruce, FavoritesTransformer>
        > = Injection.init().provideGameAddFavorite()
        
        let gameViewModel = GameViewModel(gameUseCase: gameUseCase, gameFavoriteRemoveUseCase: gameFavoriteRemoveUseCase, gameFavoriteAddUseCase: gameFavoriteAddUseCase)
        
        let viewController = GameViewController(gameViewModel: gameViewModel)
        return viewController
    }
    
    func pushToDetail(with view: UIViewController, gameId: Int) {
        let detailViewController = GameDetailRouter.createModule(with: gameId)
        let viewController = view as! GameViewController
        viewController.navigationController?.pushViewController(detailViewController, animated: true)
    }
}
