//
//  NewMapViewController.swift
//  IOSDev
//
//  Created by Илья on 06.04.2018.
//  Copyright © 2018 Ilya. All rights reserved.
//

import UIKit

var numberFloat: Int = 1

class MapViewController: UIViewController, UIScrollViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var MapScrollView: UIScrollView!
    @IBOutlet weak var MapImageView: UIImageView!
    @IBOutlet weak var SettingButton: UIButton!
    @IBOutlet weak var ShareMapButton: UIButton!
    @IBOutlet weak var UpView: UIView!
    @IBOutlet weak var WhereFromTextField: UITextField!
    @IBOutlet weak var WhereTextField: UITextField!
    @IBOutlet weak var WhereDictionButton: UIButton!
    @IBOutlet weak var WhereFromDictionButton: UIButton!

    var ChangableFloatNumber:Int = numberFloat
    
    @IBAction func WhereTextFiledPressed(_ sender: Any) {
        
        WhereTextField.isUserInteractionEnabled = false
        performSegue(withIdentifier: "inputValueSegue", sender: self)

    }
    
    @IBAction func WhereFromTextFieldPressed (_ sender: Any) {
        
        WhereFromTextField.isUserInteractionEnabled = false
        performSegue(withIdentifier: "inputValueSegue", sender: self)
        
    }
    
    @IBAction func ShareButtonPressed(_ sender: Any) {
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        WhereFromTextField.isUserInteractionEnabled = true
        WhereTextField.isUserInteractionEnabled = true
        
        self.MapScrollView.minimumZoomScale = 1.0
        self.MapScrollView.maximumZoomScale = 6.0
        MapScrollView.delegate = self
        MapImageView.frame = CGRect(x: 0, y: 0, width: MapScrollView.frame.size.width, height: MapScrollView.frame.size.height)
        MapImageView.image = UIImage (named: "Float\(ChangableFloatNumber)")
        MapImageView.isUserInteractionEnabled = true
        MapScrollView.addSubview(MapImageView)
        
        view.addSubview(UpView)
        MapImageView.image = UIImage (named: "Float\(ChangableFloatNumber)")
        UpView.superview?.bringSubview(toFront: UpView)
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
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.MapImageView
    }
    
}
