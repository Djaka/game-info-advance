//
//  EditProfileViewModel.swift
//  GameInfoAdvance
//
//  Created by Djaka Permana on 09/07/23.
//

import Foundation
import RxSwift
import RxCocoa
import Core
import Profile

class EditProfileViewModel {
    
    var profileObservable: Observable<ProfileDomainModel?> {
        profile.asObservable()
    }
    
    var errorObservable: Observable<Error> {
        error.asObservable()
    }
    
    var isSuccessObservable: Observable<Bool> {
        isSuccess.asObserver()
    }
    
    private let profile = BehaviorRelay<ProfileDomainModel?>(value: nil)
    private let error = PublishSubject<Error>()
    private let isSuccess = PublishSubject<Bool>()
    
    private var profileUseCase: GetViewModel<Any, ProfileDomainModel, Interactor<Any, ProfileDomainModel, ProfileRepository<ProfileRemoteDataSource, ProfileLocalDataSource, ProfileTransformer>>>
    private var profileEditUseCase: GetViewModel<ProfileEntityModel, Bool, Interactor<ProfileEntityModel, Bool, ProfileEditRepository<ProfileLocalDataSource>>>
    private var disposeBag = DisposeBag()
    
    init(profileUseCase: Interactor<Any, ProfileDomainModel, ProfileRepository<ProfileRemoteDataSource, ProfileLocalDataSource, ProfileTransformer>>,
         profileEditUseCase: Interactor<ProfileEntityModel, Bool, ProfileEditRepository<ProfileLocalDataSource>>) {
        self.profileUseCase = GetViewModel(useCase: profileUseCase)
        self.profileEditUseCase = GetViewModel(useCase: profileEditUseCase)
    }
    
    func getProfile() {
        profileUseCase.getViewModel(request: nil)
            .subscribe(onNext: { profile in
                self.profile.accept(profile)
            }
            , onError: { error in
                self.error.onNext(error)
            })
            .disposed(by: disposeBag)
    }
    
    func updateProfile(profileModel: ProfileDomainModel) {
        let profileEntityModel = ProfileEntityModel()
        profileEntityModel.id = profileModel.id ?? 0
        profileEntityModel.author = profileModel.author ?? ""
        profileEntityModel.authorImage = profileModel.authorImage ?? ""
        profileEntityModel.currentJob = profileModel.currentJob ?? ""
        profileEntityModel.email = profileModel.email ?? ""
        profileEntityModel.contents = profileModel.description ?? ""
        
        profileEditUseCase.getViewModel(request: profileEntityModel)
            .subscribe(onNext: { success in
                self.isSuccess.onNext(success)
            }
            , onError: { error in
                self.error.onNext(error)
            })
            .disposed(by: disposeBag)
    }
}
