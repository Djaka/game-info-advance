//
//  FavoriteRemoveUseCaseTest.swift
//  GameInfoAdvanceTest
//
//  Created by Djaka Permana on 27/08/23.
//

import XCTest
import RxSwift
import Core
import Favorite
@testable import GameInfoAdvance

final class FavoriteRemoveUseCaseTest: XCTestCase {

    private let disposeBag = DisposeBag()
    private var favoriteRemoveUseCase: Interactor<Int, Bool, FavoriteRemoveRepositoryMock<FavoriteLocalDataSourceMock, FavoritesTransformer>>?
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        self.favoriteRemoveUseCase = Injection.init().provideGameRemoveFavoriteMock()
    }
    
    func testGameFavoriteRemove() {
        favoriteRemoveUseCase?.execute(request: 3498)
            .asObservable()
            .subscribe(onNext: { isSuccess in
                XCTAssertTrue(isSuccess)
            })
            .disposed(by: disposeBag)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        self.favoriteRemoveUseCase = nil
    }

}
