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
                SettingIdentifier[0] = "Английский"
            default:
                SettingIdentifier[0] = "X3"
            }
        case 1:
            switch mySecIndex {
            case 0:
                SettingIdentifier[1] = "Светлая"
            case 1:
                SettingIdentifier[1] = "Темная"
            default:
                SettingIdentifier[1] = "X3"
            }
        default:
            SettingIdentifier[1] = "X3цук"
        }
    }
    
    //надо добавить переход назад при выборе какой-либо настройки
}
