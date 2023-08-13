//
//  ProfileEditRepository.swift
//  Profile
//
//  Created by Djaka Permana on 13/08/23.
//

import Foundation
import Core
import RxSwift

public class ProfileEditRepository<
    ProfileLocalDataSource: LocalDataSource
> :Repository where
    ProfileLocalDataSource.Response == ProfileEntityModel,
    ProfileLocalDataSource.Request == Any
{
    
    public typealias Request = ProfileEntityModel
    public typealias Response = Bool
    
    private let localDataSource: ProfileLocalDataSource
    
    public init(localDataSource: ProfileLocalDataSource) {
        self.localDataSource = localDataSource
    }
    
    public func execute(request: ProfileEntityModel?) -> Observable<Bool> {
        localDataSource.update(request: request)
            .asObservable()
    }
}
