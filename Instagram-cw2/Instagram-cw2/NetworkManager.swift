//
//  NetworkManager.swift
//  Instagram-cw2
//
//  Created by Daniil Chemaev on 19.11.2022.
//

import Foundation

enum ObtainPostsResult {
    case success(response: Response)
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

        guard let url = URL(string: "https://raw.githubusercontent.com/AZigangaraev/images/main/instagram.json") else {
            result = .failure(error: Error.self as! Error)
            return
        }

        let urlRequest = URLRequest(url: url)
        do {
            let (data, _) = try await URLSession.shared.data(for: urlRequest)
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let response = try decoder.decode(Response.self, from: data)
//            print(response)
            result = .success(response: response)
        } catch {
            result = .failure(error: error)
        }

        completion(result)
    }
}
