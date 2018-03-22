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

class ThirdViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let TableViewElements = ["Красная площадь","Площадь памяти","Обжорный ряд"]
    var SettingsDict = ["Язык":["Русский","English"],"Тема":["Светлая","Темная"]]

    @IBOutlet weak var tableView: UITableView!
    //var but:String!
    
    override func viewDidLoad() {
        tableView.delegate = self
        tableView.dataSource = self
        
        super.viewDidLoad()
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return TableViewElements.count
    }
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCell(withIdentifier: "customCell") as! CustomTableViewCell
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "settingCell")
        
        cell.textLabel?.text = TableViewElements[indexPath.row]
        
        return cell
    }

   
}
