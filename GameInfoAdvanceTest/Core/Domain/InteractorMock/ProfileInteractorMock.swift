//
//  ProfileInteractorMock.swift
//  GameInfoAdvanceTest
//
//  Created by Djaka Permana on 15/07/23.
//

import Foundation
import RxSwift

@testable import GameInfoAdvance

class ProfileInteractorMock: ProfileUseCase {
    func getProfile() -> Observable<ProfileModel> {
        return Observable<ProfileModel>.create { observer in
            observer.onNext(profileModelMock)
            return Disposables.create()
        }
    }
    
    func updateProfile(profileModel: ProfileModel) -> Observable<Bool> {
        return Observable<Bool>.create { observer in
            observer.onNext(true)
            return Disposables.create()
        }
    }
}
