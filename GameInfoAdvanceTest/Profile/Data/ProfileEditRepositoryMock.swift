//
//  ProfileEditRepositoryMock.swift
//  GameInfoAdvanceTest
//
//  Created by Djaka Permana on 27/08/23.
//

import Foundation
import Core
import Profile
import RxSwift

public class ProfileEditRepositoryMock<
    ProfileLocalDataSourceMock: LocalDataSource
>: Repository where
    ProfileLocalDataSourceMock.Response == ProfileEntityModel,
    ProfileLocalDataSourceMock.Request == Any {
    
    public typealias Request = ProfileEntityModel
    public typealias Response = Bool
    
    private let localDataSource: ProfileLocalDataSourceMock
    
    public init(localDataSourceMock: ProfileLocalDataSourceMock) {
        self.localDataSource = localDataSourceMock
    }
    
    public func execute(request: ProfileEntityModel?) -> Observable<Bool> {
        localDataSource.update(request: request)
            .asObservable()
    }
}
