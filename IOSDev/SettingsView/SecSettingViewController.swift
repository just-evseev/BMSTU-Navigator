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
    var settingDict = [["Русский","English"], ["Светлая","Темная"]]
    let cellIdentifier = "SettingTableViewCell"
    
    override func viewDidLoad() {
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib.init(nibName: "SettingTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        
        switch settingIdentifier[0] {
        case "Русский":
            settingDict = [["Русский","English"], ["Светлая","Темная"]]
        case "English":
            settingDict = [["Русский","English"], ["Light","Dark"]]
        default:
            settingDict = [["Русский","English"], ["Светлая","Темная"]]
        }
        
        super.viewDidLoad()
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return settingDict[myIndex].count
    }
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! SettingTableViewCell
        cell.settingsLbl?.text = settingDict[myIndex][indexPath.row]
        return cell
        
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        mySecIndex = indexPath.row
        switch myIndex {
        case 0:
            switch mySecIndex {
            case 0:
                settingIdentifier[0] = "Русский"
                switch settingIdentifier[1]{
                case "Light":
                    settingIdentifier[1] = "Светлая"
                case "Dark":
                    settingIdentifier[1] = "Темная"
                default:
                    break
                }
            case 1:
                settingIdentifier[0] = "English"
                switch settingIdentifier[1]{
                case "Светлая":
                    settingIdentifier[1] = "Light"
                case "Темная":
                    settingIdentifier[1] = "Dark"
                default:
                    break
                }
            default:
                break
            }
        case 1:
            switch mySecIndex {
            case 0:
                if settingIdentifier[0] == "Русский" {
                    settingIdentifier[1] = "Светлая"
                } else {
                    settingIdentifier[1] = "Light"
                }
            case 1:
                if settingIdentifier[0] == "Русский" {
                    settingIdentifier[1] = "Темная"
                } else {
                    settingIdentifier[1] = "Dark"
                }
            default:
                break
            }
        default:
            break
        }
        _ = navigationController?.popViewController(animated: true)

    }
    
    //надо добавить переход назад при выборе какой-либо настройки
}
