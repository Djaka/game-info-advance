//
//  GameFavoriteViewController.swift
//  GameInfoAdvance
//
//  Created by Djaka Permana on 06/07/23.
//

import UIKit
import RxSwift
import Favorite
import SkeletonView

class GameFavoriteViewController: UIViewController {
    
    @IBOutlet weak var gameFavoriteCollectionView: UICollectionView!
    @IBOutlet weak var emptyLabel: UILabel!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var refreshView: UIView!
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
    @IBOutlet weak var shimmer10: UIView!
    @IBOutlet weak var shimmer11: UIView!
    @IBOutlet weak var shimmer12: UIView!
    
    var gameFavoriteViewModel: GameFavoriteViewModel?
    
    let router = GameFavoriteRouter()
    let disposeBag = DisposeBag()
    
    convenience init(gameFavoriteViewModel: GameFavoriteViewModel) {
        self.init()
        
        self.gameFavoriteViewModel = gameFavoriteViewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        binViewModel()
        setupSearchView()
        setupRefreshView()
        setupCollectionView()
        setupShimmerView()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.refreshPage()
    }
    
    @IBAction func buttonRefreshAction(_ sender: Any) {
        searchTextField.text = ""
        searchTextField.resignFirstResponder()
        refreshPage()
    }
    
    private func setupShimmerView() {
        shimmerView.isHidden = false
        
        shimmer1.isSkeletonable = true
        shimmer1.skeletonCornerRadius = 8
        
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
        
        shimmer10.isSkeletonable = true
        shimmer10.skeletonCornerRadius = 8
        
        shimmer11.isSkeletonable = true
        shimmer11.skeletonCornerRadius = 8
        
        shimmer12.isSkeletonable = true
        shimmer12.skeletonCornerRadius = 8
        
        shimmer1.showAnimatedGradientSkeleton()
        shimmer2.showAnimatedGradientSkeleton()
        shimmer3.showAnimatedGradientSkeleton()
        shimmer4.showAnimatedGradientSkeleton()
        shimmer5.showAnimatedGradientSkeleton()
        shimmer6.showAnimatedGradientSkeleton()
        shimmer7.showAnimatedGradientSkeleton()
        shimmer8.showAnimatedGradientSkeleton()
        shimmer9.showAnimatedGradientSkeleton()
        shimmer10.showAnimatedGradientSkeleton()
        shimmer11.showAnimatedGradientSkeleton()
        shimmer12.showAnimatedGradientSkeleton()
    }
    
    private func setupSearchView() {
        searchView.layer.cornerRadius = 10
        searchView.clipsToBounds = true
    }
    
    private func setupRefreshView() {
        refreshView.layer.cornerRadius = 10
        refreshView.clipsToBounds = true
    }
    
    private func setupCollectionView() {
        gameFavoriteCollectionView.rx.setDelegate(self)
            .disposed(by: disposeBag)
        gameFavoriteCollectionView.rx.setDataSource(self)
            .disposed(by: disposeBag)
        gameFavoriteCollectionView.register(
            UINib(nibName: GameFavoriteCollectionViewCell.identifier, bundle: nil),
            forCellWithReuseIdentifier: GameFavoriteCollectionViewCell.identifier
        )
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 4
        gameFavoriteCollectionView
               .setCollectionViewLayout(layout, animated: true)
    }
    
    private func refreshPage() {
        guard let viewModel = gameFavoriteViewModel else {
            return
        }
        
        viewModel.refreshPage()
    }
    
    private func removeFavorite(with gameFavoriteModel: FavoriteDomainModel, indexPath: IndexPath) {
        
        guard let viewModel = gameFavoriteViewModel else {
            return
        }
        
        viewModel.removeFavoriteGame(with: gameFavoriteModel, indexPath: indexPath)
    }
    
    private func binViewModel() {
        guard let gameFavoriteViewModel = gameFavoriteViewModel else {
            return
        }
        
        bindShowLoading(with: gameFavoriteViewModel)
        bindSuccessUnFavorited(with: gameFavoriteViewModel)
        bindReloadFavoriteCollectionView(with: gameFavoriteViewModel)
        bindEmptyFavorite(with: gameFavoriteViewModel)
        bindSearchTextField(with: gameFavoriteViewModel)
    }
    
    private func bindShowLoading(with viewModel: GameFavoriteViewModel) {
        viewModel.loadingStateObservable
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { isShow in
                self.gameFavoriteCollectionView.isHidden = isShow
                self.shimmerView.isHidden = !isShow
            })
            .disposed(by: disposeBag)
    }
    
    private func bindReloadFavoriteCollectionView(with viewModel: GameFavoriteViewModel) {
        viewModel.reloadGameFavoriteObservable
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: {
                self.gameFavoriteCollectionView.reloadData()
            })
            .disposed(by: disposeBag)
    }
    
    private func bindEmptyFavorite(with viewModel: GameFavoriteViewModel) {
        viewModel.showFavoritesEmptyObservable
            .observe(on: MainScheduler.instance)
            .bind(to: emptyLabel.rx.isHidden)
            .disposed(by: disposeBag)
    }
    
    private func bindSuccessUnFavorited(with viewModel: GameFavoriteViewModel) {
        viewModel.successUnFavoritedObservable
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { (success, gameModel, indexPath) in
                
                self.gameFavoriteCollectionView.performBatchUpdates({
                    self.gameFavoriteCollectionView.deleteItems(at: [indexPath])
                    }) { _ in
                    self.gameFavoriteCollectionView.reloadData()
                }
                
                let gameName = gameModel.name ?? ""
                self.showAlert(
                    title: success ? "Success": "Error",
                    message: success ? "\(gameName) is unfavorited": "Failed"
                )
            }
            , onError: { error in
                self.showAlert(
                    title: "Error",
                    message: error.localizedDescription
                )
            })
            .disposed(by: disposeBag)
    }
    
    private func bindSearchTextField(with viewModel: GameFavoriteViewModel) {
        searchTextField.rx.text
            .debounce(.milliseconds(500), scheduler: MainScheduler.instance)
            .subscribe(onNext: { keywoard in
                viewModel.getFavorites(keywoard: keywoard ?? "")
            })
            .disposed(by: disposeBag)
    }
}

extension GameFavoriteViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameFavoriteViewModel?.numberOfRowItem() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GameFavoriteCollectionViewCell.identifier, for: indexPath) as? GameFavoriteCollectionViewCell {
            
            guard let gameFavoriteViewModel = gameFavoriteViewModel else {
                return UICollectionViewCell()
            }
            
            let gameFavoriteModel = gameFavoriteViewModel.getFavoriteGame(by: indexPath.row)
            cell.configureCell(gameFavoriteModel: gameFavoriteModel)
            cell.removeFavoriteGame = { [weak self] in
                self?.removeFavorite(with: gameFavoriteModel, indexPath: indexPath)
            }
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
}

extension GameFavoriteViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 1.0, left: 10.0, bottom: 1.0, right: 10.0)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        
        guard let lay = collectionViewLayout as? UICollectionViewFlowLayout else {
            return CGSize()
        }
        let widthPerItem = collectionView.frame.width / 2 - lay.minimumInteritemSpacing
        return CGSize(width: widthPerItem-10, height: 215)
    }
}

extension GameFavoriteViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let gameFavoriteViewModel = gameFavoriteViewModel else {
            return
        }
        
        let gameFavoriteModel = gameFavoriteViewModel.getFavoriteGame(by: indexPath.row)
        router.pushToDetail(with: self, gameId: gameFavoriteModel.id ?? 0)
    }
}
