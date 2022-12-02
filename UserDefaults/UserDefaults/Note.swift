//
//  Note.swift
//  UserDefaults
//
//  Created by Daniil Chemaev on 29.11.2022.
//

import UIKit

//protocol NoteDefaultable {
//    var storedValue: Note { get }
//    init?(storedValue: Note?)
//}
//
struct Note: Codable{
    let title: String
    let content: String
    let creationDate: String
}


//
//extension Note: NoteDefaultable {
//    var storedValue: Note {self}
//
//    init?(storedValue: Note?) {
//        if let note = storedValue {
//            self = note
//        }
//        else{
//            return nil
//        }
//    }
//
////    var storedValue: Any {
////        [
////            "title": title,
////            "content": content,
////            "creationDate": creationDate
////        ]
////    }
//
////    init?(storedValue: Any?) {
////        guard
////            let dictionary = storedValue as? [String: String],
////            let title = dictionary["title"],
////            let content = dictionary["content"],
////            let creationDate = dictionary["creationDate"]
////        else { return nil }
////
////        self.title = title
////        self.content = content
////        self.creationDate = creationDate
////    }
//}
//
//@propertyWrapper
//struct UserDefault<T: NoteDefaultable> {
//    var wrappedValue: T? {
//        get {
//            T(storedValue: UserDefaults.value(forKey: key) as? Note)
//        }
//        set {
//            if let newValue {
//                UserDefaults.standard.set(newValue.storedValue, forKey: key)
//            } else {
////                var notes = UserDefaults.standard.value(forKey: key) as! [Note]
//                UserDefaults.standard.removeObject(forKey: key)
//            }
//        }
//    }
//
//    private let key: String
//
//    init(key: String) {
//        self.key = key
//    }
//}
