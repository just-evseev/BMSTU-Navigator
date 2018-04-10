//
//  SettingViewController.swift
//  IOSDev
//
//  Created by Илья on 04.04.2018.
//  Copyright © 2018 Ilya. All rights reserved.
//

import UIKit

var mySecIndex = 0

class SettingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var SettingDict = [["Русский","English"], ["Светлая","Темная"]]
    let cellIdentifier = "SettingTableViewCell"
    
    override func viewDidLoad() {
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib.init(nibName: "SettingTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        
        switch SettingIdentifier[0] {
        case "Русский":
            SettingDict = [["Русский","English"], ["Светлая","Темная"]]
        case "English":
            SettingDict = [["Русский","English"], ["Light","Dark"]]
        default:
            SettingDict = [["Русский","English"], ["Светлая","Темная"]]
        }
        
        super.viewDidLoad()
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return SettingDict[myIndex].count
    }
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! SettingTableViewCell
        cell.settingsLbl?.text = SettingDict[myIndex][indexPath.row]
        return cell
        
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        mySecIndex = indexPath.row
        switch myIndex {
        case 0:
            switch mySecIndex {
            case 0:
                SettingIdentifier[0] = "Русский"
            case 1:
                SettingIdentifier[0] = "English"
            default:
                SettingIdentifier[0] = "Ошибка 200"
            }
        case 1:
            switch mySecIndex {
            case 0:
                if SettingIdentifier[0] == "Русский" {
                    SettingIdentifier[1] = "Светлая"
                } else {
                    SettingIdentifier[1] = "Light"
                }
            case 1:
                if SettingIdentifier[0] == "Русский" {
                    SettingIdentifier[1] = "Темная"
                } else {
                    SettingIdentifier[1] = "Dark"
                }
            default:
                SettingIdentifier[1] = "Ошибка 201"
            }
        default:
            SettingIdentifier[1] = "Ошибка 202"
        }
    }
    
    //надо добавить переход назад при выборе какой-либо настройки
}
