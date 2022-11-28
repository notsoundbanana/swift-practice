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

    private let statusLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()

    private let postsLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()

    private let followersLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()

    private let followingLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()

    private let editProfileButton: UIButton = {
        let button = UIButton.init(type: .system)
        button.setTitle("Edit Profile", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        button.backgroundColor = .systemGray6
        button.tintColor = .black
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let addAccountButton: UIButton = {
        let button = UIButton.init(type: .system)
        button.setImage(UIImage(systemName: "person.badge.plus"), for: .normal)
        button.widthAnchor.constraint(equalToConstant: 40).isActive = true
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        button.backgroundColor = .systemGray6
        button.tintColor = .black
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    var buttonStackView = UIStackView()

    private let discoverPeopleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "Discover people"
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let seeAllButton: UIButton = {
        let button = UIButton.init(type: .system)
        button.setTitle("See all", for: .normal)
        button.widthAnchor.constraint(equalToConstant: 50).isActive = true
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.tintColor = .systemBlue
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    var discoverStackView = UIStackView()

    private var discoversCollectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.backgroundColor = .systemGray6
        collectionView.bounces = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()


    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        setConstraints()
        setupCollectionView()
    }

    func setup() {
        view.backgroundColor = .systemGray6
        navigationItem.title = accountInfo?.user.name
        navigationController!.navigationBar.tintColor = .black;

        loadImage(url: (accountInfo?.user.avatar)!)

        statusLabel.text = accountInfo.user.status
        postsLabel.text = "Posts: \(accountInfo.user.posts)"
        followersLabel.text = "Followers: \(accountInfo.user.followers)"
        followingLabel.text = "Following: \(accountInfo.user.following)"

        view.addSubview(profilePicture)
        view.addSubview(statusLabel)
        view.addSubview(postsLabel)
        view.addSubview(followersLabel)
        view.addSubview(followingLabel)

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
        buttonStackView = UIStackView(
            arrangedSubviews: [editProfileButton, addAccountButton]
        )
        buttonStackView.axis = .horizontal
        buttonStackView.spacing = 10
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buttonStackView)

        discoverStackView = UIStackView(
            arrangedSubviews: [discoverPeopleLabel, seeAllButton]
        )
        discoverStackView.axis = .horizontal
        discoverStackView.spacing = 10
        discoverStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(discoverStackView)

        NSLayoutConstraint.activate([
            profilePicture.topAnchor.constraint(equalTo: view.topAnchor, constant: 120),
            profilePicture.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15),
            profilePicture.heightAnchor.constraint(equalToConstant: 120),
            profilePicture.widthAnchor.constraint(equalToConstant: 120),

            statusLabel.topAnchor.constraint(equalTo: profilePicture.bottomAnchor, constant: 10),
            statusLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            statusLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),

            buttonStackView.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 15),
            buttonStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15),
            buttonStackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15),
            buttonStackView.heightAnchor.constraint(equalToConstant: 40),

            discoverStackView.topAnchor.constraint(equalTo: buttonStackView.bottomAnchor, constant: 15),
            discoverStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15),
            discoverStackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15),
            discoverStackView.heightAnchor.constraint(equalToConstant: 40),

            postsLabel.topAnchor.constraint(equalTo: profilePicture.topAnchor, constant: 20),
            postsLabel.leftAnchor.constraint(equalTo: profilePicture.rightAnchor, constant: 20),

            followersLabel.topAnchor.constraint(equalTo: postsLabel.bottomAnchor, constant: 5),
            followersLabel.leftAnchor.constraint(equalTo: profilePicture.rightAnchor, constant: 20),

            followingLabel.topAnchor.constraint(equalTo: followersLabel.bottomAnchor, constant: 5),
            followingLabel.leftAnchor.constraint(equalTo: profilePicture.rightAnchor, constant: 20)

        ])
    }
}

extension ProfileViewController: UICollectionViewDataSource, UICollectionViewDelegate {

    private func setupCollectionView() {
        view.addSubview(discoversCollectionView)
        discoversCollectionView.register(DiscoversCollectionViewCell.self, forCellWithReuseIdentifier: "DiscoversCollectionViewCell")
        setCollectionViewConstraints()
        discoversCollectionView.dataSource = self
        discoversCollectionView.delegate = self

    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        100
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = discoversCollectionView.dequeueReusableCell(withReuseIdentifier: "DiscoversCollectionViewCell", for: indexPath)
//        cell.configureCell(imageName: self.dataTask[indexPath.row])
        
        return cell
    }

    func setCollectionViewConstraints(){
        NSLayoutConstraint.activate([
            discoversCollectionView.topAnchor.constraint(equalTo: discoverStackView.bottomAnchor),
            discoversCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            discoversCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 5),
            discoversCollectionView.bottomAnchor.constraint(equalTo: discoversCollectionView.topAnchor, constant: 200)
        ])
    }


}
