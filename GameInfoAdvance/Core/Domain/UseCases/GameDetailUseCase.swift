//
//  GameDetailUseCase.swift
//  GameInfoAdvance
//
//  Created by Djaka Permana on 05/07/23.
//

import Foundation
import RxSwift

protocol GameDetailUseCase {
    func getGameDetail(with id: Int) -> Observable<GameDetailModel>
    func addFavoriteGame(_ gameDetailModel: GameDetailModel) -> Observable<Bool>
    func removeFavoriteGame(with id: Int) -> Observable<Bool>
}
