//
//  ViewController.swift
//  SplitView
//
//  Created by Egor Devyatov on 06.08.2019.
//  Copyright © 2019 Egor Devyatov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var titleTextEdit: UITextField!
    
    @IBOutlet weak var subtitleTextEdit: UITextField!
    
    @IBOutlet weak var imageView: UIImageView!
    
    private lazy var imagePicker = ImagePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let bundlePath = Bundle.main.bundlePath
        print("Bundle path = \(bundlePath)")
        
        imagePicker.delegate = self
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "camera",
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(cameraButtonTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "photo",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(photoButtonTapped))
    
    }
    
    private func presentImagePicker(sourceType: UIImagePickerController.SourceType) {
        imagePicker.present(parent: self, sourceType: sourceType)
    }
    
    @objc func photoButtonTapped(_ sender: UIButton) { imagePicker.photoGalleryAccessRequest() }
    @objc func cameraButtonTapped(_ sender: UIButton) { imagePicker.cameraAccessRequest() }


    
    
//        let photoImageView: UIImageView = {
//            let iv = UIImageView()
//
//            // Set image with image literal
//            // iv.image = #imageLiteral(resourceName: "feedback")
//            iv.image = #imageLiteral(resourceName: "belka1")
//            return iv
//        }()
//        photoImage.image = #imageLiteral(resourceName: "belka1")
//}
    
    // отслеживаем положение устройства compact или нет
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        if traitCollection.horizontalSizeClass == .compact {
            print("trait = compact")
        } else {
            print("trait = wide (regular)")
        }
    }
    
    // по тапу на конпку сохранить
    @IBAction func saveButtonTap(_ sender: UIButton) {
        let newPhoto = Photo(title: titleTextEdit.text!, subtitle: subtitleTextEdit.text!)
        addNewPhoto(newPhoto: newPhoto)
        navigationController?.popToRootViewController(animated: true)
    }
    
    public func addNewPhoto(newPhoto: Photo) {
        let newPhoto = Photo(title: titleTextEdit.text!, subtitle: subtitleTextEdit.text!)
        data.append(newPhoto)
    }
   
}


extension ViewController: ImagePickerDelegate {
    
    func imagePickerDelegate(didSelect image: UIImage, delegatedForm: ImagePicker) {
        imageView.image = image
        imagePicker.dismiss()
    }
    
    func imagePickerDelegate(didCancel delegatedForm: ImagePicker) { imagePicker.dismiss() }
    
    func imagePickerDelegate(canUseGallery accessIsAllowed: Bool, delegatedForm: ImagePicker) {
        if accessIsAllowed { presentImagePicker(sourceType: .photoLibrary) }
    }
    
    func imagePickerDelegate(canUseCamera accessIsAllowed: Bool, delegatedForm: ImagePicker) {
        // works only on real device (crash on simulator)
        //if accessIsAllowed { presentImagePicker(sourceType: .camera)
        // я использую симулятор посему пишем так
        if accessIsAllowed { presentImagePicker(sourceType: .photoLibrary)
    }
    }
}
