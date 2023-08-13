//
//  GetListGameRemoteDataSource.swift
//  Games
//
//  Created by Djaka Permana on 05/08/23.
//

import Foundation
import Core
import RxSwift

public class GetListGameRemoteDataSource: RemoteDataSource, APIClient {
    
    public typealias Request = GameParameterRequest
    public typealias Response = GamesResponse
    
    public init(url: String = "", apiKey: String = "") {
        GameAPIConstants.sharedInstance.baseUrl = url
        GameAPIConstants.sharedInstance.apiKey = apiKey
    }
    
    public func execute(request: GameParameterRequest?) -> Observable<GamesResponse> {
        
        let gameEndPoint = GameInfoEndpoint.games(
            page: request?.page ?? 0,
            pageSize: request?.pageSize ?? 0,
            search: request?.search ?? ""
        )
        
        return requestClient(
            endpoint: gameEndPoint,
            responseModel: GamesResponse.self
        )
    }
    
}
