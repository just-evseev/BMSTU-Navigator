//
//  ThirdViewController.swift
//  IOSDev
//
//  Created by Илья on 22.03.2018.
//  Copyright © 2018 Ilya. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var tableViewElements = ["Язык","Тема"]
    let cellIdentifier = "CustomTableViewCell"

    @IBOutlet weak var firstSetNavigationItem: UINavigationItem!
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib.init(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)

        tableView.reloadData()
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            performSegue(withIdentifier: "language", sender: self)
        case 1:
            performSegue(withIdentifier: "theme", sender: self)
        default:
            print("error in index path from first setting view")
        }
        performSegue(withIdentifier: "", sender: self)
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return tableViewElements.count
    }
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CustomTableViewCell
        cell.settingLbl?.text = tableViewElements[indexPath.row]
//        cell.secondSettingLbl?.text = settingIdentifier[indexPath.row]
        return cell
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "language":
            let destinationVC = segue.destination as! SettingViewController
            destinationVC.myIndex = 1
        case "theme":
            let destinationVC = segue.destination as! SettingViewController
            destinationVC.myIndex = 2
        default:
            print("error in segue from first setting view")
        }
    }
   
}
