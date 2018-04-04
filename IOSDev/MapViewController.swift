//
//  MapViewController.swift
//  IOSDev
//
//  Created by Илья on 04.04.2018.
//  Copyright © 2018 Ilya. All rights reserved.
//

import UIKit

class MapViewController: UIViewController {
    
    @IBOutlet weak var numberFloatLabel: UILabel!
    @IBOutlet weak var MapImage: UIImageView!
    override func viewDidLoad(){
        numberFloatLabel.text = "Номер этажа: \(numberFloat)"
        //let numberFloatStr:String = String(numberFloat)
        MapImage.image = UIImage(named: "Float\(numberFloat).png")
        super.viewDidLoad()
    }
}
