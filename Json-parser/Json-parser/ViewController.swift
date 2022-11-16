//
//  ViewController.swift
//  Json-parser
//
//  Created by Daniil Chemaev on 12.11.2022.
//

import UIKit

class ViewController: UIViewController {
    private let imageView = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()

        loadImage()
    }

    private func loadImage() {
        view.addSubview(imageView)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.leadingAnchor
                .constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor
                .constraint(equalTo: view.trailingAnchor),
            imageView.topAnchor
                .constraint(
                    equalTo: view.safeAreaLayoutGuide.topAnchor,
                    constant: 20
                ),
        ])

        guard
            let imageUrl = URL(
                string: "https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/guinea-pig-1663940975.jpg"
            )
        else { return }

        URLSession.shared
            .dataTask(with: imageUrl) { [self] data, _, _ in
                guard let data else {
                    print("could not load image")
                    return
                }

                let image = UIImage(data: data)
                DispatchQueue.main.async { [self] in
                    guard let image else { return }

                    imageView.image = image
                    imageView.widthAnchor
                        .constraint(
                            equalTo: imageView.heightAnchor,
                            multiplier: image.size.width / image.size.height
                        )
                        .isActive = true
                }
            }
            .resume()
    }

    private func loadGoogle() {
        guard let url = URL(string: "https://google.com/?q=hello") else { return }
        var request = URLRequest(url: url, timeoutInterval: 10)
        request.allowsCellularAccess = false
        let dataTask = URLSession.shared
            .dataTask(with: request) { data, response, error in
                if let error {
                    print("error: \(error)")
                } else if let data {
                    guard let response = response as? HTTPURLResponse else { return }
                    print("data: \(String(data: data, encoding: .windowsCP1251) ?? "Unknown")")
                    print("response: \(response)")
                } else if let response {
                    print("response: \(response)")
                }
            }
        dataTask.resume()
    }
}

