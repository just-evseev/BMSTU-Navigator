//
//  ThirdViewController.swift
//  IOSDev
//
//  Created by Илья on 22.03.2018.
//  Copyright © 2018 Ilya. All rights reserved.
//

import UIKit


var myIndex = 0

class ThirdViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var tableViewElements = ["Язык","Тема"]
    let cellIdentifier = "CustomTableViewCell"

    @IBOutlet weak var firstSetNavigationItem: UINavigationItem!
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib.init(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)

        switch settingIdentifier[0] {
        case "Русский":
            tableViewElements = ["Язык","Тема"]
            firstSetNavigationItem.title = "Настройки"
        case "English":
            tableViewElements = ["Language","Theme"]
            firstSetNavigationItem.title = "Settings"
        default:
            break
        }
        
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)

        switch settingIdentifier[0] {
        case "Русский":
            tableViewElements = ["Язык","Тема"]
            firstSetNavigationItem.title = "Настройки"
        case "English":
            tableViewElements = ["Language","Theme"]
            firstSetNavigationItem.title = "Settings"
        default:
            break
        }

        tableView.reloadData()
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myIndex = indexPath.row
        performSegue(withIdentifier: "segue", sender: self)
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return tableViewElements.count
    }
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CustomTableViewCell
        cell.settingLbl?.text = tableViewElements[indexPath.row]
        cell.secondSettingLbl?.text = settingIdentifier[indexPath.row]
        return cell
        
    }
   
}
