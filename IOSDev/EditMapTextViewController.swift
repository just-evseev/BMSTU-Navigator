//
//  EditMapTextViewController.swift
//  IOSDev
//
//  Created by Илья on 06.04.2018.
//  Copyright © 2018 Ilya. All rights reserved.
//

import UIKit

var EditAudNumb:String = ""

class EditMapTextViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var upView: UIView!
    @IBOutlet weak var NumbAudTextField: UITextField!
    @IBOutlet weak var tipsTableView: UITableView!
    
    let cellIdentifier = "SettingTableViewCell"
    var newModelArray = [AudCellModel]()
    var mysor:Int = 0
    
    @IBAction func TextFieldValueChanged(_ sender: UITextField) {
        EditAudNumb = NumbAudTextField.text!
        for keks in modelArray{
            if keks.title!.first == EditAudNumb.first {
                newModelArray.append(keks)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(upView)
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
