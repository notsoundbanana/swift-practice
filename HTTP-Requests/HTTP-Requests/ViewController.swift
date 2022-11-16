//
//  ViewController.swift
//  HTTP-Requests
//
//  Created by Daniil Chemaev on 16.11.2022.
//

import UIKit

class ViewController: UIViewController {

    let session = URLSession.shared
    var posts: [Post] = []


    override func viewDidLoad() {
        super.viewDidLoad()
        
        Task {
            await obtainPosts()
        }
    }

    func obtainPosts() async {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }

        let urlRequest = URLRequest(url: url)
        do {
            let (data, _) = try await URLSession.shared.data(for: urlRequest)
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let response = try decoder.decode([Post].self, from: data)
            print("posts: \(response)")
            

        } catch {
            print("Error: \(String(describing: error))")
        }
    }
}

