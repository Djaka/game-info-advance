//
//  GameRouter.swift
//  GameInfoAdvance
//
//  Created by Djaka Permana on 05/07/23.
//

import UIKit

class GameRouter {
    static func createModule() -> UIViewController {
        let gameUseCase = Injection.init().provideGames()
        let gameViewModel = GameViewModel(gameUseCase: gameUseCase)
        let viewController = GameViewController(gameViewModel: gameViewModel)
        return viewController
    }
    
    func pushToDetail(with view: UIViewController, gameId: Int) {
        let detailViewController = GameDetailRouter.createModule(with: gameId)
        let viewController = view as! GameViewController
        viewController.navigationController?.pushViewController(detailViewController, animated: true)
    }
}
