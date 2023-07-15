//
//  ProfileRouter.swift
//  GameInfoAdvance
//
//  Created by Djaka Permana on 09/07/23.
//

import UIKit

class ProfileRouter {
    static func createModule() -> UIViewController {
        let profileUseCase = Injection.init().provideProfile()
        let viewModel = ProfileViewModel(profileUseCase: profileUseCase)
        let viewController = ProfileViewController(profileViewModel: viewModel)
        return viewController
    }
    
    func pushToEditProfile(with view: UIViewController) {
        let editProfileViewController = EditProfileRouter.createModule()
        let viewController = view as! ProfileViewController
        viewController.navigationController?.pushViewController(editProfileViewController, animated: true)
    }
}
