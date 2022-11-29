//
//  NoteViewController.swift
//  UserDefaults
//
//  Created by Daniil Chemaev on 29.11.2022.
//

import UIKit

class NoteViewController: UIViewController {

    private let titleTextField: UITextField = {
        let textField = UITextField.init(frame: .zero)
        textField.placeholder = "Title"
        textField.font = UIFont.systemFont(ofSize: 18)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private let saveButton: UIButton = {
        let button = UIButton.init(type: .system)
        button.setTitle("Save", for: .normal)
        button.widthAnchor.constraint(equalToConstant: 50).isActive = true
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.tintColor = .systemBlue
        button.backgroundColor = .systemGray5
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private var titleStackView = UIStackView()

    private let noteTextView: UITextView = {
        let textView = UITextView.init(frame: .zero)
        textView.font = UIFont.systemFont(ofSize: 15)
        textView.backgroundColor = .systemGray6
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never

        setupUI()
        setConstraints()
    }

    func setupUI() {
        view.backgroundColor = .systemGray6
        view.addSubview(noteTextView)
    }

    func setConstraints() {
        titleStackView = UIStackView(
            arrangedSubviews: [titleTextField, saveButton]
        )
        titleStackView.axis = .horizontal
        titleStackView.spacing = 10
        titleStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleStackView)

        NSLayoutConstraint.activate([
            titleStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            titleStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            titleStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),

            noteTextView.leadingAnchor.constraint(equalTo: titleStackView.leadingAnchor),
            noteTextView.trailingAnchor.constraint(equalTo: titleStackView.trailingAnchor),
            noteTextView.topAnchor.constraint(equalTo: titleStackView.bottomAnchor, constant: 10),
            noteTextView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])
    }

}
