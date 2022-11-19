//
//  DiscoversCollectionViewCell.swift
//  Instagram-cw2
//
//  Created by Daniil Chemaev on 20.11.2022.
//

import UIKit

class DiscoversCollectionViewCell: UICollectionViewCell {

    private var dataTask: URLSessionDataTask?

    private let profilePictureImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 15)
        return label
    }()

    private let infoLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray6
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 13)
        return label
    }()

    private let followButton: UIButton = {
        let button = UIButton()
//        button. = "Follow"
        button.backgroundColor = .blue
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

//        setupView()
        contentView.backgroundColor = .systemRed
    }

    required init?(coder: NSCoder) {
            super.init(coder: coder)

//            setupView()
//            setConstraints()
    }
//
//
//    private func setupView() {
//        addSubview(profilePictureImageView)
////        addSubview(usernameLabel)
////        addSubview(infoLabel)
////        addSubview(followButton)
//    }

//    func configureCell(imageName: String){
//        loadImage(url: URL(string: imageName)!)
//        profilePictureImageView.contentMode = .scaleToFill
//    }
//
//    private func loadImage(url: URL) {
//        profilePictureImageView.image = nil
//        dataTask?.cancel()
//        let urlRequest = URLRequest(
//           url: url,
//           cachePolicy: .reloadIgnoringLocalAndRemoteCacheData
//        )
//        dataTask = URLSession.shared
//           .dataTask(with: urlRequest) { [profilePictureImageView] data, _, _ in
//               guard let data else {
//                   return
//               }
//
//               let image = UIImage(data: data)
//               DispatchQueue.main.async { [profilePictureImageView] in
//                   guard let image else { return }
//                   profilePictureImageView.image = image
//               }
//           }
//        dataTask?.resume()
//    }
//
//    func setConstraints(){
//        NSLayoutConstraint.activate([
//            profilePictureImageView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
//            profilePictureImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
//            profilePictureImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
//            profilePictureImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5)
//        ])
//    }
}
