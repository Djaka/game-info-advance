//
//  GamesTransformer.swift
//  Games
//
//  Created by Djaka Permana on 05/08/23.
//

import Foundation
import Core
import UIKit
import Common

public struct GamesTransformer: RemoteMapper {
    public typealias Response = GameResponse
    public typealias Domain = GameDomainModel
    
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
    
    public func transformResponseToDomain(response: GameResponse) -> GameDomainModel {
        let gameDomainModel = GameDomainModel(
            id: response.id,
            slug: response.slug,
            name: response.name,
            released: response.released,
            backgroundImage: response.backgroundImage,
            rating: response.rating,
            isFavorite: response.isFavorite,
            platformImages: platformImages(response.parentPlatforms)
        )
        
        return gameDomainModel
    }
}
