//
//  EditProfileRouter.swift
//  GameInfoAdvance
//
//  Created by Djaka Permana on 09/07/23.
//

import UIKit
import Core
import Profile

class EditProfileRouter {
    static func createModule() -> UIViewController {
        
        let profileUseCase: Interactor<Any, ProfileDomainModel, ProfileRepository<ProfileRemoteDataSource, ProfileLocalDataSource, ProfileTransformer>
        > = Injection.init().provideProfile()
        
        let profileEditUseCase: Interactor<ProfileEntityModel, Bool, ProfileEditRepository<ProfileLocalDataSource>
        > = Injection.init().provideEditProfile()

        let viewModel = EditProfileViewModel(profileUseCase: profileUseCase, profileEditUseCase: profileEditUseCase)
        let viewController = EditProfileViewController(editProfileViewModel: viewModel)
        return viewController
    }
//
    func backToPreviousePage(with view: UIViewController) {
        let viewController = view as! EditProfileViewController
        viewController.navigationController?.popToRootViewController(animated: true)
    }
}
