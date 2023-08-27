//
//  ProfileUseCaseTest.swift
//  GameInfoAdvanceTest
//
//  Created by Djaka Permana on 27/08/23.
//

import XCTest
import Core
import Profile
import RxSwift
@testable import GameInfoAdvance

final class ProfileUseCaseTest: XCTestCase {
    
    private let disposeBag = DisposeBag()
    var profileUseCase: Interactor<Any, ProfileDomainModel, ProfileRepositoryMock<ProfileRemoteDataSourceMock, ProfileLocalDataSourceMock, ProfileTransformer>>?

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        self.profileUseCase = Injection.init().provideProfileMock()
    }

    func testGetProfile() {
        self.profileUseCase?.execute(request: nil)
            .asObservable()
            .subscribe(onNext: { profileModel in
                XCTAssertEqual(profileModel.id, 1)
            })
            .disposed(by: disposeBag)
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
        self.profileUseCase = nil
    }

}
