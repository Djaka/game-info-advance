//
//  GetDetailGameRemoteDataSourceMock.swift
//  GameInfoAdvanceTest
//
//  Created by Djaka Permana on 27/08/23.
//

import Foundation
import Core
import Games
import RxSwift

public class GetDetailGameRemoteDataSourceMock: RemoteDataSource {
    
    public typealias Request = Int
    public typealias Response = GameDetailResponse
    
    public init() {
        
    }
    
    public func execute(request: Int?) -> Observable<GameDetailResponse> {
        return Observable<GameDetailResponse>.create { observer in
            do {
                let data = JsonDataFactory.from(fileName: "GameDetailNetworkResponse", in: .main)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(GameDetailResponse.self, from: data)
                observer.onNext(jsonData)
                observer.onCompleted()
            } catch {
                observer.onError(error)
            }
            
            return Disposables.create()
        }
    }
}
