//
//  FeedViewController.swift
//  KingBird
//
//  Created by Sergey on 30.03.2020.
//  Copyright © 2020 Sergey. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage

class FeedViewController: BaseViewController {
    var imageDataArray = [PicsumPhoto]()
    let activityIndicator = UIActivityIndicatorView()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showSpinner(onView: view)
        tableConfigure()
        imageDataDownload()
    }
    
    func tableConfigure(){
        tableView.register(FeedTableViewCell.cellNib(), forCellReuseIdentifier: FeedTableViewCell.cellIdentifier()!)
    }
    
    func imageDataDownload(){
        DataDownloader.shared.dataDonwload { result in
            switch result{
            case .success(let data):
                self.imageDataArray = data
                self.tableView.reloadData()
                self.removeSpinner()
            case .failure(let error): break
            }
        }
    }
    
}
extension FeedViewController : UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imageDataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FeedTableViewCell.cellIdentifier()!) as! FeedTableViewCell
        cell.delegate = self
        if let photoUrl = imageDataArray[indexPath.row].downloadUrl {
            cell.configure(imageUrl: photoUrl, indexPath: indexPath)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = FullScreenViewController.controller()
        
        if let photoUrl = imageDataArray[indexPath.row].downloadUrl {
            controller.imageUrl = photoUrl
        }
        
        present(controller, animated: true, completion: nil)
    }
    
    func showAlertDeletePhoto(indexPath: IndexPath){
        let alert = UIAlertController(title: "Удаление", message: "Удалить фотографию?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Да", style: .default, handler: { action in
            self.imageDataArray.remove(at: indexPath.row)
            self.tableView.reloadData()
        }))
        alert.addAction(UIAlertAction(title: "Нет", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
    
}
extension FeedViewController : DeletePhotoDelegate {
    
    func deletePhoto(indexPath: IndexPath) {
       showAlertDeletePhoto(indexPath: indexPath)
    }
    
}
