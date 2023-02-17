//
//  NetworkManager.swift
//  exam
//
//  Created by Daniil Chemaev on 14.01.2023.
//

import Foundation

enum ObtainPostsResult {
    case success(response: Response)
    case failure(error: Error)
}


@MainActor
class NetworkManager {
    
    let sessionConfiguration = URLSessionConfiguration.default
    let url = "https://raw.githubusercontent.com/AZigangaraev/Exam2022-1/main/var2.json"
    let session = URLSession.shared
    let decoder = JSONDecoder()

    @MainActor
    func obtainData(complition: @escaping ([Team]) -> Void) async {
        guard let url = URL(string: self.url) else { return }

        var result: [Team] = []
        defer {
            complition(result)
        }
        do {
            let (data, _ ) = try await session.data(from: url)
            let parseData = try decoder.decode([Team].self, from: data)
            result = parseData
        } catch {
            print(error)
        }
    }
}
