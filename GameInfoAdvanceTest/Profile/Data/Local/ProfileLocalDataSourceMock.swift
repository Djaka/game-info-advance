//
//  ProfileLocalDataSourceMock.swift
//  GameInfoAdvanceTest
//
//  Created by Djaka Permana on 27/08/23.
//

import Foundation
import Core
import Profile
import RxSwift
import RealmSwift

public class ProfileLocalDataSourceMock: LocalDataSource {
    
    public typealias Request = Any
    public typealias Response = ProfileEntityModel
    
    public func get(request: Request?) -> Observable<[ProfileEntityModel]> {
        return Observable<[ProfileEntityModel]>.create { observer in
            observer.onNext(getProfilesEntityModel())
            observer.onCompleted()
            
            return Disposables.create()
        }
        
    }
    
    public func add(entities: ProfileEntityModel) -> Observable<Bool> {
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
