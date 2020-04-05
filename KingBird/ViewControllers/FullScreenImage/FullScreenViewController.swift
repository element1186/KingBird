//
//  FullScreenViewController.swift
//  KingBird
//
//  Created by Sergey on 01.04.2020.
//  Copyright © 2020 Sergey. All rights reserved.
//

import UIKit

class FullScreenViewController: BaseViewController {
    
    var imageScrollView: ImageScrollView!
    var imageUrl = ""
    
    class func controller() -> FullScreenViewController {
        return UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "FullScreenViewController") as! FullScreenViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getFullImage()
    }
    
    func getFullImage(){
        if let url = URL(string: imageUrl) {
            if let data = try? Data(contentsOf: url) {
                imageScrollView = ImageScrollView(frame: view.bounds)
                view.addSubview(imageScrollView)
                setupImageScrollView()
                imageScrollView.set(image: UIImage(data: data)!)
            }
        }
    }
    
    func setupImageScrollView() {
        imageScrollView.translatesAutoresizingMaskIntoConstraints = false
        imageScrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        imageScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        imageScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        imageScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    }
}
