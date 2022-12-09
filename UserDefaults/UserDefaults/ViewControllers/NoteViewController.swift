//
//  NoteViewController.swift
//  UserDefaults
//
//  Created by Daniil Chemaev on 29.11.2022.
//

import UIKit

class NoteViewController: UIViewController {

    private let mockData = MockData()
    public var note: Note?
    public var index: Int?

    private let titleTextField: UITextField = {
        let textField = UITextField.init(frame: .zero)
        textField.placeholder = "Title"
        textField.font = UIFont.systemFont(ofSize: 25)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private let saveButton = UIBarButtonItem.init(title: "Save", style: .plain, target: Any?.self, action: #selector(saveButtonDidTap))

    @objc func saveButtonDidTap(_ sender: UIButton!) {
        guard let title = titleTextField.text, let content = noteTextView.text else { return }

        if note == nil {
            let creationDate = "\(NSDate.now)"
            note = Note(type: noteType.noteWithText.rawValue, title: title, content: content, creationDate: creationDate)
            mockData.add(note: note!)
        }
        else {
            note!.title = title
            note!.content = content
            mockData.edit(note: note!, index: index!)
        }

        _ = navigationController?.popViewController(animated: true)
    }

    private let noteTextView: UITextView = {
        let textView = UITextView.init(frame: .zero)
        textView.font = UIFont.systemFont(ofSize: 15)
        textView.backgroundColor = .systemGray6
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setConstraints()

        if let note {
            titleTextField.text = note.title
            noteTextView.text = note.content
        }
    }

    func setupUI() {
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.rightBarButtonItem = saveButton
        view.backgroundColor = .systemGray6

        view.addSubview(titleTextField)
        view.addSubview(noteTextView)
    }

    func setConstraints() {
        NSLayoutConstraint.activate([
            titleTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            titleTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            titleTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),

            noteTextView.leadingAnchor.constraint(equalTo: titleTextField.leadingAnchor),
            noteTextView.trailingAnchor.constraint(equalTo: titleTextField.trailingAnchor),
            noteTextView.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 10),
            noteTextView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])
    }

}
