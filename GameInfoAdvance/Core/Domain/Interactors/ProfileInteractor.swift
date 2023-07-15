//
//  ProfileInteractor.swift
//  GameInfoAdvance
//
//  Created by Djaka Permana on 09/07/23.
//

import Foundation
import RxSwift

class ProfileInteractor: ProfileUseCase {
    
    private var repository: GameInfoRepositoryProtocol
    
    init(repository: GameInfoRepositoryProtocol) {
        self.repository = repository
    }
    
    func getProfile() -> Observable<ProfileModel> {
        return repository.getProfile()
            .map { result in
                return ProfileModel(
                    author: result?.author ?? "",
                    email: result?.email ?? "",
                    currentJob: result?.currentJob ?? "",
                    description: result?.description ?? "",
                    authorImage: result?.authorImage ?? ""
                )
            }
    }
    
    func updateProfile(profileModel: ProfileModel) -> Observable<Bool> {
        return repository.updateProfile(profileModel: profileModel)
    }
}
