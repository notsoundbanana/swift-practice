//
//  NoteService.swift
//  UserDefaults
//
//  Created by Daniil Chemaev on 09.12.2022.
//

import UIKit

enum NoteServiceError: Error {
    case fileNotFound
    case couldNotReadFile
    case couldNotCreateFileName
    case couldNotCreateImageData
}

class NoteService {
    private let fileManager: FileManager
    private let documentsDirectory: URL
    private let imageExtension: String = "png"

    init() {
        fileManager = .default

        guard let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
            fatalError("Could not load documents directory")
        }
        self.documentsDirectory = documentsDirectory
        print("Initialized documents directory at \(documentsDirectory.path())")
    }

    func notesList() throws -> [String] {
        try fileManager.contentsOfDirectory(at: documentsDirectory, includingPropertiesForKeys: nil)
            .map { $0.deletingPathExtension().lastPathComponent }
    }

    func save(image: UIImage, fileName: String) throws {
        guard let data = image.pngData() else {
            throw NoteServiceError.couldNotCreateImageData
        }
        guard let imageTitle = encode(string: "\(fileName).\(imageExtension)") else {
            throw NoteServiceError.couldNotCreateFileName
        }

        let path = documentsDirectory.appending(path: imageTitle).path()
        fileManager.createFile(atPath: path, contents: data)
    }

    func getPhoto(fileName: String) throws -> UIImage {
        let path = documentsDirectory.appending(path: "\(fileName).\(imageExtension)").path()
        guard fileManager.fileExists(atPath: path) else {
            throw NoteServiceError.fileNotFound
        }

        guard let data = fileManager.contents(atPath: path) else {
            throw NoteServiceError.couldNotReadFile
        }
        return  UIImage(data: data)!
    }

    private func encode(string: String) -> String? {
        string.addingPercentEncoding(
            withAllowedCharacters: .init(charactersIn: " ()")
                .union(.urlPathAllowed)
        )
    }
}

