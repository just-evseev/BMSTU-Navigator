//
//  NewMapViewController.swift
//  IOSDev
//
//  Created by Илья on 06.04.2018.
//  Copyright © 2018 Ilya. All rights reserved.
//

import UIKit

var numberFloat: Int = 1

class NewMapViewController: UIViewController {
    
    @IBOutlet weak var MapImageView: UIImageView!
    @IBOutlet weak var UpView: UIView!
    @IBOutlet weak var WhereFromTextField: UITextField!
    @IBOutlet weak var WhereTextField: UITextField!
    @IBOutlet weak var WhereDictionButton: UIButton!
    @IBOutlet weak var WhereFromDictionButton: UIButton!
    @IBOutlet weak var SettingButton: UIButton!

    @IBAction func WhereTextFiledPressed(_ sender: Any) {
        
        WhereTextField.isUserInteractionEnabled = false
        performSegue(withIdentifier: "inputValueSegue", sender: self)
        
    }
    
    @IBAction func WhereFromTextFieldPressed (_ sender: Any) {
        
        WhereFromTextField.isUserInteractionEnabled = false
        performSegue(withIdentifier: "inputValueSegue", sender: self)
        
    }
    
    var ChangableFloatNumber:Int = numberFloat
    
    override func viewDidLoad() {
        
        WhereFromTextField.isUserInteractionEnabled = true
        WhereTextField.isUserInteractionEnabled = true
        
        view.addSubview(UpView)
        MapImageView.image = UIImage (named: "Float\(ChangableFloatNumber)")
        UpView.superview?.bringSubview(toFront: UpView)
        
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)        
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        
        if self.isMovingFromParentViewController {
            WhereFromTextField.isUserInteractionEnabled = true
            WhereTextField.isUserInteractionEnabled = true
        }

    }
    
}
