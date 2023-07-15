//
//  ProfilePreference.swift
//  GameInfoAdvance
//
//  Created by Djaka Permana on 09/07/23.
//

import Foundation

class ProfilePreference {
    
    static let sharedInstance = ProfilePreference()
    
    let loadFirstKey = "loadFirst"
    let imageProfileKey = "image_profile"
    let authorKey = "author"
    let currentJobKey = "current_jon"
    let emailKey = "email"
    let descriptionKey = "description"
    
    private let userDefaults: UserDefaults
    
    private init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }
    
    var loadFirstDefault: Bool {
        get {
            return userDefaults.bool(forKey: loadFirstKey)
        }
        set {
            userDefaults.set(newValue, forKey: loadFirstKey)
        }
    }
    
    var imageProfileDefault: String {
        get {
            return userDefaults.string(forKey: imageProfileKey) ?? ""
        }
        set {
            userDefaults.set(newValue, forKey: imageProfileKey)
        }
    }
    
    var authorDefault: String {
        get {
            return userDefaults.string(forKey: authorKey) ?? ""
        }
        set {
            userDefaults.set(newValue, forKey: authorKey)
        }
    }
    
    var emailDefault: String {
        get {
            return userDefaults.string(forKey: emailKey) ?? ""
        }
        set {
            userDefaults.set(newValue, forKey: emailKey)
        }
    }
    
    var currentJobDefault: String {
        get {
            return userDefaults.string(forKey: currentJobKey) ?? ""
        }
        set {
            userDefaults.set(newValue, forKey: currentJobKey)
        }
    }
    
    var descriptionDefault: String {
        get {
            return userDefaults.string(forKey: descriptionKey) ?? ""
        }
        set {
            userDefaults.set(newValue, forKey: descriptionKey)
        }
    }
    
    func deleteAll() -> Bool {
        if let domain = Bundle.main.bundleIdentifier {
            userDefaults.removePersistentDomain(forName: domain)
            syncronize()
            return true
        } else {
            return false
        }
    }
    
    func syncronize() {
        userDefaults.synchronize()
    }
}
