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
var segLibraryIdent = 0
var SettingIdentifier = ["Русский", "Светлая"]

class MapViewController: UIViewController, UIScrollViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet var MainView: UIView!
    @IBOutlet weak var mainNavigationItem: UINavigationItem!
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
        modelArray = []
        for j in 1...5 {
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
        for j in 6...11 {
            for i in (j*100)...(j*100+15) {
                let model = AudCellModel()
                model.title = "\(i)"
                modelArray.append(model)
            }
        }
        popPlaceArray = []
        for keks in arrayOfMysor {
            let model = AudCellModel()
            model.title = keks
            popPlaceArray.append(model)
        }
    }

    @IBAction func WhereLibraryButtonPressed(_ sender: UIButton) {
        segLibraryIdent = 1
    }
    

    @IBAction func WhereFromLibraryButtonPressed(_ sender: UIButton) {
        segLibraryIdent = 2
    }
    
    @IBAction func WhereFromButtonPressed(_ sender: UIButton) {
        segIdent = 1
    }
    
    @IBAction func WhereButtonPressed(_ sender: UIButton) {
        segIdent = 2
    }
    
    @IBAction func shareButtonPressed(_ sender: UIButton) {
        let activityVC = UIActivityViewController(activityItems: [(MapImageView.image!)], applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.view
        
        self.present(activityVC, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MapScrollView.delegate = self
        self.MapScrollView.minimumZoomScale = 1.0
        self.MapScrollView.maximumZoomScale = 6.0
        MapImageView.frame = CGRect(x: 0, y: 0, width: MapScrollView.frame.size.width, height: MapScrollView.frame.size.height)
        MapImageView.image = UIImage (named: "Float\(ChangableFloatNumber)")
        MapImageView.isUserInteractionEnabled = true
        MapScrollView.addSubview(MapImageView)
        
        view.addSubview(UpView)
        MapImageView.image = UIImage (named: "Float\(ChangableFloatNumber)")
        UpView.superview?.bringSubview(toFront: UpView)
        
        MainView.backgroundColor = UIColor(red: 251/255, green: 251/255, blue: 251/255, alpha: 1.0)
        UpView.backgroundColor = UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1.0)
        WhereTextField.backgroundColor = UIColor(red: 251/255, green: 251/255, blue: 251/255, alpha: 1.0)
        WhereFromTextField.backgroundColor = UIColor(red: 251/255, green: 251/255, blue: 251/255, alpha: 1.0)
        WhereTextField.textColor = UIColor.black
        WhereFromTextField.textColor = UIColor.black
        WhereTextField.attributedPlaceholder = NSAttributedString(string: "куда", attributes: [NSAttributedStringKey.foregroundColor: UIColor(red: 215/255, green: 215/255, blue: 215/255, alpha: 1.0)])
        WhereFromTextField.attributedPlaceholder = NSAttributedString(string: "откуда", attributes: [NSAttributedStringKey.foregroundColor: UIColor(red: 215/255, green: 215/255, blue: 215/255, alpha: 1.0)])

        mainNavigationItem.title = "Карта"
        
        fillModelArray()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        if WhereFromAudNumb != "" {
            WhereFromTextField.text = WhereFromAudNumb
        }
        if WhereAudNumb != "" {
            WhereTextField.text = WhereAudNumb
        }
        
        switch SettingIdentifier[0] {
        case "Русский":
            mainNavigationItem.title = "Карта"
            switch SettingIdentifier[1]{
            case "Светлая":
                MainView.backgroundColor = UIColor(red: 251/255, green: 251/255, blue: 251/255, alpha: 1.0)
                UpView.backgroundColor = UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1.0)
                WhereTextField.backgroundColor = UIColor(red: 251/255, green: 251/255, blue: 251/255, alpha: 1.0)
                WhereFromTextField.backgroundColor = UIColor(red: 251/255, green: 251/255, blue: 251/255, alpha: 1.0)
                WhereTextField.textColor = UIColor.black
                WhereFromTextField.textColor = UIColor.black
                WhereTextField.attributedPlaceholder = NSAttributedString(string: "куда", attributes: [NSAttributedStringKey.foregroundColor: UIColor(red: 215/255, green: 215/255, blue: 215/255, alpha: 1.0)])
                WhereFromTextField.attributedPlaceholder = NSAttributedString(string: "откуда", attributes: [NSAttributedStringKey.foregroundColor: UIColor(red: 215/255, green: 215/255, blue: 215/255, alpha: 1.0)])
            case "Темная":
                MainView.backgroundColor = UIColor(red: 20/255, green: 20/255, blue: 20/255, alpha: 1.0)
                UpView.backgroundColor = UIColor(red: 50/255, green: 50/255, blue: 50/255, alpha: 1.0)
                WhereTextField.backgroundColor = UIColor(red: 77/255, green: 77/255, blue: 77/255, alpha: 1.0)
                WhereFromTextField.backgroundColor = UIColor(red: 77/255, green: 77/255, blue: 77/255, alpha: 1.0)
                WhereTextField.textColor = UIColor(red: 251/255, green: 251/255, blue: 251/255, alpha: 1.0)
                WhereFromTextField.textColor = UIColor(red: 251/255, green: 251/255, blue: 251/255, alpha: 1.0)
                WhereTextField.attributedPlaceholder = NSAttributedString(string: "куда", attributes: [NSAttributedStringKey.foregroundColor: UIColor(red: 251/255, green: 251/255, blue: 251/255, alpha: 0.5)])
                WhereFromTextField.attributedPlaceholder = NSAttributedString(string: "откуда", attributes: [NSAttributedStringKey.foregroundColor: UIColor(red: 251/255, green: 251/255, blue: 251/255, alpha: 0.5)])
            default:
                break
            }
        case "English":
            switch SettingIdentifier[1]{
            case "Light":
                MainView.backgroundColor = UIColor(red: 251/255, green: 251/255, blue: 251/255, alpha: 1.0)
                UpView.backgroundColor = UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1.0)
                WhereTextField.backgroundColor = UIColor(red: 251/255, green: 251/255, blue: 251/255, alpha: 1.0)
                WhereFromTextField.backgroundColor = UIColor(red: 251/255, green: 251/255, blue: 251/255, alpha: 1.0)
                WhereTextField.textColor = UIColor.black
                WhereFromTextField.textColor = UIColor.black
                WhereTextField.attributedPlaceholder = NSAttributedString(string: "where", attributes: [NSAttributedStringKey.foregroundColor: UIColor(red: 215/255, green: 215/255, blue: 215/255, alpha: 1.0)])
                WhereFromTextField.attributedPlaceholder = NSAttributedString(string: "where from", attributes: [NSAttributedStringKey.foregroundColor: UIColor(red: 215/255, green: 215/255, blue: 215/255, alpha: 1.0)])
            case "Dark":
                MainView.backgroundColor = UIColor(red: 20/255, green: 20/255, blue: 20/255, alpha: 1.0)
                UpView.backgroundColor = UIColor(red: 50/255, green: 50/255, blue: 50/255, alpha: 1.0)
                WhereTextField.backgroundColor = UIColor(red: 77/255, green: 77/255, blue: 77/255, alpha: 1.0)
                WhereFromTextField.backgroundColor = UIColor(red: 77/255, green: 77/255, blue: 77/255, alpha: 1.0)
                WhereTextField.textColor = UIColor(red: 251/255, green: 251/255, blue: 251/255, alpha: 1.0)
                WhereFromTextField.textColor = UIColor(red: 251/255, green: 251/255, blue: 251/255, alpha: 1.0)
                WhereTextField.attributedPlaceholder = NSAttributedString(string: "where", attributes: [NSAttributedStringKey.foregroundColor: UIColor(red: 251/255, green: 251/255, blue: 251/255, alpha: 0.5)])
                WhereFromTextField.attributedPlaceholder = NSAttributedString(string: "where from", attributes: [NSAttributedStringKey.foregroundColor: UIColor(red: 251/255, green: 251/255, blue: 251/255, alpha: 0.5)])
            default:
                break
            }
            mainNavigationItem.title = "Map"
            
        default:
            break
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)        
        self.navigationController?.setNavigationBarHidden(false, animated: animated)

    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.MapImageView
    }
    
}
