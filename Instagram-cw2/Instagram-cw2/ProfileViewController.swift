//
//  ProfileViewController.swift
//  Instagram-cw2
//
//  Created by Daniil Chemaev on 19.11.2022.
//

import UIKit

class ProfileViewController: UIViewController {

    private var dataTask: URLSessionDataTask?
    var accountInfo: Response.Account!

    private let profilePicture: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 60
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let followers: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()

    private var discoversCollectionView: UICollectionView!


    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        setupCollectionView()
        setConstraints()
    }

    func setup() {
        navigationItem.title = accountInfo?.user.name

        loadImage(url: (accountInfo?.user.avatar)!)

        followers.text = "followers: \(accountInfo.user.followers)"

        view.backgroundColor = .white

        view.addSubview(profilePicture)
        view.addSubview(followers)

    }

    private func loadImage(url: URL) {
        profilePicture.image = nil
        dataTask?.cancel()
        let urlRequest = URLRequest(
            url: url,
            cachePolicy: .reloadIgnoringLocalAndRemoteCacheData
        )
        dataTask = URLSession.shared
            .dataTask(with: urlRequest) { [profilePicture] data, _, _ in
                guard let data else {
                    return
                }

                let image = UIImage(data: data)
                DispatchQueue.main.async { [profilePicture] in
                    guard let image else { return }
                    profilePicture.image = image
                }
            }
        dataTask?.resume()
    }

    func setConstraints() {
        NSLayoutConstraint.activate([
            profilePicture.topAnchor.constraint(equalTo: view.topAnchor, constant: 120),
            profilePicture.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32),
            profilePicture.heightAnchor.constraint(equalToConstant: 120),
            profilePicture.widthAnchor.constraint(equalToConstant: 120),

            followers.topAnchor.constraint(equalTo: profilePicture.topAnchor),
            followers.leftAnchor.constraint(equalTo: profilePicture.rightAnchor, constant: 20)

        ])
    }
}

extension ProfileViewController: UICollectionViewDataSource, UICollectionViewDelegate {

    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        discoversCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)

        guard let discoversCollectionView = discoversCollectionView else {
            return
        }

        discoversCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        discoversCollectionView.dataSource = self
        discoversCollectionView.delegate = self
        view.addSubview(discoversCollectionView)
        discoversCollectionView.frame = view.bounds
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = discoversCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)

        cell.contentView.backgroundColor = .systemRed
        return cell
    }


}
