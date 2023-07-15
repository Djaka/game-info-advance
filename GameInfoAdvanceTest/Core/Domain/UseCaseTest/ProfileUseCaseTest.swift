//
//  ProfileUseCaseTest.swift
//  GameInfoAdvanceTest
//
//  Created by Djaka Permana on 15/07/23.
//

import XCTest
import RxSwift

@testable import GameInfoAdvance

final class ProfileUseCaseTest: XCTestCase {

    private let disposeBag = DisposeBag()
    private var useCase: ProfileUseCase?
    
    override func setUpWithError() throws {
        useCase = ProfileInteractorMock()
    }
    
    override func tearDownWithError() throws {
        useCase = nil
    }

    func testGetProfile() {
        useCase?.getProfile()
            .subscribe(onNext: { data in
                XCTAssertEqual(data.author, profileModelMock.author)
                XCTAssertEqual(data.authorImage, profileModelMock.authorImage)
                XCTAssertEqual(data.currentJob, profileModelMock.currentJob)
                XCTAssertEqual(data.description, profileModelMock.description)
            })
            .disposed(by: disposeBag)
    }
    
    func testUpdateProfile() {
        let result = useCase?.updateProfile(profileModel: profileModelUpdateMock)
        result?.subscribe(onNext: { success in
            XCTAssertTrue(success)
        })
        .disposed(by: disposeBag)
    }

}
