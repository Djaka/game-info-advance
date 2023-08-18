//
//  GameDetailViewController.swift
//  GameInfoAdvance
//
//  Created by Djaka Permana on 07/07/23.
//

import UIKit
import RxSwift
import RxCocoa
import SDWebImage
import Games
import SkeletonView

class GameDetailViewController: UIViewController {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var bannerImage: UIImageView!
    @IBOutlet weak var ratingStackView: UIStackView!
    @IBOutlet weak var platformsStackView: UIStackView!
    @IBOutlet weak var subBannerImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var ratingLogo: UIImageView!
    @IBOutlet weak var scrollDetail: UIScrollView!
    @IBOutlet weak var favoriteView: UIView!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var shimmerContainerView: UIView!
    @IBOutlet weak var shimmerView: UIView!
    @IBOutlet weak var shimmer1: UIView!
    @IBOutlet weak var shimmer2: UIView!
    @IBOutlet weak var shimmer3: UIView!
    @IBOutlet weak var shimmer4: UIView!
    @IBOutlet weak var shimmer5: UIView!
    @IBOutlet weak var shimmer6: UIView!
    @IBOutlet weak var shimmer7: UIView!
    @IBOutlet weak var shimmer8: UIView!
    @IBOutlet weak var shimmer9: UIView!
    
    private var gameDetailViewModel: GameDetailViewModel?
    private var gameDetailModel = GameDetailDomainModel()
    
    private let router = GameDetailRouter()
    private let disposeBag = DisposeBag()
    
    convenience init(gameDetailViewModel: GameDetailViewModel) {
        self.init()
        
        self.gameDetailViewModel = gameDetailViewModel
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollDetail.delegate = self
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.tintColor = UIColor(hex: "#635985")
        self.navigationController?.navigationBar.standardAppearance.titleTextAttributes = [.foregroundColor: UIColor(hex: "#635985")]
        
        setupUI()
        bindViewModel()
        
        self.gameDetailViewModel?.getGameDetail()
    }
    
    @objc func favoriteAction() {
        favoriteActionTap()
    }

    private func setupUI() {
        backView.layer.cornerRadius = 10
        backView.clipsToBounds = true
        
        favoriteView.layer.cornerRadius = 10
        favoriteView.clipsToBounds = true
        
        subBannerImage.layer.cornerRadius = 10
        subBannerImage.clipsToBounds = true
        
        shimmerView.isHidden = false
        setupShimmerView()
    }
    
    private func setupShimmerView() {
        shimmerView.isHidden = false
        shimmer1.isSkeletonable = true
        
        shimmer2.isSkeletonable = true
        shimmer2.skeletonCornerRadius = 8
        
        shimmer3.isSkeletonable = true
        shimmer3.skeletonCornerRadius = 8
        
        shimmer4.isSkeletonable = true
        shimmer4.skeletonCornerRadius = 8
        
        shimmer5.isSkeletonable = true
        shimmer5.skeletonCornerRadius = 8
        
        shimmer6.isSkeletonable = true
        shimmer6.skeletonCornerRadius = 8
        
        shimmer7.isSkeletonable = true
        shimmer7.skeletonCornerRadius = 8
        
        shimmer8.isSkeletonable = true
        shimmer8.skeletonCornerRadius = 8
        
        shimmer9.isSkeletonable = true
        shimmer9.skeletonCornerRadius = 8
        
        shimmer1.showAnimatedGradientSkeleton()
        shimmer2.showAnimatedGradientSkeleton()
        shimmer3.showAnimatedGradientSkeleton()
        shimmer4.showAnimatedGradientSkeleton()
        shimmer5.showAnimatedGradientSkeleton()
        shimmer6.showAnimatedGradientSkeleton()
        shimmer7.showAnimatedGradientSkeleton()
        shimmer8.showAnimatedGradientSkeleton()
        shimmer9.showAnimatedGradientSkeleton()
    }
    
    private func bindViewModel() {
        guard let gameDetailViewModel = self.gameDetailViewModel else {
            return
        }
        
        bindDetailGame(with: gameDetailViewModel)
        bindError(with: gameDetailViewModel)
        bindSuccessFavorited(with: gameDetailViewModel)
        bindSuccessUnFavorited(with: gameDetailViewModel)
    }
    
    private func bindError(with gameDetailViewModel: GameDetailViewModel) {
        gameDetailViewModel.errorObservable
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { error in
                self.showAlert(title: "Error", message: error)
            })
            .disposed(by: disposeBag)
    }
    
    private func bindDetailGame(with gameDetailViewModel: GameDetailViewModel) {
        gameDetailViewModel.gameDetailObservable
            .delay(RxTimeInterval.seconds(3), scheduler: MainScheduler.instance)
            .subscribe(onNext: { gameDetailModel in
                if gameDetailModel != nil {
                    self.updateUI(with: gameDetailModel)
                    self.shimmerView.isHidden = true
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func bindSuccessFavorited(with gameDetailViewModel: GameDetailViewModel) {
        gameDetailViewModel.successFavoritedObservable
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { (success, gameDetailModel) in
                let gameName = gameDetailModel.name ?? ""
                self.showAlert(
                    title: success ? "Success": "Error",
                    message: success ? "\(gameName) is Favorited": "Failed"
                )
                self.gameDetailModel.isFavorite = true
                self.setFavoriteUI(isFavorite: true)
            }
            , onError: { error in
                self.showAlert(
                    title: "Error",
                    message: error.localizedDescription
                )
            })
            .disposed(by: disposeBag)
    }
    
    private func bindSuccessUnFavorited(with gameDetailViewModel: GameDetailViewModel) {
        gameDetailViewModel.successUnFavoritedObservable
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { (success, gameDetailModel) in
                let gameName = gameDetailModel.name ?? ""
                self.showAlert(
                    title: success ? "Success": "Error",
                    message: success ? "\(gameName) is unfavorited": "Failed"
                )
                self.gameDetailModel.isFavorite = false
                self.setFavoriteUI(isFavorite: false)
            }
            , onError: { error in
                self.showAlert(
                    title: "Error",
                    message: error.localizedDescription
                )
            })
            .disposed(by: disposeBag)
    }
    
    private func updateUI(with gameDetailModel: GameDetailDomainModel?) {
        guard let gameDetailModel = gameDetailModel else {
            return
        }
        
        self.gameDetailModel = gameDetailModel
        
        SDWebImageDownloader.shared.config.downloadTimeout = 300
        self.bannerImage.sd_imageIndicator = SDWebImageActivityIndicator.white
        self.bannerImage.sd_setImage(with: URL(string: gameDetailModel.backgroundImage ?? ""), placeholderImage: UIImage(systemName: "photo.on.rectangle.angled"))
        let view = UIView(frame: bannerImage.frame)
        let gradient = CAGradientLayer()
        gradient.frame = view.frame
        gradient.colors = [UIColor.clear.cgColor, UIColor(hex: "#18122B").cgColor]
        gradient.locations = [0.0, 1.0]
        view.layer.insertSublayer(gradient, at: 0)
        bannerImage.addSubview(view)
        bannerImage.bringSubviewToFront(view)
        
        titleLabel.text = gameDetailModel.name
        ratingLabel.text = String(gameDetailModel.rating ?? 0.0)
        ratingLogo.image = gameDetailModel.rating.getRatingImage()
        
        platformsStackView.removeFullyAllArrangedSubviews()
        if let images = gameDetailModel.platformImages {
            for imagePlatform in images {
                platformsStackView.addArrangedSubview(imagePlatform)
            }
        }
        
        self.subBannerImage.sd_imageIndicator = SDWebImageActivityIndicator.white
        self.subBannerImage.sd_setImage(with: URL(string: gameDetailModel.backgroundImage ?? ""), placeholderImage: UIImage(systemName: "photo.on.rectangle.angled"))
        releaseLabel.text = gameDetailModel.released
        descriptionLabel.attributedText = gameDetailModel.description?.htmlToAttributedString
        descriptionLabel.font = UIFont(name: "Arial", size: 14)
        descriptionLabel.textColor = UIColor.white
        descriptionLabel.textAlignment = .justified
        setFavoriteUI(isFavorite: gameDetailModel.isFavorite ?? false)
        
    }
    
    private func setFavoriteUI(isFavorite: Bool) {
        if isFavorite {
            self.favoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "heart.fill"), style: .plain, target: self, action: #selector(favoriteAction))
        } else {
            self.favoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "heart"), style: .plain, target: self, action: #selector(favoriteAction))
        }
    }
    
    private func favoriteActionTap() {
        
        if self.gameDetailModel.isFavorite ?? false {
            removeFavorite(with: gameDetailModel)
        } else {
            saveFavoriteGame(with: gameDetailModel)
        }
    }
    
    private func saveFavoriteGame(with gameDetailModel: GameDetailDomainModel) {
        
        guard let gameDetailViewModel = gameDetailViewModel else {
            return
        }

        gameDetailViewModel.addToFavoriteGame(with: gameDetailModel)
    }
    
    private func removeFavorite(with gameDetailModel: GameDetailDomainModel) {
        
        guard let gameDetailViewModel = gameDetailViewModel else {
            return
        }
        
        gameDetailViewModel.removeFavoriteGame(with: gameDetailModel)
    }
    
    @IBAction func favoriteButtonAction(_ sender: Any) {
        favoriteActionTap()
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        router.backToPreviousePage(with: self)
    }
    
}

extension GameDetailViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if scrollView.contentOffset.y > 50 && scrollView.contentOffset.y < 350 {
            navigationController?.setNavigationBarHidden(false, animated: true)
            navigationItem.title = ""
        } else if scrollView.contentOffset.y > 350 {
            navigationController?.setNavigationBarHidden(false, animated: false)
            navigationItem.title = gameDetailModel.name ?? ""
            self.navigationController?.navigationBar.standardAppearance.titleTextAttributes = [.foregroundColor: UIColor(hex: "#635985")]
        } else {
            navigationController?.setNavigationBarHidden(true, animated: true)
        }
    }
    
}
