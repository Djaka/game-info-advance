//
//  ProfileLocalDataSource.swift
//  Profile
//
//  Created by Djaka Permana on 13/08/23.
//

import Foundation
import Core
import RxSwift
import RealmSwift

public class ProfileLocalDataSource: LocalDataSource {
    
    public typealias Request = Any
    public typealias Response = ProfileEntityModel
    
    private let realm: Realm?
    
    public init(realm: Realm?) {
        self.realm = realm
    }
    
    public func add(entities: ProfileEntityModel) -> RxSwift.Observable<Bool> {
            return Observable<Bool>.create { observer in
                if let realm = self.realm {
                    do {
                        let profileEntity = ProfileEntity()
                        profileEntity.id = entities.id
                        profileEntity.author = entities.author
                        profileEntity.email = entities.email
                        profileEntity.currentJob = entities.currentJob
                        profileEntity.contents = entities.contents
                        profileEntity.authorImage = entities.authorImage
    
                        try realm.write {
                            realm.add(profileEntity, update: .all)
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
    
    public func get(request: Request?) -> RxSwift.Observable<[ProfileEntityModel]> {
        
        return Observable<[ProfileEntityModel]>.create{observer in
            if let realm = self.realm {
                
                let profiles: Results<ProfileEntity> = {
                    realm.objects(ProfileEntity.self)
                }()
                
                var profilesEntityModel: [ProfileEntityModel] = []
                let newProfile = profiles.toArray(ofType: ProfileEntity.self)
                newProfile.forEach{ profileEntity in
                    let profileEntityModel = ProfileEntityModel()
                    profileEntityModel.id = profileEntity.id
                    profileEntityModel.author = profileEntity.author
                    profileEntityModel.email = profileEntity.email
                    profileEntityModel.currentJob = profileEntity.currentJob
                    profileEntityModel.contents = profileEntity.contents
                    profileEntityModel.authorImage = profileEntity.authorImage
                    
                    profilesEntityModel.append(profileEntityModel)
                }
                
                observer.onNext(profilesEntityModel)
                observer.onCompleted()
            } else {
                observer.onError(DatabaseError.invalidInstance)
            }
            return Disposables.create()
        }
    }
    
    public func update(request: Request?) -> Observable<Bool> {
        
        return Observable<Bool>.create { observer in
            if let realm = self.realm {
                do {
                    guard let params = request as? ProfileEntityModel else {
                        observer.onError(DatabaseError.errorRequest)
                        return Disposables.create()
                    }
                    
                    guard let profileEntity = realm.object(ofType: ProfileEntity.self, forPrimaryKey: params.id ) else {
                        observer.onError(DatabaseError.invalidInstance)
                        return Disposables.create()
                    }
                    
                    try realm.write {
                        profileEntity.author = params.author
                        profileEntity.email = params.email
                        profileEntity.currentJob = params.currentJob
                        profileEntity.contents = params.contents
                        profileEntity.authorImage = params.authorImage
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
    
    public func delete(request: Request) -> Observable<Bool> {
        return Observable<Bool>.create{ observer in
            if let realm = self.realm {
                do {
                    guard let id = request as? Int else {
                        observer.onError(DatabaseError.errorRequest)
                        return Disposables.create()
                    }
                    
                    if let game = realm.object(ofType: ProfileEntity.self, forPrimaryKey: id) {
                        
                        try realm.write {
                            realm.delete(game)
                        }
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
