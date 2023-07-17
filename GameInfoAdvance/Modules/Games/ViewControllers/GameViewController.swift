//
//  GameViewController.swift
//  GameInfoAdvance
//
//  Created by Djaka Permana on 05/07/23.
//

import UIKit
import RxSwift
import RxCocoa

class GameViewController: UIViewController {

    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var gameTableView: UITableView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var refreshView: UIView!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    
    private var gameViewModel: GameViewModel?
    
    private let disposeBag = DisposeBag()
    private let router = GameRouter()
    
    private var showLoadingFooter = false
    
    convenience init(gameViewModel: GameViewModel) {
        self.init()
        
        self.gameViewModel = gameViewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bindViewModel()
        
        setupSearchView()
        setupRefreshView()
        setupTable()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        refreshPage()
    }
    
    @IBAction func buttonRefreshAction(_ sender: Any) {
        searchTextField.text = ""
        refreshPage()
    }
    
    private func setupTable() {
        gameTableView.rx.setDelegate(self)
            .disposed(by: disposeBag)
        gameTableView.rx.setDataSource(self)
            .disposed(by: disposeBag)
        gameTableView.register(
            UINib(nibName: GameTableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: GameTableViewCell.identifier
        )
        gameTableView.separatorStyle = .none
    }
    
    private func bindViewModel() {
        
        guard let gameViewModel = gameViewModel else {
            return
        }
        
        bindShowLoading(with: gameViewModel)
        bindReloadTable(with: gameViewModel)
        bindScrollTableView(with: gameViewModel)
        bindShowLoadingFooter(with: gameViewModel)
        bindSearchTextField(with: gameViewModel)
        bindSuccessFavorited(with: gameViewModel)
        bindSuccessUnFavorited(with: gameViewModel)
    }
    
    private func bindShowLoading(with viewModel: GameViewModel) {
        viewModel.loadingStateObservable
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { isShow in
                self.loading.isHidden = !isShow
            })
            .disposed(by: disposeBag)
    }
    
    private func bindReloadTable(with viewModel: GameViewModel) {
        viewModel.reloadGamesObservable
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: {
                self.gameTableView.reloadData()
            })
            .disposed(by: disposeBag)
    }
    
    private func bindScrollTableView(with viewModel: GameViewModel) {
            
        gameTableView.rx.didScroll.subscribe{ [weak self] _ in
            
            guard let self = self else {
                return
            }
            
            let offsetY = self.gameTableView.contentOffset.y
            let contentHeight = self.gameTableView.contentSize.height
            
            if offsetY != 0 && offsetY > (contentHeight - self.gameTableView.frame.size.height) && !self.showLoadingFooter {
                viewModel.loadMoreData()
            }
        }
        .disposed(by: disposeBag)
    }
    
    private func bindShowLoadingFooter(with viewModel: GameViewModel) {
        viewModel.loadingFooterObservable
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { show in
                self.gameTableView.tableFooterView = show ? LoadMoreView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 100)) : UIView(frame: .zero)
                self.showLoadingFooter = show
            })
            .disposed(by: disposeBag)
    }
    
    private func refreshPage() {
        guard let gameViewModel = self.gameViewModel else {
            return
        }
        
        gameViewModel.refreshPage()
    }
    
    private func setupSearchView() {
        searchView.layer.cornerRadius = 10
        searchView.clipsToBounds = true
    }
    
    private func setupRefreshView() {
        refreshView.layer.cornerRadius = 10
        refreshView.clipsToBounds = true
    }
    
    private func bindSearchTextField(with viewModel: GameViewModel) {
        searchTextField.rx.text
            .debounce(.milliseconds(500), scheduler: MainScheduler.instance)
            .subscribe(onNext: { keywoard in
                viewModel.searchGame(keywoard ?? "")
            })
            .disposed(by: disposeBag)
    }
    
    private func saveFavoriteGame(with gameModel: GameModel) {
        
        guard let viewModel = gameViewModel else {
            return
        }

        viewModel.addToFavoriteGame(with: gameModel)
    }
    
    private func bindSuccessFavorited(with viewModel: GameViewModel) {
        viewModel.successFavoritedObservable
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { (success, gameModel) in
                self.gameTableView.reloadData()
                let gameName = gameModel.name ?? ""
                self.showAlert(
                    title: success ? "Success": "Error",
                    message: success ? "\(gameName) is Favorited": "Failed"
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
    
    private func removeFavorite(with gameModel: GameModel) {
        
        guard let viewModel = gameViewModel else {
            return
        }
        
        viewModel.removeFavoriteGame(with: gameModel)
    }
    
    private func bindSuccessUnFavorited(with viewModel: GameViewModel) {
        viewModel.successUnFavoritedObservable
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { (success, gameModel) in
                self.gameTableView.reloadData()
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
    
}

extension GameViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gameViewModel?.numberOfRowItem() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: GameTableViewCell.identifier, for: indexPath) as? GameTableViewCell {
            guard let gameViewModel = gameViewModel else {
                return UITableViewCell()
            }
            
            let gameModel = gameViewModel.getGame(by: indexPath.row)
            cell.configureCell(gameModel: gameModel)
            cell.selectionStyle = .none
            cell.saveGame = { [weak self] in
                self?.saveFavoriteGame(with: gameModel)
            }
            cell.removeGame = { [weak self] in
                self?.removeFavorite(with: gameModel)
            }
            return cell
        } else {
            return UITableViewCell()
        }
    }
}

extension GameViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let gameViewModel = gameViewModel else {
            return
        }
        router.pushToDetail(with: self, gameId: gameViewModel.getGame(by: indexPath.row).id ?? 0)
    }
}
