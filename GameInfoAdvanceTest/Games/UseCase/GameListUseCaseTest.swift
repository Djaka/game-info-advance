//
//  GamesViewModel.swift
//  GameInfoAdvanceTest
//
//  Created by Djaka Permana on 26/08/23.
//

import XCTest
import RxSwift
import Core
import Games

@testable import GameInfoAdvance

final class GameListUseCaseTest: XCTestCase {
    
    private let disposeBag = DisposeBag()
    private var gameListUseCase: Interactor<GameParameterRequest, [GameDomainModel], GameListRepositoryMock<GetListGameRemoteDataSourceMock, GamesTransformer>>?
    private let gameParamenterRequest = GameParameterRequest(
        page: 1,
        pageSize: 10,
        search: ""
    )
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        self.gameListUseCase = Injection.init().provideGamesMock()
        
    }
    
    func testGetGameList() {
        gameListUseCase?.execute(request: gameParamenterRequest).asObservable()
            .subscribe(onNext: { models in
                XCTAssertEqual(models.count, 10)
            })
            .disposed(by: disposeBag)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
        gameListUseCase = nil
    }

}
