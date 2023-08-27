//
//  ProfileRepositoryMock.swift
//  GameInfoAdvanceTest
//
//  Created by Djaka Permana on 27/08/23.
//

import Foundation
import Core
import Profile
import RxSwift

public class ProfileRepositoryMock<
    ProfileRemoteDataSourceMock: RemoteDataSource,
    ProfileLocalDataSourceMock: LocalDataSource,
    Transformer: Mapper
>: Repository where
    ProfileRemoteDataSourceMock.Response == Profile,
    ProfileRemoteDataSourceMock.Request == Any,
    ProfileLocalDataSourceMock.Response == ProfileEntityModel,
    ProfileLocalDataSourceMock.Request == Any,
    Transformer.Domain == ProfileDomainModel,
    Transformer.Entity == ProfileEntityModel,
    Transformer.Response == Profile {
    
    public typealias Request = Any
    public typealias Response = ProfileDomainModel
    
    private let remoteDataSource: ProfileRemoteDataSourceMock
    private let localDataSource: ProfileLocalDataSourceMock
    private let mapper: Transformer
    
    public init(remoteDataSourceMock: ProfileRemoteDataSourceMock, localDataSourceMock: ProfileLocalDataSourceMock, mapper: Transformer) {
        self.remoteDataSource = remoteDataSourceMock
        self.localDataSource = localDataSourceMock
        self.mapper = mapper
    }
    
    public func execute(request: Request?) -> Observable<ProfileDomainModel> {
        return localDataSource.get(request: nil)
            .filter {
                !$0.isEmpty
            }
            .ifEmpty(
                switchTo: self.remoteDataSource.execute(request: nil)
                    .map {
                        self.mapper.transformResponseToEntity(response: $0)
                    }
                    .flatMap { profileEntity in
                        self.localDataSource.add(entities: profileEntity)
                    }
                    .filter {
                        $0
                    }
                    .flatMap { _ in
                        self.localDataSource.get(request: nil)
                    }
            )
            .map { profilesEntity in
                return self.mapper.transformEntityToDomain(entity: profilesEntity[0])
            }
    }
}
