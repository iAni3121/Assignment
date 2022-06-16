//
//  ProjectModel.swift
//  Assignment_MVVM
//
//  Created by Anirudha Kumar on 14/06/22.
//

import Foundation

struct ProjectModel: Codable {
    var id: Int?
    var nodeId: String?
    var name: String?
    var fullName: String?
    var isPrivate: Bool?
    var description: String?
    var isFork: Bool?
    var forkUrl: String?
    var owner: Owner?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case nodeId = "node_id"
        case name = "name"
        case fullName = "full_name"
        case isPrivate = "private"
        case description = "description"
        case isFork = "fork"
        case forkUrl = "forks_url"
        case owner = "owner"
    }
}

struct Owner: Codable {
    
    var login: String?
    var id: Int?
    var nodeId: String?
    var avatarUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case login = "login"
        case id = "id"
        case nodeId = "node_id"
        case avatarUrl = "avatar_url"
    }

}
