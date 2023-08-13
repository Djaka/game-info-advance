//
//  ProfileTransformer.swift
//  Profile
//
//  Created by Djaka Permana on 13/08/23.
//

import Foundation
import Core

public class ProfileTransformer: Mapper {
    
    public typealias Response = Profile
    public typealias Entity = ProfileEntityModel
    public typealias Domain = ProfileDomainModel
    
    public init() {
        
    }

    public func transformResponseToEntity(response: Profile) -> ProfileEntityModel {
        let profileEntityModel = ProfileEntityModel()
        profileEntityModel.id = response.userId ?? 0
        profileEntityModel.author = response.author ?? ""
        profileEntityModel.authorImage = response.authorImage ?? ""
        profileEntityModel.currentJob = response.currentJob ?? ""
        profileEntityModel.contents = response.description ?? ""
        profileEntityModel.email = response.email ?? ""
        return profileEntityModel
    }
    
    public func transformEntityToDomain(entity: ProfileEntityModel) -> ProfileDomainModel {
        let profileDomainModel = ProfileDomainModel()
        profileDomainModel.id = entity.id
        profileDomainModel.author = entity.author
        profileDomainModel.authorImage = entity.authorImage
        profileDomainModel.currentJob = entity.currentJob
        profileDomainModel.description = entity.contents
        profileDomainModel.email = entity.email
        
        return profileDomainModel
    }
    
    public func transformResponseToDomain(response: Profile) -> ProfileDomainModel {
        fatalError()
    }
    
    public func transformDomainToEntity(domain: ProfileDomainModel) -> ProfileEntityModel {
        fatalError()
    }
}
