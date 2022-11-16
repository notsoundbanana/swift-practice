//
//  TableViewCell.swift
//  Json-parser
//
//  Created by Daniil Chemaev on 15.11.2022.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet private var customImageView: UIImageView!
    @IBOutlet private var customTextLabel: UILabel!

    var loadingTask: Task<Void, Never>?

    func set(text: String, imageUrl: URL) {
        customTextLabel.text = text
        loadingTask?.cancel()
        loadingTask = Task {
            await loadImage(url: imageUrl)
        }
    }

    private func loadImage(url: URL) async {
        customImageView.image = nil
        let urlRequest = URLRequest(
            url: url,
            cachePolicy: .reloadIgnoringLocalAndRemoteCacheData
        )
        do {
            let (data, _) = try await URLSession.shared.data(for: urlRequest)
            guard !Task.isCancelled else { return }
            customImageView.image = UIImage(data: data)
        } catch {
            print("could not load image")
        }
    }
}
