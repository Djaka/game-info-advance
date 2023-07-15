//
//  ProfileUseCase.swift
//  GameInfoAdvance
//
//  Created by Djaka Permana on 09/07/23.
//

import Foundation
import RxSwift

protocol ProfileUseCase {
    func getProfile() -> Observable<ProfileModel>
    func updateProfile(profileModel: ProfileModel) -> Observable<Bool>
}
