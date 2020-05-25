//
//  SImagePickerViewController.swift
//  
//
//  Created by Alex Nagy on 14/04/2020.
//

import UIKit

open class SImagePickerViewController: SViewController {
    public var imagePickerControllerImage = Bucket(UIImage())
}

extension SImagePickerViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    public func showChooseImageSourceTypeAlertController(photoLibraryActionTitle: String = "Choose a Photo", cameraActionTitle: String = "Take a New Photo", allowsEditing: Bool = true) {
        let photoLibraryAction = UIAlertAction(title: photoLibraryActionTitle, style: .default) { (action) in
            self.showImagePickerController(sourceType: .photoLibrary, allowsEditing: allowsEditing)
        }
        let cameraAction = UIAlertAction(title: cameraActionTitle, style: .default) { (action) in
            self.showImagePickerController(sourceType: .camera, allowsEditing: allowsEditing)
        }
        Alert.show(.actionSheet, title: nil, message: nil, actions: [photoLibraryAction, cameraAction, Alert.cancelAction()], completion: nil)
    }
    
    public func showImagePickerController(sourceType: UIImagePickerController.SourceType, allowsEditing: Bool = true) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.navigationBar.resetTransparencyToDefault()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = allowsEditing
        imagePickerController.sourceType = sourceType
        present(imagePickerController, animated: true, completion: nil)
    }
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            let image = editedImage.withRenderingMode(.alwaysOriginal)
            self.imagePickerControllerImage.value = image
        } else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            let image = originalImage.withRenderingMode(.alwaysOriginal)
            self.imagePickerControllerImage.value = image
        }
        dismiss(animated: true)
    }
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.imagePickerControllerImage.value = self.imagePickerControllerImage.value
        dismiss(animated: true)
    }
    
}
