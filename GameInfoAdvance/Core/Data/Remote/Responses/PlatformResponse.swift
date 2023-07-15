//
//  PlatformResponse.swift
//  GameInfoAdvance
//
//  Created by Djaka Permana on 04/07/23.
//

import Foundation

enum PlatformImageResponse: String, Codable {
    case desktop = "desktopcomputer"
    case playstation = "logo.playstation"
    case xbox = "logo.xbox"
    case mobile = "iphone"
    case controller = "gamecontroller.fill"
    case web = "globe"
}

struct PlatformResponse: Codable {
    let id: Int?
    let name: String?
    let slug: String?
    
    var imageName: PlatformImageResponse {
        switch slug {
        case "pc", "mac", "linux":
            return .desktop
        case "playstation":
            return .playstation
        case "xbox":
            return .xbox
        case "ios", "android":
            return .mobile
        case "web":
            return .web
        default:
            return .controller
        }
    }
}
