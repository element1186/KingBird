//
//  UIImage+resizeImage.swift
//  KingBird
//
//  Created by Sergey on 05.04.2020.
//  Copyright © 2020 Sergey. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    class func resizeImage(image: UIImage, targetSize: CGSize) -> Data? {
        let size = image.size
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage?.jpegData(compressionQuality: 0.8)
    }
}
