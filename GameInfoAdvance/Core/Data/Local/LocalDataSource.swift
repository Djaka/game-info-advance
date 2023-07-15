//
//  LocalDataSource.swift
//  GameInfoAdvance
//
//  Created by Djaka Permana on 04/07/23.
//

import Foundation
import RealmSwift
import RxSwift

protocol LocalDataSourceProtocol: AnyObject {
    func getFavoriteGames() -> Observable<[GameEntity]>
    func addFavoriteGame(from game: GameEntity) -> Observable<Bool>
    func deleteFavoriteGame(by id: Int) -> Observable<Bool>
    func getFavoriteGame(keywoard: String) -> Observable<[GameEntity]>
}

protocol PreferenceSourceProtocol {
    func updateProfile(from profile: ProfileModel) -> Observable<Bool>
    func getProfile() -> Observable<ProfileCacheModel?>
}

class LocalDataSource {
    private let realm: Realm?
    private let profilePreference: ProfilePreference
    
    private init(realm: Realm?, profilePreference: ProfilePreference = ProfilePreference.sharedInstance) {
        self.realm = realm
        self.profilePreference = profilePreference
    }
    
    static let sharedInstance: (Realm?) -> LocalDataSource = { realmDatabase in
        return LocalDataSource(realm: realmDatabase)
    }
}

extension LocalDataSource: LocalDataSourceProtocol {
    
    func getFavoriteGames() -> Observable<[GameEntity]> {
        
        return Observable<[GameEntity]>.create{ observer in
            if let realm = self.realm {
                let categories: Results<GameEntity> = {
                    realm.objects(GameEntity.self)
                }()
                
                observer.onNext(categories.toArray(ofType: GameEntity.self))
                observer.onCompleted()
            } else {
                observer.onError(DatabaseError.invalidInstance)
            }
            return Disposables.create()
        }
    }
    
    func addFavoriteGame(from game: GameEntity) -> Observable<Bool> {
        return Observable<Bool>.create { observer in
            if let realm = self.realm {
                do {
                    try realm.write {
                        realm.add(game, update: .all)
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
    
    func deleteFavoriteGame(by id: Int) -> RxSwift.Observable<Bool> {
        return Observable<Bool>.create{ observer in
            if let realm = self.realm {
                do {
                    
                    let game = realm.object(ofType: GameEntity.self, forPrimaryKey: id)!
                    try realm.write {
                        realm.delete(game)
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
    
    func getFavoriteGame(keywoard: String) -> Observable<[GameEntity]> {
        return Observable<[GameEntity]>.create{ observer in
            if let realm = self.realm {
                
                let search = NSPredicate(format: "name contains[c] '\(keywoard)'")

                let categories: Results<GameEntity> = {
                    realm.objects(GameEntity.self)
                }().filter(search)

                observer.onNext(categories.toArray(ofType: GameEntity.self))
                observer.onCompleted()
            } else {
                observer.onError(DatabaseError.invalidInstance)
            }
            return Disposables.create()
        }
    }
}

extension LocalDataSource: PreferenceSourceProtocol {
    func updateProfile(from profile: ProfileModel) -> Observable<Bool> {
        
        return Observable<Bool>.create { observer in
            self.profilePreference.imageProfileDefault = profile.authorImage ?? ""
            self.profilePreference.authorDefault = profile.author ?? ""
            self.profilePreference.emailDefault = profile.email ?? ""
            self.profilePreference.currentJobDefault = profile.currentJob ?? ""
            self.profilePreference.descriptionDefault = profile.description ?? ""
            self.profilePreference.loadFirstDefault = true
            
            observer.onNext(true)
            observer.onCompleted()
            
            return Disposables.create()
        }
    }
    
    func getProfile() -> Observable<ProfileCacheModel?> {
        return Observable<ProfileCacheModel?>.create { observer in
            if self.profilePreference.loadFirstDefault {
                let profileCacheModel = ProfileCacheModel(
                    author: self.profilePreference.authorDefault,
                    email: self.profilePreference.emailDefault,
                    currentJob: self.profilePreference.currentJobDefault,
                    description: self.profilePreference.descriptionDefault,
                    authorImage: self.profilePreference.imageProfileDefault
                )
                observer.onNext(profileCacheModel)
            } else {
                observer.onNext(nil)
            }
            observer.onCompleted()
            return Disposables.create()
        }
    }
}
