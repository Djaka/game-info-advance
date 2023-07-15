//
//  EditProfileViewModel.swift
//  GameInfoAdvance
//
//  Created by Djaka Permana on 09/07/23.
//

import Foundation
import RxSwift
import RxCocoa

class EditProfileViewModel {
    
    var profileObservable: Observable<ProfileModel?> {
        profile.asObservable()
    }
    
    var errorObservable: Observable<Error> {
        error.asObservable()
    }
    
    var isSuccessObservable: Observable<Bool> {
        isSuccess.asObserver()
    }
    
    private let profile = BehaviorRelay<ProfileModel?>(value: nil)
    private let error = PublishSubject<Error>()
    private let isSuccess = PublishSubject<Bool>()
    
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
    
    func updateProfile(profileModel: ProfileModel) {
        profileUseCase.updateProfile(profileModel: profileModel)
            .subscribe(onNext: { success in
                self.isSuccess.onNext(success)
            }
            , onError: { error in
                self.error.onNext(error)
            })
            .disposed(by: disposeBag)
    }
}
