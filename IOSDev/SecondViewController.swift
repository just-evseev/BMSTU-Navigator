//
//  SecondViewController.swift
//  IOSDev
//
//  Created by Илья on 22.03.2018.
//  Copyright © 2018 Ilya. All rights reserved.
//

import UIKit
var numberAud: String = ""
var numberFloat: Int = 1

class SecondViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var label: UILabel!
    @IBAction func ButtonPressed(_ sender: UIButton) {
        numberAud = textField.text!
        if numberAud != "" {
            numberFloat = Int(numberAud)!/100
            performSegue(withIdentifier: "segueToMap", sender: self)
        } else {
            label.text = "error"
        }
    }
    
    
    
}
