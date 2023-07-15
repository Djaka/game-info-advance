//
//  GameFavoriteCollectionViewCell.swift
//  GameInfoAdvance
//
//  Created by Djaka Permana on 06/07/23.
//

import UIKit
import SDWebImage

class GameFavoriteCollectionViewCell: UICollectionViewCell {

    var removeFavoriteGame: (() -> Void)?
    
    static var identifier: String {
        String(describing: GameFavoriteCollectionViewCell.self)
    }
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var containerImageView: UIView!
    @IBOutlet weak var favoriteImage: UIImageView!
    @IBOutlet weak var favoriteView: UIView!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    var gameFavoriteModel: GameFavoriteModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(gameFavoriteModel: GameFavoriteModel = GameFavoriteModel()) {
        self.gameFavoriteModel = gameFavoriteModel
        
        containerImageView.layer.cornerRadius = 10
        containerImageView.clipsToBounds = true
        
        favoriteView.layer.borderWidth = 1
        favoriteView.layer.masksToBounds = false
        favoriteView.layer.borderColor = UIColor(hex: "#635985").cgColor
        favoriteView.layer.cornerRadius = favoriteView.frame.height/2
        favoriteView.clipsToBounds = true
        
        SDWebImageDownloader.shared.config.downloadTimeout = 300
        self.favoriteImage.sd_imageIndicator = SDWebImageActivityIndicator.white
        self.favoriteImage.sd_setImage(with: URL(string: self.gameFavoriteModel?.backgroundImage ?? ""), placeholderImage: UIImage(systemName: "photo.on.rectangle.angled"))
        self.titleLabel.text = self.gameFavoriteModel?.name
        
        let imageFavorited = self.gameFavoriteModel?.isFavorite ?? false ? UIImage(systemName: "heart.fill"): UIImage(systemName: "heart")
        self.favoriteButton.setImage(imageFavorited, for: .normal)
    }
    
    @IBAction func unFavoriteButtonTap(_ sender: Any) {
        guard let gameFavoriteModel = gameFavoriteModel else {
            return
        }
        
        if gameFavoriteModel.isFavorite ?? false {
            self.removeFavoriteGame?()
        }
    }

}
