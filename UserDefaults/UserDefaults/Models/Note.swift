//
//  Note.swift
//  UserDefaults
//
//  Created by Daniil Chemaev on 29.11.2022.
//

import UIKit

enum noteType: String{
    case noteWithText = "noteWithText"
    case noteWithPhoto = "noteWithPhoto"
}

struct Note: Codable {
    var type: String
    var title: String
    var content: String
    let creationDate: String
}
