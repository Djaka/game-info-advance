//
//  GameInfoMapper.swift
//  GameInfoAdvance
//
//  Created by Djaka Permana on 05/07/23.
//

import UIKit

final class GameInfoMapper {
    static func platformImages(_ parentPlatforms: [ParentPlatformResponse]?) -> [UIImageView] {
        
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
    
    static func gameModelToEntity(_ gameModel: GameModel) -> GameEntity {
        let gameEntity = GameEntity()
        gameEntity.id = gameModel.id ?? 0
        gameEntity.name = gameModel.name ?? ""
        gameEntity.released = gameModel.released ?? ""
        gameEntity.backgroundImage = gameModel.backgroundImage ?? ""
        gameEntity.rating = gameModel.rating ?? 0.0
        
        return gameEntity
    }
    
    static func gameDetailModelToEntity(_ gameDetailModel: GameDetailModel) -> GameEntity {
        let gameEntity = GameEntity()
        gameEntity.id = gameDetailModel.id ?? 0
        gameEntity.name = gameDetailModel.name ?? ""
        gameEntity.released = gameDetailModel.released ?? ""
        gameEntity.backgroundImage = gameDetailModel.backgroundImage ?? ""
        gameEntity.rating = gameDetailModel.rating ?? 0.0
        
        return gameEntity
    }
    
    static func gameResponseToGameModel(_ gameResponse: GameResponse, _ isFavorite: Bool = false) -> GameModel {
        let gameModel = GameModel(
            id: gameResponse.id,
            name: gameResponse.name,
            released: gameResponse.released,
            backgroundImage: gameResponse.backgroundImage,
            rating: gameResponse.rating,
            isFavorite: isFavorite,
            platformImages: GameInfoMapper.platformImages(gameResponse.parentPlatforms)
        )
        
        return gameModel
    }
    
    static func gameDetailResponseToGameDetailModel(_ gameDetailResponse: GameDetailResponse, _ isFavorite: Bool = false) -> GameDetailModel {
        
        let gameDetailModel = GameDetailModel(
            id: gameDetailResponse.id,
            name: gameDetailResponse.name,
            released: gameDetailResponse.released,
            backgroundImage: gameDetailResponse.backgroundImage,
            backgroundImageAdditional: gameDetailResponse.backgroundImageAdditional,
            rating: gameDetailResponse.rating,
            description: gameDetailResponse.description,
            platformImages: GameInfoMapper.platformImages(gameDetailResponse.parentPlatforms),
            isFavorite: isFavorite
        )
        
        return gameDetailModel
    }
    
    static func gameEntityToGameFavoriteModel(_ gameEntity: GameEntity) -> GameFavoriteModel {
        let gameFavoriteModel = GameFavoriteModel(
            id: gameEntity.id,
            name: gameEntity.name,
            released: gameEntity.released,
            backgroundImage: gameEntity.backgroundImage,
            rating: gameEntity.rating,
            isFavorite: true
        )
        
        return gameFavoriteModel
    }
    
    static func profileToProfileModel(_ profile: Profile) -> ProfileModel {
        let profileModel = ProfileModel(
            author: profile.author,
            email: profile.email,
            currentJob: profile.currentJob,
            description: profile.description,
            authorImage: profile.authorImage
        )

        return profileModel
    }
    
    static func profileCacheModelToProfileModel(_ profileCacheModel: ProfileCacheModel?) -> ProfileModel {
        let profileModel = ProfileModel(
            author: profileCacheModel?.author ?? "",
            email: profileCacheModel?.email ?? "",
            currentJob: profileCacheModel?.currentJob ?? "",
            description: profileCacheModel?.description ?? "",
            authorImage: profileCacheModel?.authorImage ?? ""
        )

        return profileModel
    }
}
