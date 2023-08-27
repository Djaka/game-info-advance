//
//  ProfileEditUseCaseTest.swift
//  GameInfoAdvanceTest
//
//  Created by Djaka Permana on 27/08/23.
//

import XCTest
import Core
import Profile
import RxSwift
@testable import GameInfoAdvance

final class ProfileEditUseCaseTest: XCTestCase {
    
    private let disposeBag = DisposeBag()
    var profileEditUseCase: Interactor<ProfileEntityModel, Bool, ProfileEditRepositoryMock<ProfileLocalDataSourceMock>>?

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        self.profileEditUseCase = Injection.init().provideEditProfileMock()
    }
    
    func testEditProfile() {
        self.profileEditUseCase?.execute(request: getProfileEntityModel())
            .asObservable()
            .subscribe(onNext: { isSuccess in
                XCTAssertTrue(isSuccess)
            })
            .disposed(by: disposeBag)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
        self.profileEditUseCase = nil
    }
}
