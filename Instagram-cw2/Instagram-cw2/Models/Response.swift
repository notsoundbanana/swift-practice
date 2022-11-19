//
//  Discovers.swift
//  Instagram-cw2
//
//  Created by Daniil Chemaev on 19.11.2022.
//

import Foundation

struct Response: Codable {

    struct Account: Codable {
        struct User: Codable {
            let status: String
            let posts: Int
            let followers: Int
            let name: String
            let following: Int
            let avatar: URL
        }

        struct Discovers: Codable {
            let followingFriends: [String]
            let kind: String
            let name: String
            let avatar: URL
        }

        let user: User
        let discovers: [Discovers]
    }

    var accounts: [Account]

}
