//
//  SettingsTableView.swift
//  IOSDev
//
//  Created by Илья on 22.03.2018.
//  Copyright © 2018 Ilya. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //ЭТО ПОЧТИ ВСЛЕПУЮ СКОПИРОВАННАЯ ПРОШЛАЯ ВЬЮХА КОТОРАЯ ПОИДЕЕ ПРОДОЛЖАЕТ НАСТРОЙКИ
    
    var SettingDict = [["Русский","English"], ["Светлая","Темная"]]
    let cellIdentifier = "SettingTableViewCell"
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib.init(nibName: "SettingTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        
        super.viewDidLoad()
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 2
    }
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! SettingTableViewCell
        cell.settingsLbl?.text = SettingDict[myIndex][indexPath.row]
        return cell
        
    }
    
    
}
