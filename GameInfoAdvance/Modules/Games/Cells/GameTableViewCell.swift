//
//  GameTableViewCell.swift
//  GameInfoAdvance
//
//  Created by Djaka Permana on 05/07/23.
//

import UIKit
import SDWebImage

class GameTableViewCell: UITableViewCell {

    static var identifier: String {
        String(describing: GameTableViewCell.self)
    }
    
    var removeGame: (() -> Void)?
    var saveGame: (() -> Void)?

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var gameImage: UIImageView!
    @IBOutlet weak var ratingLogo: UIImageView!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var titleGameLabel: UILabel!
    @IBOutlet weak var platformStackView: UIStackView!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var favoriteView: UIView!
    @IBOutlet weak var favoriteButton: UIButton!
    
    private var gameModel: GameModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        containerView.layer.cornerRadius = 10
        containerView.clipsToBounds = true

        favoriteView.layer.borderWidth = 1
        favoriteView.layer.masksToBounds = false
        favoriteView.layer.borderColor = UIColor(hex: "#635985").cgColor
        favoriteView.layer.cornerRadius = favoriteView.frame.height/2
        favoriteView.clipsToBounds = true
    }
    
    func configureCell(gameModel: GameModel) {
        self.gameModel = gameModel
        
        SDWebImageDownloader.shared.config.downloadTimeout = 300
        self.gameImage.sd_imageIndicator = SDWebImageActivityIndicator.white
        self.gameImage.sd_setImage(with: URL(string: gameModel.backgroundImage ?? ""), placeholderImage: UIImage(systemName: "photo.on.rectangle.angled"))
        self.titleGameLabel.text = gameModel.name
        self.ratingLabel.text = String(gameModel.rating ?? 0.0)
        self.releaseDateLabel.text = gameModel.released
        self.ratingLogo.image = gameModel.rating.getRatingImage()
        
        self.platformStackView.removeFullyAllArrangedSubviews()
        if let images = gameModel.platformImages {
            for imagePlatform in images {
                self.platformStackView.addArrangedSubview(imagePlatform)
            }
        }
        
        let imageFavorited = gameModel.isFavorite ?? false ? UIImage(systemName: "heart.fill"): UIImage(systemName: "heart")
        self.favoriteButton.setImage(imageFavorited, for: .normal)
        
    }
    
    @IBAction func favoriteButtonTap(_ sender: Any) {
        guard let gameModel = gameModel else {
            return
        }
        
        if gameModel.isFavorite ?? false {
            self.removeGame?()
        } else {
            self.saveGame?()
        }
    }
}
