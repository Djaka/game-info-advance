//
//  GameDetailTransformer.swift
//  Games
//
//  Created by Djaka Permana on 06/08/23.
//

import Foundation
import Core

public struct GameDetailTransformer: Mapper {
    public typealias Response = GameDetailResponse
    public typealias Entity = GameEntityModel
    public typealias Domain = GameDetailDomainModel
    
    public init() {
        
    }
    
    private func platformImages(_ parentPlatforms: [ParentPlatformResponse]?) -> [UIImageView] {
        
        var imageNames: [String] = []
        var imageViews: [UIImageView] = []
        
        if let parentPlatforms = parentPlatforms {
            for parentPlatform in parentPlatforms where !imageNames.contains(parentPlatform.platform?.imageName.rawValue ?? "") {
                let imageName = parentPlatform.platform?.imageName.rawValue ?? ""
                imageNames.append(imageName)
                
                let image = UIImage(systemName: imageName) ?? UIImage()
                let imageView = UIImageView(image: image)
                imageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
                imageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
                imageView.contentMode = .center
                imageView.tintColor = UIColor(hex: "#DFE6E9")
                imageViews.append(imageView)
            }
        }
        
        return imageViews
    }
    
    public func transformResponseToEntity(response: GameDetailResponse) -> GameEntityModel {
        fatalError()
    }
    
    public func transformEntityToDomain(entity: GameEntityModel) -> GameDetailDomainModel {
        fatalError()
    }
    
    public func transformResponseToDomain(response: GameDetailResponse) -> GameDetailDomainModel {
        let gameDetailDomainModel = GameDetailDomainModel(
            id: response.id,
            name: response.name,
            released: response.released,
            backgroundImage: response.backgroundImage,
            backgroundImageAdditional: response.backgroundImageAdditional,
            rating: response.rating,
            description: response.description,
            platformImages: platformImages(response.parentPlatforms),
            isFavorite: response.isFavorite
        )
        
        return gameDetailDomainModel
    }
    
    public func transformDomainToEntity(domain: GameDetailDomainModel) -> GameEntityModel {
        let gameEntityModel = GameEntityModel()
        gameEntityModel.id = domain.id ?? 0
        gameEntityModel.name = domain.name ?? ""
        gameEntityModel.released = domain.released ?? ""
        gameEntityModel.backgroundImage = domain.backgroundImage ?? ""
        gameEntityModel.rating = domain.rating ?? 0.0

        return gameEntityModel
    }
}
