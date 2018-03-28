//
//  ViewController.swift
//  IOSDev
//
//  Created by Илья on 22.03.2018.
//  Copyright © 2018 Ilya. All rights reserved.
//

import UIKit

class ViewController: UIViewController{

    @IBOutlet weak var BmstuLogo: UIImageView!
    @IBOutlet weak var ButtonPressed: UIButton!
    
    //тут будет наша анимация уплывания лого и появления кнопки
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.ButtonPressed.alpha = 0.0
       // logoAnimate()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func logoAnimate() {
        //BmstuLogo.isHidden = false

        UIView.animate(withDuration: 2.0, animations: {
            self.BmstuLogo.constraints
            //self.BmstuLogo.frame = CGRect(x: 100, y: 100, width: 200, height: 100)
            //self.BmstuLogo.alpha = 0.0
        }) { _ in
            UIView.animate(withDuration: 0.5) {
                self.ButtonPressed.alpha = 1.0
//                self.BmstuLogo.transform = CGAffineTransform.init(rotationAngle: .pi/2)
            }
        }
    }

}

