//
//  Post.swift
//  HTTP-Requests
//
//  Created by Daniil Chemaev on 16.11.2022.
//

import Foundation

struct Post: Codable {
    let userId: Int
    let postId: Int
    let title: String
    let body: String

    enum CodingKeys: String, CodingKey {  // When keys in json file != atributes
        case userId
        case postId = "id"
        case title
        case body
    }
}
