//
//  ViewController.swift
//  IOSDev
//
//  Created by Илья on 22.03.2018.
//  Copyright © 2018 Ilya. All rights reserved.
//

import UIKit

class ViewController: UIViewController{

    @IBOutlet weak var HeightConstraintOutlet: NSLayoutConstraint!
    @IBOutlet weak var BmstuLogo: UIImageView!
    @IBOutlet weak var ButtonPressed: UIButton!
    
    func logoAnimate() {
        
        BmstuLogo.isHidden = false
        UIView.animate(withDuration: 2.0, animations: {
            self.BmstuLogo.frame = CGRect(x: 67.5, y: 30, width: 240, height: 240)
        }) { _ in
            UIView.animate(withDuration: 0.5) {
                self.ButtonPressed.alpha = 1.0
            }
        }
    }
    
    override func viewDidLoad() {
        self.ButtonPressed.alpha = 0.0
        logoAnimate()
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

