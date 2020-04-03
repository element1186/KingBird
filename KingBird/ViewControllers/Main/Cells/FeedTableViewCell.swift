//
//  FeedTableViewCell.swift
//  KingBird
//
//  Created by Sergey on 30.03.2020.
//  Copyright © 2020 Sergey. All rights reserved.
//

import UIKit
import SDWebImage

protocol DeletePhotoDelegate {
    func deletePhoto(indexPath: IndexPath)
}

private let kFeedTableViewCell = "FeedTableViewCell"

class FeedTableViewCell: BaseTableViewCell {
    @IBOutlet weak var photoImageView: UIImageView!
    var indexPath: IndexPath?
    var delegate: DeletePhotoDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPressed(longPressGestureRecognizer:)))
        self.addGestureRecognizer(longPressRecognizer)
    }
    
    override class func cellNib() -> UINib? {
        return UINib(nibName: kFeedTableViewCell, bundle: Bundle.main)
    }
    
    override class func cellIdentifier() -> String? {
        return kFeedTableViewCell
    }
    
    
    func configure(imageUrl: String, indexPath: IndexPath){
        self.indexPath = indexPath
        photoImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        
        DispatchQueue.global(qos: .utility).async {
                self.photoImageView?.sd_setImage(with: URL(string: imageUrl))
            }
        }
    
    @objc func longPressed(longPressGestureRecognizer: UILongPressGestureRecognizer){
        if longPressGestureRecognizer.state == .began {
            delegate?.deletePhoto(indexPath: indexPath!)
        }
    }
    
    
}
