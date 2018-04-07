//
//  LibraryMapViewController.swift
//  IOSDev
//
//  Created by Илья on 06.04.2018.
//  Copyright © 2018 Ilya. All rights reserved.
//

import UIKit

class LibraryMapViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    let cellIdentifier = "SettingTableViewCell"
    var modelArray = [AudCellModel]()

    override func viewDidLoad() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib.init(nibName: "SettingTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        fillModelArray()
        
        super.viewDidLoad()

    }
    
    func fillModelArray() {
        for i in 200...235 {
            let model = AudCellModel()
            model.title = "\(i)"
            modelArray.append(model)
        }
        for i in 236...257 {
            let model = AudCellModel()
            model.title = "\(i)ю"
            modelArray.append(model)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return modelArray.count
    }
    
    
    @available(iOS 2.0, *)
//    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! SettingTableViewCell
//        cell.settingsLbl?.text = SettingDict[myIndex][indexPath.row]
//        return cell
//        return
//
//    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = modelArray[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        if let castedCell = cell as? SettingTableViewCell {
            castedCell.fillCell(with: model)
        }
        return cell
    }
}
