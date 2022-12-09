//
//  NoteWithPhotoViewController.swift
//  UserDefaults
//
//  Created by Daniil Chemaev on 08.12.2022.
//


import UIKit

class NoteWithPhotoViewController: UIViewController {

    private let mockData = MockData()
    public var note: Note?
    public var index: Int?

    private let titleTextField: UITextField = {
        let textField = UITextField.init(frame: .zero)
        textField.placeholder = "Title"
        textField.font = UIFont.systemFont(ofSize: 18)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private let saveButton = UIBarButtonItem.init(title: "Save", style: .plain, target: Any?.self, action: #selector(saveButtonDidTap))
    private let addPhotoButton = UIBarButtonItem.init(title: "Add photo", style: .plain, target: Any?.self, action: #selector(addPhotoButtonDidTap))

    @objc func saveButtonDidTap(_ sender: UIButton!) {

        if imageView.image != nil {

            let alertController = UIAlertController(title: "New Note", message: "Name the image", preferredStyle: .alert)

            alertController.addTextField { [self] (textField) in
                textField.placeholder = "Name"
                if let note {
                    textField.text = note.content
                }
            }

            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            let saveAction = UIAlertAction(title: "Save", style: .default) { [self] _ in

                let inputName = alertController.textFields![0].text

                guard let title = titleTextField.text, let content = inputName else { return }

                if note == nil {
                    let creationDate = "\(NSDate.now)"
                    note = Note(type: noteType.noteWithPhoto.rawValue, title: title, content: content, creationDate: creationDate)
                    mockData.add(note: note!)
                }
                else {
                    note!.title = title
                    note!.content = content
                    mockData.edit(note: note!, index: index!)
                }

                _ = navigationController?.popViewController(animated: true)

            }

            alertController.addAction(cancelAction)
            alertController.addAction(saveAction)

            present(alertController, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Alert", message: "Add photo", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default))
            self.present(alert, animated: true, completion: nil)
            return
        }
    }

    @objc func addPhotoButtonDidTap(_ sender: UIButton!) {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }

    private var titleStackView = UIStackView()

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setConstraints()

        if let note {
            titleTextField.text = note.title
//            noteTextView.text = note.content
        }
    }

    func setupUI() {
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.rightBarButtonItems = [saveButton, addPhotoButton]
        view.backgroundColor = .systemGray6

        view.addSubview(imageView)
    }

    func setConstraints() {
        titleStackView = UIStackView(
            arrangedSubviews: [titleTextField]
        )
        titleStackView.axis = .horizontal
        titleStackView.translatesAutoresizingMaskIntoConstraints = false

        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleStackView)

        NSLayoutConstraint.activate([
            titleStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            titleStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            titleStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),

            imageView.leadingAnchor.constraint(equalTo: titleStackView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: titleStackView.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: titleStackView.bottomAnchor, constant: 10),
            imageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])
    }

}

extension NoteWithPhotoViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
            imageView.image = image
        }
        picker.dismiss(animated: true, completion: nil)

    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

