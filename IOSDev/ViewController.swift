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
        
        UIView.animate(withDuration: 5.0, animations: {
            self.HeightConstraintOutlet.constant = 100
        }) { _ in
            UIView.animate(withDuration: 0.5) {
                self.ButtonPressed.alpha = 1
            }
        }
    }
    
    override func viewDidLoad() {
        logoAnimate()
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

   

}

