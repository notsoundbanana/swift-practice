//
//  Response.swift
//  exam
//
//  Created by Daniil Chemaev on 14.01.2023.
//

import Foundation

struct Response: Codable {
    var teams: [Team]
}

struct Team: Codable {
    let id: String
    let name: String
    let players: [Player]
}
struct Player: Codable {
    let id: String
    let name: String
}

