//
//  LibraryMapViewController.swift
//  IOSDev
//
//  Created by Илья on 06.04.2018.
//  Copyright © 2018 Ilya. All rights reserved.
//

import UIKit

class LibraryMapViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var DownView: UIView!
    @IBOutlet weak var historyButton: UIButton!
    @IBOutlet weak var favoritesButton: UIButton!
    @IBOutlet weak var allButton: UIButton!
    @IBOutlet weak var AudButton: UIButton!
    @IBOutlet weak var PopPlaceButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    let cellIdentifier = "SettingTableViewCell"
    var newModelArray = [AudCellModel]()

    
    
    override func viewDidLoad() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib.init(nibName: "SettingTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        newModelArray = modelArray
        
        super.viewDidLoad()
    }
    
    @IBAction func popPlaceButtonPressed(_ sender: Any) {
        newModelArray = popPlaceArray
        self.tableView.reloadData()
        PopPlaceButton.backgroundColor = UIColor(red: 245/255, green: 244/255, blue: 180/255, alpha: 1)
        AudButton.backgroundColor = UIColor.white
    }
    
    @IBAction func AudButtonPressed(_ sender: UIButton) {
        newModelArray = modelArray
        self.tableView.reloadData()
        AudButton.backgroundColor = UIColor(red: 245/255, green: 244/255, blue: 180/255, alpha: 1)
        PopPlaceButton.backgroundColor = UIColor.white
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return newModelArray.count
    }
    
    @available(iOS 2.0, *)
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = newModelArray[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        if let castedCell = cell as? SettingTableViewCell {
            castedCell.fillCell(with: model)
        }
        return cell
    }
}
