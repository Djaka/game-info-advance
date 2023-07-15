//
//  GetDetailUseCaseTest.swift
//  GameInfoAdvanceTest
//
//  Created by Djaka Permana on 15/07/23.
//

import Foundation
import XCTest
import RxSwift

@testable import GameInfoAdvance

final class GameDetailUseCaseTest: XCTestCase {
    
    private let disposeBag = DisposeBag()
    private var useCase: GameDetailUseCase?
    
    override func setUpWithError() throws {
        useCase = GameDetailInteracotrMock()
    }
    
    override func tearDownWithError() throws {
        useCase = nil
    }
    
    func testGetGameDetail() {
        let result = useCase?.getGameDetail(with: 3498)
        result?.subscribe(onNext: { data in
            XCTAssertEqual(data.id, gameDetailModelMock.id)
        })
        .disposed(by: disposeBag)
    }
    
    func testAddFavoriteGame() {
        let result = useCase?.addFavoriteGame(gameDetailModelMock)
        result?.subscribe(onNext: { success in
            XCTAssertTrue(success)
        })
        .disposed(by: disposeBag)
    }
    
    func testRemoveFavoriteGame() {
        let result = useCase?.removeFavoriteGame(with: 3498)
        result?.subscribe(onNext: { success in
            XCTAssertTrue(success)
        })
        .disposed(by: disposeBag)
    }
}
