//
//  EditProfileViewController.swift
//  GameInfoAdvance
//
//  Created by Djaka Permana on 09/07/23.
//

import UIKit
import SDWebImage
import RxSwift
import Profile

class EditProfileViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var currentJobTextField: UITextField!
    @IBOutlet weak var updateButton: UIButton!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var resetButton: UIButton!
    
    private var editProfileViewModel: EditProfileViewModel?
    private var router = EditProfileRouter()
    private var disposeBag = DisposeBag()
    private var profileModel = ProfileDomainModel()
    
    convenience init(editProfileViewModel: EditProfileViewModel) {
        self.init()
        
        self.editProfileViewModel = editProfileViewModel
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackView()
        setupButtonView()
        bindViewModel()
        
        self.editProfileViewModel?.getProfile()
    }

    @IBAction func updateAccount(_ sender: Any) {
        if let name = nameTextField.text, let email = emailTextField.text, let currentJob = currentJobTextField.text {
            
            if name.isEmpty {
                fieldEmpty("Name")
            } else if email.isEmpty {
                fieldEmpty("Email")
            } else if currentJob.isEmpty {
                fieldEmpty("Current Job")
            } else {
                updateProfile(name, email, currentJob)
                self.navigationController?.popToRootViewController(animated: true)
            }
        }
    }
    
    @IBAction func resetAction(_ sender: Any) {
        self.editProfileViewModel?.getProfile()
    }
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    private func bindViewModel() {
        guard let editProfileViewModel = editProfileViewModel else {
            return
        }
        
        bindProfile(with: editProfileViewModel)
        bindError(with: editProfileViewModel)
        bindSuccessUpdate(with: editProfileViewModel)
    }
    
    private func bindProfile(with editProfileViewModel: EditProfileViewModel) {
        editProfileViewModel.profileObservable
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { profileModel in
                self.updateUI(with: profileModel)
            })
            .disposed(by: disposeBag)
    }
    
    private func bindError(with editProfileViewModel: EditProfileViewModel) {
        editProfileViewModel.errorObservable
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { error in
                self.showAlert(title: "Error", message: error.localizedDescription)
            })
            .disposed(by: disposeBag)
    }
    
    private func bindSuccessUpdate(with editProfileViewModel: EditProfileViewModel) {
        editProfileViewModel.errorObservable
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { _ in
                self.showAlert(title: "Success", message: "Update success")
                self.router.backToPreviousePage(with: self)
            })
            .disposed(by: disposeBag)
    }
    
    private func fieldEmpty(_ field: String) {
        let action = UIAlertAction(title: "OK", style: .default)
        let alert = UIAlertController(title: "Alert", message: "\(field) is empty", preferredStyle: .alert)
        alert.addAction(action)
        self.present(alert, animated: true)
    }
    
    private func updateProfile(_ name: String, _ email: String, _ currentJob: String) {
        guard let editProfileViewModel = editProfileViewModel else {
            return
        }
        
        profileModel.author = name
        profileModel.email = email
        profileModel.currentJob = currentJob
        
        editProfileViewModel.updateProfile(profileModel: profileModel)
    }
    
    private func updateUI(with profileModel: ProfileDomainModel?) {
        guard let profileModel = profileModel else {
            return
        }
        self.profileModel = profileModel
        
        profileImage.sd_imageIndicator = SDWebImageActivityIndicator.white
        profileImage.sd_setImage(with: URL(string: profileModel.authorImage ?? ""), placeholderImage: UIImage(systemName: "photo.on.rectangle.angled"))
        configureImage()
        
        nameTextField.text = profileModel.author ?? ""
        emailTextField.text = profileModel.email ?? ""
        currentJobTextField.text = profileModel.currentJob ?? ""
    }
    
    private func configureImage() {
        profileImage.layer.borderWidth = 1
        profileImage.layer.masksToBounds = false
        profileImage.layer.borderColor = UIColor.black.cgColor
        profileImage.layer.cornerRadius = profileImage.frame.height/2
        profileImage.clipsToBounds = true
    }
    
    private func setupBackView() {
        backView.layer.cornerRadius = 10
        backView.clipsToBounds = true
    }
    
    private func setupButtonView() {
        updateButton.layer.cornerRadius = 8
        updateButton.clipsToBounds = true
        
        resetButton.layer.cornerRadius = 8
        resetButton.clipsToBounds = true
    }

}
