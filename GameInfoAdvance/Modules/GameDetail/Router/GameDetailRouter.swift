//
//  GameDetailRouter.swift
//  GameInfoAdvance
//
//  Created by Djaka Permana on 07/07/23.
//

import UIKit

class GameDetailRouter {
    static func createModule(with id: Int) -> UIViewController {
        let gameDetailUseCase = Injection.init().provideGameDetail()
        let viewModel = GameDetailViewModel(gameDetailUseCase: gameDetailUseCase, gameId: id)
        let viewController = GameDetailViewController(gameDetailViewModel: viewModel)
        return viewController
    }

    func backToPreviousePage(with view: UIViewController) {
        let viewController = view as! GameDetailViewController
        viewController.navigationController?.popToRootViewController(animated: true)
    }
}
