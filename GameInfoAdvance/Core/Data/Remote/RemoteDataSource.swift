//
//  RemoteDataSource.swift
//  GameInfoAdvance
//
//  Created by Djaka Permana on 04/07/23.
//

import Foundation
import RxSwift

protocol RemoteDataSourceProtocol {
    func getGames(page: Int, pageSize: Int, search: String) -> Observable<GamesResponse>
    func getGamesDetail(with id: Int) -> Observable<GameDetailResponse>
    func getProfile() -> Observable<Profile>
}

final class RemoteDataSource {
    static let sharedInstance: RemoteDataSource = RemoteDataSource()
}

extension RemoteDataSource: RemoteDataSourceProtocol, APIClient {
    func getGames(page: Int, pageSize: Int, search: String) -> Observable<GamesResponse> {
        return request(
            endpoint: GameInfoEndpoint.games(page: page, pageSize: pageSize, search: search),
            responseModel: GamesResponse.self
        )
    }
    
    func getGamesDetail(with id: Int) -> Observable<GameDetailResponse> {
        return request(
            endpoint: GameInfoEndpoint.gamesDetail(id: id),
            responseModel: GameDetailResponse.self
        )
    }
    
    func getProfile() -> Observable<Profile> {
        return Observable<Profile>.create { observer in
            if let url = Bundle.main.url(forResource: "ProfileResponse", withExtension: "json") {
                do {
                    let data = try Data(contentsOf: url)
                    let decoder = JSONDecoder()
                    let jsonData = try decoder.decode(ProfileResponse.self, from: data)
                    observer.onNext(jsonData.profile)
                    observer.onCompleted()
                } catch {
                    observer.onError(error)
                }
            }
            
            return Disposables.create()
            
        }
    }
}
