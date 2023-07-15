//
//  GameUseCaseTest.swift
//  GameInfoAdvanceTest
//
//  Created by Djaka Permana on 11/07/23.
//

import XCTest
import RxSwift

@testable import GameInfoAdvance

final class GameUseCaseTest: XCTestCase {
    
    private let disposeBag = DisposeBag()
    var useCase: GameInteractorMock?
    
    override func setUpWithError() throws {
        useCase = GameInteractorMock()
    }
    
    override func tearDownWithError() throws {
        useCase = nil
    }
    
    func testGetGames() {
        
        let result = useCase?.getGames(page: 1, pageSize: 1, search: "")
        
        result?.subscribe(onNext: { data in
            XCTAssertEqual(data.count, 2)
        })
        .disposed(by: disposeBag)
    }
    
    func testAddFavoriteGame() {
        let result = useCase?.addFavoriteGame(gameModel)
        
        result?.subscribe(onNext: { success in
            XCTAssertTrue(success)
        })
        .disposed(by: disposeBag)
    }
    
    func testRemoveFavoriteGame() {
        
        let result = useCase?.removeFavoriteGame(with: 1)
        
        result?.subscribe(onNext: { success in
            XCTAssertTrue(success)
        })
        .disposed(by: disposeBag)
    }

}
