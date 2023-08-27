//
//  FavoriteAddUseCaseTest.swift
//  GameInfoAdvanceTest
//
//  Created by Djaka Permana on 27/08/23.
//

import XCTest
import RxSwift
import Core
import Favorite
@testable import GameInfoAdvance

final class FavoriteAddUseCaseTest: XCTestCase {

    private let disposeBag = DisposeBag()
    private var favoriteAddUseCase: Interactor<FavoriteEntityModel, Bool, FavoriteAddRepositoryMock<FavoriteLocalDataSourceMock, FavoritesTransformer>>?
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        self.favoriteAddUseCase = Injection.init().provideGameAddFavoriteMock()
    }
    
    func testGameFavoriteAdd() {
        favoriteAddUseCase?.execute(request: getFavoriteModel())
            .asObservable()
            .subscribe(onNext: { isSuccess in
                XCTAssertTrue(isSuccess)
            })
            .disposed(by: disposeBag)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
        self.favoriteAddUseCase = nil
    }

}
