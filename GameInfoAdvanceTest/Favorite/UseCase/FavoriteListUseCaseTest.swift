//
//  FavoriteListUseCaseTest.swift
//  GameInfoAdvanceTest
//
//  Created by Djaka Permana on 27/08/23.
//

import XCTest
import RxSwift
import Core
import Favorite

@testable import GameInfoAdvance

final class FavoriteListUseCaseTest: XCTestCase {

    private let disposeBag = DisposeBag()
    private var favoriteListUseCase: Interactor<String, [FavoriteDomainModel], FavoriteListRepositoryMock<FavoriteLocalDataSourceMock, FavoritesTransformer>>?
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.favoriteListUseCase = Injection.init().provideGameFavoriteListMock()
    }
    
    func testGetGameFavoriteList() {
        favoriteListUseCase?.execute(request: nil)
            .asObservable()
            .subscribe(onNext: { model in
                XCTAssertEqual(model.count, 1)
            })
            .disposed(by: disposeBag)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
        self.favoriteListUseCase = nil
    }

}
