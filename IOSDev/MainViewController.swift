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
var settingIdentifier = ["Русский", "Светлая"]


class MapViewController: UIViewController, UIScrollViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var mainNavigationItem: UINavigationItem!
    @IBOutlet weak var mapScrollView: UIScrollView!
    @IBOutlet weak var mapImageView: UIImageView!
    @IBOutlet weak var settingButton: UIButton!
    @IBOutlet weak var shareMapButton: UIButton!
    @IBOutlet weak var upView: UIView!
    @IBOutlet weak var whereFromTextField: UITextField!
    @IBOutlet weak var whereTextField: UITextField!
    @IBOutlet weak var whereDictionButton: UIButton!
    @IBOutlet weak var whereFromDictionButton: UIButton!

    var changableFloatNumber:Int = numberFloat
//    =========Удалить мусор и массив мусора==============
    var arrayOfMysor = ["Красная площадь","Обжорный ряд","У ноги","Дом Физики","Метро","Фонтан"]
    var way:[Int] = []
    var classroom:[(Int,Int)] = []
    var schet:Int = 0
    
    func fillModelArray() {
        modelArray = []
        for float in floatClassArray{
            for classRoom in float{
                let model = AudCellModel()
                model.title = String(classRoom.numb)
                modelArray.append(model)
            }
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
        let activityVC = UIActivityViewController(activityItems: [(mapImageView.image!)], applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.view
        
        self.present(activityVC, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapScrollView.delegate = self
        self.mapScrollView.minimumZoomScale = 1.0
        self.mapScrollView.maximumZoomScale = 6.0
        mapImageView.frame = CGRect(x: 0, y: 0, width: mapScrollView.frame.size.width, height: mapScrollView.frame.size.height)
        mapImageView.image = UIImage (named: "Float\(changableFloatNumber)")
        mapImageView.isUserInteractionEnabled = true
        mapScrollView.addSubview(mapImageView)
        
        view.addSubview(upView)
        mapImageView.image = UIImage (named: "Float\(changableFloatNumber)")
        upView.superview?.bringSubview(toFront: upView)
        
        mainView.backgroundColor = UIColor(red: 251/255, green: 251/255, blue: 251/255, alpha: 1.0)
        upView.backgroundColor = UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1.0)
        whereTextField.backgroundColor = UIColor(red: 251/255, green: 251/255, blue: 251/255, alpha: 1.0)
        whereFromTextField.backgroundColor = UIColor(red: 251/255, green: 251/255, blue: 251/255, alpha: 1.0)
        whereTextField.textColor = UIColor.black
        whereFromTextField.textColor = UIColor.black
        whereTextField.attributedPlaceholder = NSAttributedString(string: "куда", attributes: [NSAttributedStringKey.foregroundColor: UIColor(red: 215/255, green: 215/255, blue: 215/255, alpha: 1.0)])
        whereFromTextField.attributedPlaceholder = NSAttributedString(string: "откуда", attributes: [NSAttributedStringKey.foregroundColor: UIColor(red: 215/255, green: 215/255, blue: 215/255, alpha: 1.0)])

        mainNavigationItem.title = "Карта"
        
        fillModelArray()


    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        if whereFromAudNumb != "" {
            whereFromTextField.text = whereFromAudNumb
        }
        if whereAudNumb != "" {
            whereTextField.text = whereAudNumb
        }
        
        switch settingIdentifier[0] {
        case "Русский":
            mainNavigationItem.title = "Карта"
            switch settingIdentifier[1]{
            case "Светлая":
                mainView.backgroundColor = UIColor(red: 251/255, green: 251/255, blue: 251/255, alpha: 1.0)
                upView.backgroundColor = UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1.0)
                whereTextField.backgroundColor = UIColor(red: 251/255, green: 251/255, blue: 251/255, alpha: 1.0)
                whereFromTextField.backgroundColor = UIColor(red: 251/255, green: 251/255, blue: 251/255, alpha: 1.0)
                whereTextField.textColor = UIColor.black
                whereFromTextField.textColor = UIColor.black
                whereTextField.attributedPlaceholder = NSAttributedString(string: "куда", attributes: [NSAttributedStringKey.foregroundColor: UIColor(red: 215/255, green: 215/255, blue: 215/255, alpha: 1.0)])
                whereFromTextField.attributedPlaceholder = NSAttributedString(string: "откуда", attributes: [NSAttributedStringKey.foregroundColor: UIColor(red: 215/255, green: 215/255, blue: 215/255, alpha: 1.0)])
            case "Темная":
                mainView.backgroundColor = UIColor(red: 20/255, green: 20/255, blue: 20/255, alpha: 1.0)
                upView.backgroundColor = UIColor(red: 50/255, green: 50/255, blue: 50/255, alpha: 1.0)
                whereTextField.backgroundColor = UIColor(red: 77/255, green: 77/255, blue: 77/255, alpha: 1.0)
                whereFromTextField.backgroundColor = UIColor(red: 77/255, green: 77/255, blue: 77/255, alpha: 1.0)
                whereTextField.textColor = UIColor(red: 251/255, green: 251/255, blue: 251/255, alpha: 1.0)
                whereFromTextField.textColor = UIColor(red: 251/255, green: 251/255, blue: 251/255, alpha: 1.0)
                whereTextField.attributedPlaceholder = NSAttributedString(string: "куда", attributes: [NSAttributedStringKey.foregroundColor: UIColor(red: 251/255, green: 251/255, blue: 251/255, alpha: 0.5)])
                whereFromTextField.attributedPlaceholder = NSAttributedString(string: "откуда", attributes: [NSAttributedStringKey.foregroundColor: UIColor(red: 251/255, green: 251/255, blue: 251/255, alpha: 0.5)])
            default:
                break
            }
        case "English":
            switch settingIdentifier[1]{
            case "Light":
                mainView.backgroundColor = UIColor(red: 251/255, green: 251/255, blue: 251/255, alpha: 1.0)
                upView.backgroundColor = UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1.0)
                whereTextField.backgroundColor = UIColor(red: 251/255, green: 251/255, blue: 251/255, alpha: 1.0)
                whereFromTextField.backgroundColor = UIColor(red: 251/255, green: 251/255, blue: 251/255, alpha: 1.0)
                whereTextField.textColor = UIColor.black
                whereFromTextField.textColor = UIColor.black
                whereTextField.attributedPlaceholder = NSAttributedString(string: "where", attributes: [NSAttributedStringKey.foregroundColor: UIColor(red: 215/255, green: 215/255, blue: 215/255, alpha: 1.0)])
                whereFromTextField.attributedPlaceholder = NSAttributedString(string: "where from", attributes: [NSAttributedStringKey.foregroundColor: UIColor(red: 215/255, green: 215/255, blue: 215/255, alpha: 1.0)])
            case "Dark":
                mainView.backgroundColor = UIColor(red: 20/255, green: 20/255, blue: 20/255, alpha: 1.0)
                upView.backgroundColor = UIColor(red: 50/255, green: 50/255, blue: 50/255, alpha: 1.0)
                whereTextField.backgroundColor = UIColor(red: 77/255, green: 77/255, blue: 77/255, alpha: 1.0)
                whereFromTextField.backgroundColor = UIColor(red: 77/255, green: 77/255, blue: 77/255, alpha: 1.0)
                whereTextField.textColor = UIColor(red: 251/255, green: 251/255, blue: 251/255, alpha: 1.0)
                whereFromTextField.textColor = UIColor(red: 251/255, green: 251/255, blue: 251/255, alpha: 1.0)
                whereTextField.attributedPlaceholder = NSAttributedString(string: "where", attributes: [NSAttributedStringKey.foregroundColor: UIColor(red: 251/255, green: 251/255, blue: 251/255, alpha: 0.5)])
                whereFromTextField.attributedPlaceholder = NSAttributedString(string: "where from", attributes: [NSAttributedStringKey.foregroundColor: UIColor(red: 251/255, green: 251/255, blue: 251/255, alpha: 0.5)])
            default:
                break
            }
            mainNavigationItem.title = "Map"
            
        default:
            break
        }
        if (whereFromTextField.text != "") && (whereTextField.text != "") {
            WaveAlgorithm(whereWave: Int(whereTextField.text!)!, whereFrom: Int(whereFromTextField.text!)!)
        }
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)        
        self.navigationController?.setNavigationBarHidden(false, animated: animated)

    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.mapImageView
    }
    
    func WaveAlgorithm(whereWave: Int, whereFrom:Int){
        var whereWaveVar,whereFromVar:ClassRoom
        whereWaveVar = ClassRoom(numb: 200, koordX: 97, koordY: 96, float: 2)
        whereFromVar = whereWaveVar
        
        for float in floatClassArray{
            for classRoom in float{
                if classRoom.numb==whereWave {
                    whereWaveVar=classRoom
                    print(whereWaveVar)
                }
                if classRoom.numb==whereFrom {
                    whereFromVar=classRoom
                    print(whereFromVar)
                }
            }
        }
        //============Поменять местами X и Y там где необходимо==============
        var waveArray = floatWaveArray
        print (waveArray)
        var counter:Int = 0
        var flagWave:Bool = true
        waveArray[whereFromVar.float-1][whereFromVar.koordY][whereFromVar.koordX] = 1
        while  (waveArray[whereWaveVar.float][whereWaveVar.koordY][whereWaveVar.koordX] == 0)&&(flagWave) {
            flagWave = false
            counter += 1
            for float in 1...11 {
                for y in 1...98 {
                    for x in 1...98 {
                        if waveArray[float][y][x] == counter {
                            flagWave = true
                            if waveArray[float][y][x+1] == 0 {waveArray[float][y][x+1] = counter+1}
                            if waveArray[float][y][x-1] == 0 {waveArray[float][y][x-1] = counter+1}
                            if waveArray[float][y+1][x] == 0 {waveArray[float][y+1][x] = counter+1}
                            if waveArray[float][y-1][x] == 0 {waveArray[float][y-1][x] = counter+1}
                        }
                    }
                }
            }
        }
        if !flagWave {
            print ("Невозможно построить маршрут между выбранными аудиториями")
        }else{
            var tekX = whereWaveVar.koordX
            var tekY = whereWaveVar.koordY
            let tekFloat = whereWaveVar.float
            counter = waveArray[whereWaveVar.float][whereWaveVar.koordY][whereWaveVar.koordX]+1
            while counter != 2 {
                counter -= 1
                if waveArray[tekFloat][tekY][tekX+1] == counter {
                    print("Float:\(tekFloat); X:\(tekX+1); Y\(tekY)")
                    tekX+=1
                }
                else{ if waveArray[tekFloat][tekY][tekX-1] == counter {
                        print("Float:\(tekFloat); X:\(tekX-1); Y\(tekY)")
                        tekX-=1}
                    else{ if waveArray[tekFloat][tekY+1][tekX] == counter {
                            print("Float:\(tekFloat); X:\(tekX); Y\(tekY+1)")
                            tekY+=1}
                        else{
                            print("Float:\(tekFloat); X:\(tekX); Y\(tekY-1)")
                            tekY-=1
                        }
                    }
                }
                
            }
        }
    }
    
}
