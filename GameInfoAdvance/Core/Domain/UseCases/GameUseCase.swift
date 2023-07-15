//
//  GameUseCase.swift
//  GameInfoAdvance
//
//  Created by Djaka Permana on 05/07/23.
//

import Foundation
import RxSwift

protocol GameUseCase {
    func getGames(page: Int, pageSize: Int, search: String) -> Observable<[GameModel]>
    func addFavoriteGame(_ gameModel: GameModel) -> Observable<Bool>
    func removeFavoriteGame(with id: Int) -> Observable<Bool>
}
