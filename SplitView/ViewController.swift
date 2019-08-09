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
    
    @IBOutlet weak var photoImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let bundlePath = Bundle.main.executableURL
        print("Bundle path = \(bundlePath)")
        
//        let photoImageView: UIImageView = {
//            let iv = UIImageView()
//
//            // Set image with image literal
//            // iv.image = #imageLiteral(resourceName: "feedback")
//            iv.image = #imageLiteral(resourceName: "belka1")
//            return iv
//        }()
        photoImage.image = #imageLiteral(resourceName: "belka1")
    }
    
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

