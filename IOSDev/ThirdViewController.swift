//
//  ThirdViewController.swift
//  IOSDev
//
//  Created by Илья on 22.03.2018.
//  Copyright © 2018 Ilya. All rights reserved.
//

import UIKit

var LangIdent = "Русский"
var ThemeIdent = "Светлая"
var SettingIdentifier = ["Русский", "Светлая"]

class ThirdViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var TableViewElements = ["Язык","Тема"]
    var SettingLang = ["Русский","English"]
    var SettingTheme = ["Светлая","Темная"]
    var SettingDict = [1: ["Русский","English"], 2: ["Светлая","Темная"]]
    let cellIdentifier = "CustomTableViewCell"

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib.init(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)

        super.viewDidLoad()
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
