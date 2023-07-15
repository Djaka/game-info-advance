//
//  GameFavoriteRouter.swift
//  GameInfoAdvance
//
//  Created by Djaka Permana on 06/07/23.
//

import UIKit

class GameFavoriteRouter {
    static func createModule() -> UIViewController {
        let gameFavoriteUseCase = Injection.init().provideGameFavorite()
        let gameFavoriteViewModel = GameFavoriteViewModel(gameFavoriteUseCase: gameFavoriteUseCase)
        let viewController = GameFavoriteViewController(gameFavoriteViewModel: gameFavoriteViewModel)
        return viewController
    }
    
    func pushToDetail(with view: UIViewController, gameId: Int) {
        let detailViewController = GameDetailRouter.createModule(with: gameId)
        let viewController = view as! GameFavoriteViewController
        viewController.navigationController?.pushViewController(detailViewController, animated: true)
    }
}
