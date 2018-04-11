//
//  NewMapViewController.swift
//  IOSDev
//
//  Created by Илья on 06.04.2018.
//  Copyright © 2018 Ilya. All rights reserved.
//

import UIKit

var numberFloat: Int = 1

var modelArray = [AudCellModel]()
var popPlaceArray = [AudCellModel]()
var segIdent = 0

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
    var arrayOfMysor = ["Красная площадь","Обжорный ряд","У ноги","Дом Физики","Метро","Фонтан"]
    
    func fillModelArray() {
        for j in 1...11 {
            for i in (j*100)...(j*100+35) {
                let model = AudCellModel()
                model.title = "\(i)ю"
                modelArray.append(model)
            }
            for i in (j*100+36)...(j*100+57) {
                let model = AudCellModel()
                model.title = "\(i)"
                modelArray.append(model)
            }
        }
        for keks in arrayOfMysor {
            let model = AudCellModel()
            model.title = keks
            popPlaceArray.append(model)
        }
    }
    
    @IBAction func WhereFromButtonPressed(_ sender: UIButton) {
        
        segIdent = 1
        performSegue(withIdentifier: "WhereFrom", sender: self)

    }
    
    @IBAction func WhereButtonPressed(_ sender: UIButton) {
        
        segIdent = 2
        performSegue(withIdentifier: "Where", sender: self)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        fillModelArray()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)        
        self.navigationController?.setNavigationBarHidden(false, animated: animated)

    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.MapImageView
    }
    
}
