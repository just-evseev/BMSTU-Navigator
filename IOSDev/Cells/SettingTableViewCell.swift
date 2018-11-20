//
//  SettingTableViewCell.swift
//  IOSDev
//
//  Created by Илья on 22.03.2018.
//  Copyright © 2018 Ilya. All rights reserved.
//

import UIKit

class SettingTableViewCell: UITableViewCell {

    //ЭТО КАСТОМНАЯ ЯЧЕЙКА ДЛЯ ВНУТРЕННОСТИ КАЖДОЙ НАСТРОЙКИ
    
    @IBOutlet weak var settingsLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func fillCell(with model: AudCellModel) {
        settingsLbl.text = model.title
    }
    
}
