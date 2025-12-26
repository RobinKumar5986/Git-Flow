//
//  Follower.swift
//  Git Follow
//
//  Created by iOS Dev on 26/12/25.
//

import Foundation

class Follower: Codable {
    let login: String
    let avatarUrl: String //codable convert snake-case to camel-case automatically
}
