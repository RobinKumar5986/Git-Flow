//
//  Users.swift
//  Git Follow
//
//  Created by iOS Dev on 26/12/25.
//

import Foundation

class Users: Codable {
    var login: String
    var avatarUrl: String
    var name: String?
    var location: String?
    var bio: String?
    var publicRepos: Int
    var publicGists: Int
    var following: Int
    var followers: Int
    var htmlUrl: String //this is the public profile
    var createdAt: Date
}
