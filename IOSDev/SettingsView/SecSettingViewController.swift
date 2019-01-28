//
//  SettingViewController.swift
//  IOSDev
//
//  Created by Илья on 04.04.2018.
//  Copyright © 2018 Ilya. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var settingDict = [["Русский","English"], ["Светлая","Темная"]]
    let cellIdentifier = "SettingTableViewCell"
    var myIndex = Int()
    
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
        cell.settingsLbl?.text = settingDict[myIndex][indexPath.row]
        return cell
        
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.popViewController(animated: true)
    }
}
