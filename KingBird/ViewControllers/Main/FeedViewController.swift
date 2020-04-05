//
//  FeedViewController.swift
//  KingBird
//
//  Created by Sergey on 30.03.2020.
//  Copyright © 2020 Sergey. All rights reserved.
//

import UIKit
import Alamofire

class FeedViewController: BaseViewController {
    let activityIndicator = UIActivityIndicatorView()
    var images = PicSumDatabase.getData()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageDataDownload()
        showSpinner(onView: view)
        tableConfigure()
    }
    
    func tableConfigure(){
        tableView.register(FeedTableViewCell.cellNib(), forCellReuseIdentifier: FeedTableViewCell.cellIdentifier()!)
    }
    
    func imageDataDownload(){
        DataDownloader.shared.dataImagesDonwload { result in
            switch result{
            case .success(let data):
                if self.images.count == 0 {
                    DataDownloader.shared.imagesDownload(imageDataArray: data)
                    self.images = PicSumDatabase.getData()
                }
                self.tableView.reloadData()
                self.removeSpinner()
            case .failure(let error):
                self.removeSpinner()
                print("Произошла ошибка \(error.localizedDescription)")
            }
        }
    }
    
}
extension FeedViewController : UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return images.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FeedTableViewCell.cellIdentifier()!) as! FeedTableViewCell
        cell.configure(image: UIImage(data: images[indexPath.row].image)!, indexPath: indexPath)
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = FullScreenViewController.controller()
        controller.imageUrl = images[indexPath.row].url
        present(controller, animated: true, completion: nil)
    }
        
}
extension FeedViewController : DeletePhotoDelegate {
    
    func showAlertDeletePhoto(indexPath: IndexPath){
        let alert = UIAlertController(title: "Удаление", message: "Удалить фотографию?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Да", style: .default, handler: { action in
            PicSumDatabase.delete(object: self.images[indexPath.row])
            self.tableView.reloadData()
        }))
        alert.addAction(UIAlertAction(title: "Нет", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
    
    func deletePhoto(indexPath: IndexPath) {
       showAlertDeletePhoto(indexPath: indexPath)
    }
    
}
