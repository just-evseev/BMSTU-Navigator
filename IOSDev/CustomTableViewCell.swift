//
//  CustomTableViewCell.swift
//  IOSDev
//
//  Created by Илья on 22.03.2018.
//  Copyright © 2018 Ilya. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var settingLbl: UILabel!
    @IBOutlet weak var settingImg: UIImageView!
    @IBOutlet weak var secondSettingLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
