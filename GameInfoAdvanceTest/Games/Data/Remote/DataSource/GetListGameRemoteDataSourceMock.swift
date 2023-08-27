//
//  GetListGameRemoteDataSource+Ext.swift
//  GameInfoAdvanceTest
//
//  Created by Djaka Permana on 27/08/23.
//

import Foundation
import Core
import Games
import RxSwift

public class GetListGameRemoteDataSourceMock: RemoteDataSource {
    
    public typealias Request = GameParameterRequest
    public typealias Response = GamesResponse
    
    public init() {
        
    }
    
    public func execute(request: GameParameterRequest?) -> Observable<GamesResponse> {
        
        return Observable<GamesResponse>.create { observer in
            
            do {
                let data = JsonDataFactory.from(fileName: "GameListNetworkResponse", in: .main)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(GamesResponse.self, from: data)
                observer.onNext(jsonData)
                observer.onCompleted()
            } catch {
                observer.onError(error)
            }
            
            return Disposables.create()
        }
    }
    
}
