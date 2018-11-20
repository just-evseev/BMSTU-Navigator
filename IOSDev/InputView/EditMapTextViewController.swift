//
//  EditMapTextViewController.swift
//  IOSDev
//
//  Created by Илья on 06.04.2018.
//  Copyright © 2018 Ilya. All rights reserved.
//

import UIKit

var editAudNumb:String = ""
var whereFromAudNumb:String = ""
var whereAudNumb:String = ""


class EditMapTextViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var upView: UIView!
    @IBOutlet weak var numbAudTextField: UITextField!
    @IBOutlet weak var tipsTableView: UITableView!
    @IBOutlet weak var editNavigationItem: UINavigationItem!
    
    let cellIdentifier = "SettingTableViewCell"
    var newModelArray = [AudCellModel]()
    var mysor:Int = 0
    
    @IBAction func textFieldEditingChanged(_ sender: UITextField) {
        editAudNumb = numbAudTextField.text!
        newModelArray = []
        for keks in modelArray{
            if keks.title!.range(of: editAudNumb) != nil  {
                newModelArray.append(keks)
            }
            
        }
        tipsTableView.reloadData()
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        newModelArray = modelArray
        view.addSubview(upView)
        
        tipsTableView.delegate = self
        tipsTableView.dataSource = self
        tipsTableView.register(UINib.init(nibName: "SettingTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        
        editNavigationItem.title = "Ввод аудитории"
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch segIdent {
        case 1:
            whereFromAudNumb = newModelArray[indexPath.row].title!
        case 2:
            whereAudNumb = newModelArray[indexPath.row].title!
        default:
            segIdent = 0
        }
        navigationController?.popViewController(animated: true)

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
