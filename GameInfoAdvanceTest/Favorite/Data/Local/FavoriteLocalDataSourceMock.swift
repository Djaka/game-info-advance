//
//  FavoriteLocalDataSourceMock.swift
//  GameInfoAdvanceTest
//
//  Created by Djaka Permana on 27/08/23.
//

import Foundation
import Core
import Favorite
import RxSwift

public class FavoriteLocalDataSourceMock: LocalDataSource {
    
    public typealias Request = Any
    public typealias Response = FavoriteEntityModel
    
    public func get(request: Request?) -> Observable<[FavoriteEntityModel]> {
        return Observable<[FavoriteEntityModel]>.create { observer in
            observer.onNext(getFavoritesModel())
            observer.onCompleted()
            
            return Disposables.create()
        }
        
    }
    
    public func add(entities: FavoriteEntityModel) -> Observable<Bool> {
        return Observable<Bool>.create { observer in
            observer.onNext(true)
            observer.onCompleted()
            
            return Disposables.create()
        }
    }
    
    public func update(request: Request?) -> Observable<Bool> {
        return Observable<Bool>.create { observer in
            observer.onNext(true)
            observer.onCompleted()
            
            return Disposables.create()
        }
    }
    
    public func delete(request: Request) -> Observable<Bool> {
        return Observable<Bool>.create { observer in
            observer.onNext(true)
            observer.onCompleted()
            
            return Disposables.create()
        }
    }
}
