//
//  NoteWithPhotoViewController.swift
//  UserDefaults
//
//  Created by Daniil Chemaev on 08.12.2022.
//


import UIKit
import PhotosUI

class NoteWithPhotoViewController: UIViewController {

    private let mockData = MockData()
    private let noteService = NoteService()
    public var note: Note?
    public var index: Int?

    private let saveButton = UIBarButtonItem.init(title: "Save", style: .plain, target: Any?.self, action: #selector(saveButtonDidTap))
    private let addPhotoButton = UIBarButtonItem.init(title: "Add photo", style: .plain, target: Any?.self, action: #selector(addPhotoButtonDidTap))

    private let titleTextField: UITextField = {
        let textField = UITextField.init(frame: .zero)
        textField.placeholder = "Title"
        textField.font = UIFont.systemFont(ofSize: 25)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setConstraints()

        if let note {
            titleTextField.text = note.title
            try? imageView.image = noteService.getPhoto(fileName: (note.fileName)!)
        }
    }

    func setupUI() {
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.rightBarButtonItems = [saveButton, addPhotoButton]
        view.backgroundColor = .systemGray6

        view.addSubview(titleTextField)
        view.addSubview(imageView)
    }

    func setConstraints() {
        NSLayoutConstraint.activate([
            titleTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            titleTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            titleTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            titleTextField.bottomAnchor.constraint(equalTo: imageView.topAnchor, constant: -10),

            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: view.frame.width),
            imageView.heightAnchor.constraint(equalToConstant: 600)
        ])
    }

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

                let image = imageView.image!

                if note == nil {
                    let creationDate = "\(NSDate.now)"
                    let fileName = UUID().uuidString
                    note = Note(type: noteType.noteWithPhoto.rawValue, title: title, content: content, fileName: fileName, creationDate: creationDate)
                    mockData.add(note: note!)
                }
                else {
                    note!.title = title
                    note!.content = content
                    mockData.edit(note: note!, index: index!)
                }

                try? noteService.save(image: image, fileName: (note!.fileName)!)

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
        var configuration = PHPickerConfiguration()
        configuration.selectionLimit = 1
        configuration.filter = .images
        let phPicker = PHPickerViewController(configuration: configuration)
        phPicker.delegate = self
        present(phPicker, animated: true)
    }
}

extension NoteWithPhotoViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)

        results.forEach { result in
            print("Asset identifier: \(result.assetIdentifier ?? "none")")
            result.itemProvider.loadObject(ofClass: UIImage.self) { [self] reading, error in
                if let error {
                    print("Got error loading image: \(error)")
                } else if let image = reading as? UIImage {
                    DispatchQueue.main.async { [self] in
                        imageView.image = image
                    }
                }
            }
        }
    }
}


