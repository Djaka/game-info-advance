//
//  ProfileViewModel.swift
//  GameInfoAdvance
//
//  Created by Djaka Permana on 09/07/23.
//

import Foundation
import RxSwift
import RxCocoa

class ProfileViewModel {
    
    var profileObservable: Observable<ProfileModel?> {
        profile.asObservable()
    }
    
    var errorObservable: Observable<Error> {
        error.asObservable()
    }
    
    private let profile = BehaviorRelay<ProfileModel?>(value: nil)
    private let error = PublishSubject<Error>()
    
    private var profileUseCase: ProfileUseCase
    private var disposeBag = DisposeBag()
    
    init(profileUseCase: ProfileUseCase) {
        self.profileUseCase = profileUseCase
    }
    
    func getProfile() {
        profileUseCase.getProfile()
            .subscribe(onNext: { profile in
                self.profile.accept(profile)
            }
            , onError: { error in
                self.error.onNext(error)
            })
            .disposed(by: disposeBag)
    }
}
