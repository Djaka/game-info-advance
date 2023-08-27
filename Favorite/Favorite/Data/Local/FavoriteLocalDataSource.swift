//
//  FavoriteLocalDataSource.swift
//  Favorite
//
//  Created by Djaka Permana on 07/08/23.
//

import Foundation
import Core
import RealmSwift
import RxSwift

public class FavoriteLocalDataSource: LocalDataSource {
    
    public typealias Request = Any
    public typealias Response = FavoriteEntityModel
    
    private let realm: Realm?
    
    public init(realm: Realm?) {
        self.realm = realm
    }
    
    public func get(request: Request?) -> Observable<[FavoriteEntityModel]> {
        return Observable<[FavoriteEntityModel]>.create { observer in
            if let realm = self.realm {
                
                var games: Results<FavoriteEntityModule>?
                
                if let search = request as? String, !search.isEmpty {
                    let keywoard = NSPredicate(format: "name contains[c] '\(String(describing: search))'")
                    games = {
                        realm.objects(FavoriteEntityModule.self)
                    }().filter(keywoard)
                } else {
                    games = {
                        realm.objects(FavoriteEntityModule.self)
                    }()
                }
                
                var favoriteEntityModels: [FavoriteEntityModel] = []
                let favoriteGames = games?.toArray(ofType: FavoriteEntityModule.self)
                favoriteGames?.forEach { favoriteEntity in
                    let favoriteEntityModel = FavoriteEntityModel()
                    favoriteEntityModel.id = favoriteEntity.id
                    favoriteEntityModel.slug = favoriteEntity.slug
                    favoriteEntityModel.name = favoriteEntity.name
                    favoriteEntityModel.released = favoriteEntity.released
                    favoriteEntityModel.backgroundImage = favoriteEntity.backgroundImage
                    favoriteEntityModel.rating = favoriteEntity.rating
                    favoriteEntityModel.parentPlatforms = favoriteEntity.parentPlatforms
                    
                    favoriteEntityModels.append(favoriteEntityModel)
                }
                
                observer.onNext(favoriteEntityModels)
                observer.onCompleted()
            } else {
                observer.onError(DatabaseError.invalidInstance)
            }
            return Disposables.create()
        }
    }
    
    public func add(entities: FavoriteEntityModel) -> Observable<Bool> {
        return Observable<Bool>.create { observer in
            if let realm = self.realm {
                do {
                    let favoriteEntityModule = FavoriteEntityModule()
                    favoriteEntityModule.id = entities.id
                    favoriteEntityModule.slug = entities.slug
                    favoriteEntityModule.name = entities.name
                    favoriteEntityModule.released = entities.released
                    favoriteEntityModule.backgroundImage = entities.backgroundImage
                    favoriteEntityModule.rating = entities.rating
                    favoriteEntityModule.parentPlatforms = entities.parentPlatforms
                    
                    try realm.write {
                        realm.add(favoriteEntityModule, update: .all)
                    }
                    observer.onNext(true)
                    observer.onCompleted()
                } catch {
                    observer.onError(DatabaseError.errorRequest)
                }
            } else {
                observer.onError(DatabaseError.invalidInstance)
            }
            return Disposables.create()
        }
    }
    
    public func update(request: Request?) -> RxSwift.Observable<Bool> {
        fatalError()
    }
    
    public func delete(request: Request) -> Observable<Bool> {
        return Observable<Bool>.create { observer in
            if let realm = self.realm {
                do {
                    guard let id = request as? Int else {
                        observer.onError(DatabaseError.errorRequest)
                        return Disposables.create()
                    }
                    
                    let favorite = realm.object(ofType: FavoriteEntityModule.self, forPrimaryKey: id)!
                    try realm.write {
                        realm.delete(favorite)
                    }
                    
                    observer.onNext(true)
                    observer.onCompleted()
                } catch {
                    observer.onError(DatabaseError.errorRequest)
                }
            } else {
                observer.onError(DatabaseError.invalidInstance)
            }
            return Disposables.create()
        }
    }
}
