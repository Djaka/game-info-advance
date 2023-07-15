//
//  FavoriteUseCase.swift
//  GameInfoAdvance
//
//  Created by Djaka Permana on 05/07/23.
//

import Foundation
import RxSwift

protocol GameFavoriteUseCase {
    func getFavoriteGames() -> Observable<[GameFavoriteModel]>
    func removeFavoriteGame(with id: Int) -> Observable<Bool>
    func searchFavoriteGame(keywoard: String) -> Observable<[GameFavoriteModel]>
}
