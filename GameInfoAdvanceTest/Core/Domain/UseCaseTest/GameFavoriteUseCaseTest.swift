//
//  GameFavoriteUseCaseTest.swift
//  GameInfoAdvanceTest
//
//  Created by Djaka Permana on 15/07/23.
//

import XCTest
import RxSwift

@testable import GameInfoAdvance

final class GameFavoriteUseCaseTest: XCTestCase {
    private let disposeBag = DisposeBag()
    private var useCase: GameFavoriteInteractorMock?
    
    override func setUpWithError() throws {
        useCase = GameFavoriteInteractorMock()
    }
    
    override func tearDownWithError() throws {
        useCase = nil
    }
    
    func testGetFavoriteGames() {
        
        let result = useCase?.getFavoriteGames()
        result?.subscribe(onNext: { data in
            XCTAssertEqual(data.count, 1)
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
    
    func testSearchFavoriteGame() {
        let result = useCase?.searchFavoriteGame(keywoard: "Grand Theft Auto V")
        result?.subscribe(onNext: { data in
            XCTAssertEqual(data[0].id, gameFavoriteModelMock.id)
        })
        .disposed(by: disposeBag)
    }
}
