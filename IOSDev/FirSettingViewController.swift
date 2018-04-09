//
//  ThirdViewController.swift
//  IOSDev
//
//  Created by Илья on 22.03.2018.
//  Copyright © 2018 Ilya. All rights reserved.
//

import UIKit

var SettingIdentifier = ["Русский", "Светлая"]
var myIndex = 0

class ThirdViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // ЭТО ВЬЮХА С НАСТРОЙКАМИ К КОТОРЫЙ Я ПРИЦЕПИЛ КАСТОМНУЮ ЯЧЕЙКУ
    
    var TableViewElements = ["Язык","Тема"]
    let cellIdentifier = "CustomTableViewCell"

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib.init(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)

        super.viewDidLoad()
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myIndex = indexPath.row
        performSegue(withIdentifier: "segue", sender: self)
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return TableViewElements.count
    }
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CustomTableViewCell
        cell.settingLbl?.text = TableViewElements[indexPath.row]
        cell.secondSettingLbl?.text = SettingIdentifier[indexPath.row]
        return cell
        
    }
   
}
