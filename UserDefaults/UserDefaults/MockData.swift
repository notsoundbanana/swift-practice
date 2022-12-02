//
//  Data.swift
//  UserDefaults
//
//  Created by Daniil Chemaev on 02.12.2022.
//
import Foundation

enum UserDefaultKeys {
    static let notes = "notes"
}

class MockData {
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    private let userDefaults = UserDefaults.standard

    func add(note: Note) {
        if let objectByKey = userDefaults.object(forKey: UserDefaultKeys.notes) as? Data {
            guard var notes = try? decoder.decode([Note].self, from: objectByKey) else { return }

            notes.append(note)

            let jsonData = try! encoder.encode(notes)
            userDefaults.set(jsonData, forKey: UserDefaultKeys.notes)
        }
        else {
            let jsonData = try! encoder.encode([note])
            userDefaults.set(jsonData, forKey: UserDefaultKeys.notes)

        }
    }

    func edit(note: Note, index: Int) {
        print(index)
        if let objectByKey = userDefaults.object(forKey: UserDefaultKeys.notes) as? Data {
            guard var notes = try? decoder.decode([Note].self, from: objectByKey) else { return }
            print(note)

            notes[index] = note

            let jsonData = try! encoder.encode(notes)
            userDefaults.set(jsonData, forKey: UserDefaultKeys.notes)
        }
    }

    func set(allNotes: [Note]) {
        let jsonData = try! encoder.encode(allNotes)
        UserDefaults.standard.set(jsonData, forKey: UserDefaultKeys.notes)
    }
}
