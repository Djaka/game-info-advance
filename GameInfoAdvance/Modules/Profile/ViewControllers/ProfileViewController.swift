//
//  ProfileViewController.swift
//  GameInfoAdvance
//
//  Created by Djaka Permana on 09/07/23.
//

import UIKit
import SDWebImage
import RxSwift

class ProfileViewController: UIViewController {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var currentJobLabel: UILabel!
    @IBOutlet weak var descriptionAbout: UILabel!
    
    private var profileViewModel: ProfileViewModel?
    private let router = ProfileRouter()
    private var disposeBag = DisposeBag()
    
    convenience init(profileViewModel: ProfileViewModel) {
        self.init()
        
        self.profileViewModel = profileViewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        profileViewModel?.getProfile()
    }
    
    private func bindViewModel() {
        guard let profileViewModel = profileViewModel else {
            return
        }
        
        bindProfile(with: profileViewModel)
        bindError(with: profileViewModel)
    }
    
    private func bindProfile(with profileViewModel: ProfileViewModel) {
        profileViewModel.profileObservable
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { profileModel in
                self.updateUI(with: profileModel)
            })
            .disposed(by: disposeBag)
    }
    
    private func bindError(with profileViewModel: ProfileViewModel) {
        profileViewModel.errorObservable
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { error in
                self.showAlert(title: "Error", message: error.localizedDescription)
            })
            .disposed(by: disposeBag)
    }
    
    private func showAlert(title: String, message: String) {
        let alert = GameInfoAlert.alert(title: title, message: message)
        self.present(alert, animated: true)
    }
    
    private func updateUI(with profileModel: ProfileModel?) {
        guard let profileModel = profileModel else {
            return
        }
        
        SDWebImageDownloader.shared.config.downloadTimeout = 300
        profileImage.sd_imageIndicator = SDWebImageActivityIndicator.white
        profileImage.sd_setImage(with: URL(string: profileModel.authorImage ?? ""), placeholderImage: UIImage(systemName: "photo.on.rectangle.angled"))
        nameLabel.text = profileModel.author
        currentJobLabel.text = profileModel.currentJob
        emailLabel.text = profileModel.email
        descriptionAbout.attributedText = profileModel.description?.htmlToAttributedString
        descriptionAbout.font = UIFont(name: "Arial", size: 14)
        descriptionAbout.textColor = UIColor(hex: "#18122B")
        descriptionAbout.textAlignment = .justified
        
        configureImage()
    }
    
    private func configureImage() {
        profileImage.layer.borderWidth = 1
        profileImage.layer.masksToBounds = false
        profileImage.layer.borderColor = UIColor.black.cgColor
        profileImage.layer.cornerRadius = profileImage.frame.height/2
        profileImage.clipsToBounds = true
    }

    @IBAction func changeProfile(_ sender: Any) {
//        let editProfileViewController = EditProfileViewController()
//        navigationController?.pushViewController(editProfileViewController, animated: true)
        
        router.pushToEditProfile(with: self)
    }
}
