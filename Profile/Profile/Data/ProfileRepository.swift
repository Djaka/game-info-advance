//
//  ProfileRepository.swift
//  Profile
//
//  Created by Djaka Permana on 13/08/23.
//

import Foundation
import Core
import RxSwift

public class ProfileRepository<
    ProfileRemoteDataSource: RemoteDataSource,
    ProfileLocalDataSource: LocalDataSource,
    Transformer: Mapper
> :Repository where
    ProfileRemoteDataSource.Response == Profile,
    ProfileRemoteDataSource.Request == Any,
    ProfileLocalDataSource.Response == ProfileEntityModel,
    ProfileLocalDataSource.Request == Any,
    Transformer.Domain == ProfileDomainModel,
    Transformer.Entity == ProfileEntityModel,
    Transformer.Response == Profile
{
    
    public typealias Request = Any
    public typealias Response = ProfileDomainModel
    
    private let remoteDataSource: ProfileRemoteDataSource
    private let localDataSource: ProfileLocalDataSource
    private let mapper: Transformer
    
    public init(remoteDataSource: ProfileRemoteDataSource, localDataSource: ProfileLocalDataSource, mapper: Transformer) {
        self.remoteDataSource = remoteDataSource
        self.localDataSource = localDataSource
        self.mapper = mapper
    }
    
    public func execute(request: Request?) -> Observable<ProfileDomainModel> {
        return localDataSource.get(request: nil)
            .filter {
                $0.count > 0
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
