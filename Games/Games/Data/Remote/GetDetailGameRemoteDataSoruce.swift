//
//  GetDetailGameRemoteDataSoruce.swift
//  Games
//
//  Created by Djaka Permana on 05/08/23.
//

import Foundation
import Core
import RxSwift

public class GetDetailGameRemoteDataSoruce: RemoteDataSource, APIClient {
    
    public typealias Request = Int
    public typealias Response = GameDetailResponse
    
    public init(url: String = "", apiKey: String = "") {
        GameAPIConstants.sharedInstance.baseUrl = url
        GameAPIConstants.sharedInstance.apiKey = apiKey
    }
    
    public func execute(request: Int?) -> Observable<GameDetailResponse> {
        let gameDetailEndPoint = GameInfoEndpoint.gamesDetail(id: request ?? 0)
        
        return requestClient(
            endpoint: gameDetailEndPoint,
            responseModel: GameDetailResponse.self
        )
    }
}
