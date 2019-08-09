//
//  PhotosTVC.swift
//  SplitView
//
//  Created by Egor Devyatov on 06.08.2019.
//  Copyright © 2019 Egor Devyatov. All rights reserved.
//

import UIKit

class PhotosTVC: UITableViewController {
    public var index: Int = 0 // индекс нажатой ячейки
    
    var photos = [Photo]() {
       didSet{
            self.tableView.reloadData()
        }
    }
    
    // предустановки для кастомной сториборды
    private struct Storyboard {
        static let CellReuseIdentifier = "cell"
        static let SegueIdentifierPhoto = "Show Photo"
    }
    
    /// initialize all photos
    func initAllPhotos() {
//        var i: Int = 1
//        for _ in 1...10 {
//            let photo = Photo(title: "Foto " + String(i), subtitle: "Описание " + String(i))
//            photos.append(photo)
//            i += 1
//        }
        let dm = DataModel()
        photos = data
        //print(phot[0])
        //photos = PhotosData()
    }

    override func viewDidLoad() {
        initAllPhotos()
        let hello = "Hello world!"
        print("Hash = \(generate_sha512Hex(inputString: hello))")
        
    }
    
    override func reloadInputViews() {
        initAllPhotos()
    }
    // MARK: - Table view data source
    
    // определяем число ячеек равное числу элементов массива photos
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }
    
    // для каждой ячейки в таблице получаем ячейку
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: Storyboard.CellReuseIdentifier, for: indexPath as IndexPath)
        let photo = photos[indexPath.row]
        
        cell.textLabel?.text = photo.title
        cell.detailTextLabel?.text = photo.subtitle
        return cell
    }
    
    
    // MARK: - Навигация в навигейшен контроллере
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Storyboard.SegueIdentifierPhoto {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let photo = photos[indexPath.row]
                var destination = segue.destination
                
                if let nc = destination as? UINavigationController,
                    let visibleVC = nc.visibleViewController {
                    destination = visibleVC
                    
                    destination.navigationItem.leftBarButtonItem =
                        self.splitViewController?.displayModeButtonItem
                    destination.navigationItem.leftItemsSupplementBackButton = true
                    
                }
                
                //guard let controller = destination as? ImageViewController else {return }
                //controller.imageURL = NSURL(string: photo.imageURL)
                //controller.title = photo.title
                // тайтл ячейки
                destination.title = photo.title
            }
        }
    }
    
    // при выборе ячейки определяем индекс нажатой ячейки
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        index = indexPath.row
        print("selected row with index = \(index)")
    }
    
    @IBAction func hideTableBarButtonTap(_ sender: UIBarButtonItem) {
        self.view.removeFromSuperview()
        print("Removed from superview!")
    }
}
