//
//  ProfileViewModel.swift
//  GameInfoAdvance
//
//  Created by Djaka Permana on 09/07/23.
//

import Foundation
import RxSwift
import RxCocoa
import Core
import Profile

class ProfileViewModel {
    
    var profileObservable: Observable<ProfileDomainModel?> {
        profile.asObservable()
    }
    
    var errorObservable: Observable<Error> {
        error.asObservable()
    }
    
    private let profile = BehaviorRelay<ProfileDomainModel?>(value: nil)
    private let error = PublishSubject<Error>()
    
    private var profileUseCase: GetViewModel<Any, ProfileDomainModel, Interactor<Any, ProfileDomainModel, ProfileRepository<ProfileRemoteDataSource, ProfileLocalDataSource, ProfileTransformer>>>
    
    private var disposeBag = DisposeBag()
    
    init(profileUseCase: Interactor<Any, ProfileDomainModel, ProfileRepository<ProfileRemoteDataSource, ProfileLocalDataSource, ProfileTransformer>>
    ) {
        self.profileUseCase = GetViewModel(useCase: profileUseCase)
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
}
