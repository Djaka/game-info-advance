//
//  ProfileRemoteDataSourceMock.swift
//  GameInfoAdvanceTest
//
//  Created by Djaka Permana on 27/08/23.
//

import Foundation
import Core
import RxSwift
import Profile

public class ProfileRemoteDataSourceMock: RemoteDataSource {
    
    public typealias Request = Any
    public typealias Response = Profile
    
    public init() {
        
    }
    
    public func execute(request: Request?) -> Observable<Profile> {
        return Observable<Profile>.create { observer in
            do {
                let data = JsonDataFactory.from(fileName: "ProfileResponse", in: .profile)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(ProfileResponse.self, from: data)
                observer.onNext(jsonData.profile)
                observer.onCompleted()
            } catch {
                observer.onError(error)
            }
            
            return Disposables.create()
            
        }
    }
}
