//
//  FullScreenViewController.swift
//  KingBird
//
//  Created by Sergey on 01.04.2020.
//  Copyright © 2020 Sergey. All rights reserved.
//

import UIKit
import SDWebImage

class FullScreenViewController: BaseViewController {
    
    var imageScrollView: ImageScrollView!
    var imageUrl = ""
    class func controller() -> FullScreenViewController {
        return UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "FullScreenViewController") as! FullScreenViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageScrollView = ImageScrollView(frame: view.bounds)
        view.addSubview(imageScrollView)
        setupImageScrollView()
        let imagePath = UIImageView()
        imagePath.sd_setImage(with: URL(string: imageUrl))
        self.imageScrollView.set(image: imagePath.image!)
    }
    
    func setupImageScrollView() {
        imageScrollView.translatesAutoresizingMaskIntoConstraints = false
        imageScrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        imageScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        imageScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        imageScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    }
    

}
