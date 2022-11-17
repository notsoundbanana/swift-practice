//
//  NetworkManager.swift
//  HTTP-Requests
//
//  Created by Daniil Chemaev on 17.11.2022.
//

import Foundation

enum ObtainPostsResult {
    case success(posts: [Post])
    case failure(error: Error)
}

@MainActor
class NetworkManager {

    let session = URLSession.shared
    let decoder = JSONDecoder()

    func obtainPosts(completion: @escaping (ObtainPostsResult) -> Void) async {

        var result: ObtainPostsResult

        defer {  // Обработка результата в конце
            DispatchQueue.main.async {
                completion(result)
            }
        }

        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {
            result = .success(posts: [])
            return
        }

        let urlRequest = URLRequest(url: url)
        do {
            let (data, _) = try await URLSession.shared.data(for: urlRequest)
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let response = try decoder.decode([Post].self, from: data)

            result = .success(posts: response)
        } catch {
            result = .failure(error: error)
        }

        completion(result)
    }
}
