//
//  EditProfileRouter.swift
//  GameInfoAdvance
//
//  Created by Djaka Permana on 09/07/23.
//

import UIKit

class EditProfileRouter {
    static func createModule() -> UIViewController {
        let profileUseCase = Injection.init().provideProfile()
        let viewModel = EditProfileViewModel(profileUseCase: profileUseCase)
        let viewController = EditProfileViewController(editProfileViewModel: viewModel)
        return viewController
    }
    
    func backToPreviousePage(with view: UIViewController) {
        let viewController = view as! EditProfileViewController
        viewController.navigationController?.popToRootViewController(animated: true)
    }
}
