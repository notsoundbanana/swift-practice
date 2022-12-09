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
    var fileName: String?
    let creationDate: String

    init(type: String, title: String, content: String, creationDate: String) {
        self.type = type
        self.title = title
        self.content = content
        self.creationDate = creationDate
    }

    init(type: String, title: String, content: String, fileName: String, creationDate: String) {
        self.type = type
        self.title = title
        self.content = content
        self.fileName = fileName
        self.creationDate = creationDate
    }
}
