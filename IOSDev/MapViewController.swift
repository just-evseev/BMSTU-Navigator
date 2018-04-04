//
//  MapViewController.swift
//  IOSDev
//
//  Created by Илья on 04.04.2018.
//  Copyright © 2018 Ilya. All rights reserved.
//

import UIKit

class MapViewController: UIViewController {
    
    var ChangableFloatNumber:Int = numberFloat
    
    @IBOutlet weak var numberFloatLabel: UILabel!
    @IBOutlet weak var MinusButon: UIButton!
    @IBOutlet weak var PlusButton: UIButton!
    @IBOutlet weak var MapImage: UIImageView!
    
    @IBAction func MinusButtonPressed(_ sender: UIButton) {
        if ChangableFloatNumber>1 {
            ChangableFloatNumber -= 1
            numberFloatLabel.text = "Номер этажа: \(ChangableFloatNumber)"
            MapImage.image = UIImage(named: "Float\(ChangableFloatNumber).png")
        }
    }
    
    @IBAction func PlusButtonPressed(_ sender: UIButton) {
        if ChangableFloatNumber<11 {
            ChangableFloatNumber += 1
            numberFloatLabel.text = "Номер этажа: \(ChangableFloatNumber)"
            MapImage.image = UIImage(named: "Float\(ChangableFloatNumber).png")
        }
    }
    
    override func viewDidLoad(){
        numberFloatLabel.text = "Номер этажа: \(numberFloat)"
        MapImage.image = UIImage(named: "Float\(numberFloat).png")
        super.viewDidLoad()
    }
}
