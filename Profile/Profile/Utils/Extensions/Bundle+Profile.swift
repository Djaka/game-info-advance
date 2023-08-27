//
//  Bundle+Profile.swift
//  Profile
//
//  Created by Djaka Permana on 13/08/23.
//

import Foundation

private final class ProfileModule {

    public static var bundle: Bundle {
        return Bundle(for: self)
    }
}

extension Bundle {
    public static var profile: Bundle {
        return ProfileModule.bundle
    }
}
