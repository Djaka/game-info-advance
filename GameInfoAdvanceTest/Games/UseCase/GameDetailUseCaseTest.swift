//
//  GameDetailUseCaseTest.swift
//  GameInfoAdvanceTest
//
//  Created by Djaka Permana on 27/08/23.
//

import XCTest
import Core
import Games
import RxSwift

@testable import GameInfoAdvance

final class GameDetailUseCaseTest: XCTestCase {

    private let disposeBag = DisposeBag()
    private var gameDetailUseCase: Interactor<Int, GameDetailDomainModel, GameDetailRepositoryMock<GetDetailGameRemoteDataSourceMock, GameDetailTransformer>>?
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        gameDetailUseCase = Injection.init().provideGameDetailMock()
    }

    func testGetGameDetail() {
        let gameId = 3498
        gameDetailUseCase?.execute(request: gameId)
            .asObservable()
            .subscribe(onNext: { gameDetailModel in
                XCTAssertEqual(gameDetailModel.id, gameId)
            })
            .disposed(by: disposeBag)
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
        gameDetailUseCase = nil
    }

}
