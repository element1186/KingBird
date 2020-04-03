//
//  ViewController.swift
//  KingBird
//
//  Created by Sergey on 30.03.2020.
//  Copyright © 2020 Sergey. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    var vSpinner : UIView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func showSpinner(onView : UIView) {
        let spinnerView = UIView(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.8)
        let ai = UIActivityIndicatorView.init(style: .whiteLarge)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        
        vSpinner = spinnerView
    }
    
    func removeSpinner() {
        DispatchQueue.main.async {
            self.vSpinner?.removeFromSuperview()
            self.vSpinner = nil
        }
    }
}
