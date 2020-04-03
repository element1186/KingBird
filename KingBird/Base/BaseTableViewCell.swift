//
//  BaseTableViewCell.swift
//  KingBird
//
//  Created by Sergey on 30.03.2020.
//  Copyright © 2020 Sergey. All rights reserved.
//

import UIKit

class BaseTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    class func cellIdentifier() -> String? {
        return nil
    }
    
    class func cellNib() -> UINib? {
        return UINib(nibName: String(describing: type (of:self)), bundle: Bundle.main)
    }
    
    class func cellHeight() -> CGFloat {
        return 50.0
    }

}
