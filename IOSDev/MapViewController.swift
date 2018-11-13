//
//  NewMapViewController.swift
//  IOSDev
//
//  Created by Илья on 06.04.2018.
//  Copyright © 2018 Ilya. All rights reserved.
//

import UIKit
import Photos

var numberFloat: Int = 2

var modelArray = [AudCellModel]()
var popPlaceArray = [AudCellModel]()
var classArray = [AudCellModel]()
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
    @IBOutlet weak var floatLabel: UILabel!
    
    var changableFloatNumber:Int = numberFloat
    var way:[Int] = []
    var classroom:[(Int,Int)] = []
    var schet:Int = 0
    let moveConstant = 5.0
    var wayWaveArray = [[(Int,Int)]]()
    var floatImageWave = [UIImage]()
    
    
    func fillModelArray() {
        modelArray = []
        for float in floatClassArray{
            for classRoom in float{
                if classRoom.numb != 1 {
                    let model = AudCellModel()
                    model.title = String(classRoom.numb)
                    modelArray.append(model)
                }
            }
        }
        for float in floatClassArray{
            for classRoom in float{
                if classRoom.nazvanie != "_" {
                    let secondModel = AudCellModel()
                    secondModel.title = String(classRoom.nazvanie)
                    modelArray.append(secondModel)
                }
            }
        }
        classArray = []
        for float in floatClassArray{
            for classRoom in float{
                if classRoom.numb != 1 {
                    let model = AudCellModel()
                    model.title = String(classRoom.numb)
                    
                    classArray.append(model)
                }
            }
        }
        popPlaceArray = []
        for float in floatClassArray{
            for classRoom in float{
                if classRoom.nazvanie != "_" {
                    let secondModel = AudCellModel()
                    secondModel.title = String(classRoom.nazvanie)
                    popPlaceArray.append(secondModel)
                }
            }
        }
    }
    
    func updateImage(){
        floatImageWave.removeAll()
        floatImageWave.append(UIImage(named: "Float1")!)
        for float in 1...11 {
            floatImageWave.append(UIImage(named: "Float\(float)")!)
        }
    }

    @IBAction func WhereLibraryButtonPressed(_ sender: UIButton) {
        segLibraryIdent = 1
        updateImage()
    }
    

    @IBAction func WhereFromLibraryButtonPressed(_ sender: UIButton) {
        segLibraryIdent = 2
        updateImage()
    }
    
    @IBAction func WhereFromButtonPressed(_ sender: UIButton) {
        segIdent = 1
        updateImage()
    }
    
    @IBAction func WhereButtonPressed(_ sender: UIButton) {
        segIdent = 2
        updateImage()
    }
    
    @IBAction func shareButtonPressed(_ sender: UIButton) {
        let photos = PHPhotoLibrary.authorizationStatus()
        if photos == .notDetermined {
            PHPhotoLibrary.requestAuthorization({status in
                if status == .authorized{
                    let activityVC = UIActivityViewController(activityItems: [(self.mapImageView.image!)], applicationActivities: nil)
                    activityVC.popoverPresentationController?.sourceView = self.view
                    
                    self.present(activityVC, animated: true, completion: nil)
                } else {}
            })
        }else{
            PHPhotoLibrary.requestAuthorization({status in
                if status == .authorized{
                    let activityVC = UIActivityViewController(activityItems: [(self.mapImageView.image!)], applicationActivities: nil)
                    activityVC.popoverPresentationController?.sourceView = self.view
                    
                    self.present(activityVC, animated: true, completion: nil)
                } else {}
            })
        }
    }
    
    @IBAction func plusButtonPressed(_ sender: Any) {
        if changableFloatNumber<11{
            changableFloatNumber+=1
            mapImageView.image = floatImageWave[changableFloatNumber]
            floatLabel.text = "\(changableFloatNumber) Этаж"
        }
    }
    
    @IBAction func minusButtonPressed(_ sender: Any) {
        if changableFloatNumber>1{
            changableFloatNumber-=1
            mapImageView.image = floatImageWave[changableFloatNumber]
            floatLabel.text = "\(changableFloatNumber) Этаж"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapScrollView.delegate = self
        mapScrollView.maximumZoomScale = 6.0
        mapScrollView.minimumZoomScale = 1.0
        
        wayWaveArray.append([])
        wayWaveArray.append([])
        wayWaveArray.append([])
        wayWaveArray.append([])
        wayWaveArray.append([])
        wayWaveArray.append([])
        wayWaveArray.append([])
        wayWaveArray.append([])
        wayWaveArray.append([])
        wayWaveArray.append([])
        wayWaveArray.append([])
        
        view.addSubview(upView)
        updateImage()
        mapImageView.image = floatImageWave[changableFloatNumber]
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
                floatLabel.textColor = UIColor(red: 20/255, green: 20/255, blue: 20/255, alpha: 1.0)
            case "Темная":
                mainView.backgroundColor = UIColor(red: 20/255, green: 20/255, blue: 20/255, alpha: 1.0)
                upView.backgroundColor = UIColor(red: 50/255, green: 50/255, blue: 50/255, alpha: 1.0)
                whereTextField.backgroundColor = UIColor(red: 77/255, green: 77/255, blue: 77/255, alpha: 1.0)
                whereFromTextField.backgroundColor = UIColor(red: 77/255, green: 77/255, blue: 77/255, alpha: 1.0)
                whereTextField.textColor = UIColor(red: 251/255, green: 251/255, blue: 251/255, alpha: 1.0)
                whereFromTextField.textColor = UIColor(red: 251/255, green: 251/255, blue: 251/255, alpha: 1.0)
                whereTextField.attributedPlaceholder = NSAttributedString(string: "куда", attributes: [NSAttributedStringKey.foregroundColor: UIColor(red: 251/255, green: 251/255, blue: 251/255, alpha: 0.5)])
                whereFromTextField.attributedPlaceholder = NSAttributedString(string: "откуда", attributes: [NSAttributedStringKey.foregroundColor: UIColor(red: 251/255, green: 251/255, blue: 251/255, alpha: 0.5)])
                floatLabel.textColor = UIColor(red: 251/255, green: 251/255, blue: 251/255, alpha: 1.0)
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
            updateImage()
            mapImageView.image = floatImageWave[changableFloatNumber]
            wayWaveArray.removeAll()
            wayWaveArray.append([])
            wayWaveArray.append([])
            wayWaveArray.append([])
            wayWaveArray.append([])
            wayWaveArray.append([])
            wayWaveArray.append([])
            wayWaveArray.append([])
            wayWaveArray.append([])
            wayWaveArray.append([])
            wayWaveArray.append([])
            wayWaveArray.append([])
            WaveAlgorithm(whereWave: whereTextField.text!, whereFrom: whereFromTextField.text!)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)        
        self.navigationController?.setNavigationBarHidden(false, animated: animated)

    }
    
    func WaveAlgorithm(whereWave:String, whereFrom:String){
        var whereWaveVar,whereFromVar:ClassRoom
        whereWaveVar = ClassRoom(numb: 200, koordX: 97, koordY: 96, float: 2, litera: "_", nazvanie: "_")
        whereFromVar = whereWaveVar
        var whereExitIdent = true
        var whereFromExitIdent = true
        
        for float in floatClassArray{
            for classRoom in float{
                if String(classRoom.numb) == whereWave {
                    whereWaveVar=classRoom
                    whereExitIdent = false
                }
                if String(classRoom.numb) == whereFrom {
                    whereFromVar=classRoom
                    whereFromExitIdent = false
                }
            }
        }
        if (whereFromExitIdent || whereExitIdent) {
            for float in floatClassArray{
                for classRoom in float{
                    if String(classRoom.nazvanie) == whereWave {
                        whereWaveVar=classRoom
                        whereExitIdent = false
                    }
                    if String(classRoom.nazvanie) == whereFrom {
                        whereFromVar=classRoom
                        whereFromExitIdent = false
                    }
                }
            }
        }
        var waveArray = floatWaveArray
        var counter:Int = 0
//        var float = whereFromVar.float
        
        waveArray[whereFromVar.float-1][whereFromVar.koordY][whereFromVar.koordX] = 1
        while  (waveArray[whereWaveVar.float-1][whereWaveVar.koordY][whereWaveVar.koordX] == 0) {
            counter += 1
            waveArray = ZapolnWaveArray(waveArrayLet: waveArray, counter: counter)
        }
        
        var flag = false// Потом надо будет пофиксить это говно
        var tekX = whereWaveVar.koordX
        var tekY = whereWaveVar.koordY
        var tekFloat = whereWaveVar.float-1
        var stairsDrawArray = [(Int, Int, Int, Int)]()
    
        counter = waveArray[whereWaveVar.float-1][whereWaveVar.koordY][whereWaveVar.koordX]
        wayWaveArray[tekFloat].append((tekX,tekY))
        while counter > 1 {
            switch counter-1 {
            case waveArray[tekFloat][tekY][tekX+1]:
                tekX+=1
                wayWaveArray[tekFloat].append((tekX,tekY))
                counter -= 1
            case waveArray[tekFloat][tekY][tekX-1]:
                tekX-=1
                wayWaveArray[tekFloat].append((tekX,tekY))
                counter -= 1
            case waveArray[tekFloat][tekY+1][tekX]:
                tekY+=1
                wayWaveArray[tekFloat].append((tekX,tekY))
                counter -= 1
            case waveArray[tekFloat][tekY-1][tekX]:
                tekY-=1
                wayWaveArray[tekFloat].append((tekX,tekY))
                counter -= 1
            case waveArray[tekFloat][tekY-1][tekX+1]:
                tekX+=1
                tekY-=1
                wayWaveArray[tekFloat].append((tekX,tekY))
                counter -= 1
            case waveArray[tekFloat][tekY-1][tekX-1]:
                tekY-=1
                tekX-=1
                wayWaveArray[tekFloat].append((tekX,tekY))
                counter -= 1
            case waveArray[tekFloat][tekY+1][tekX-1]:
                tekY+=1
                tekX-=1
                wayWaveArray[tekFloat].append((tekX,tekY))
                counter -= 1
            case waveArray[tekFloat][tekY+1][tekX+1]:
                tekY+=1
                tekX+=1
                wayWaveArray[tekFloat].append((tekX,tekY))
                counter -= 1
            default:
                switch waveArray[tekFloat][tekY][tekX+1]{
                case -2:
                    if (tekFloat-1>0) {
                        if waveArray[tekFloat-1][tekY][tekX+2] == counter-5 {stairsDrawArray.append((tekY, tekX+1, tekFloat, 0));tekX+=2;tekFloat-=1;wayWaveArray[tekFloat].append((tekX,tekY));counter-=5}
                        if waveArray[tekFloat-1][tekY][tekX] == counter-5 {stairsDrawArray.append((tekY, tekX+1, tekFloat, 0));tekFloat-=1;wayWaveArray[tekFloat].append((tekX,tekY));counter-=5}
                        if waveArray[tekFloat-1][tekY+1][tekX+1] == counter-5 {stairsDrawArray.append((tekY, tekX+1, tekFloat, 0));tekX+=1;tekY+=1;tekFloat-=1;wayWaveArray[tekFloat].append((tekX,tekY));counter-=5}
                        if waveArray[tekFloat-1][tekY-1][tekX+1] == counter-5 {stairsDrawArray.append((tekY, tekX+1, tekFloat, 0));tekX+=1;tekY-=1;tekFloat-=1;wayWaveArray[tekFloat].append((tekX,tekY));counter-=5}
                    }
                    if (tekFloat+1<3) {
                        if waveArray[tekFloat+1][tekY][tekX+2] == counter-5 {stairsDrawArray.append((tekY, tekX+1, tekFloat, 1));tekX+=2;tekFloat+=1;wayWaveArray[tekFloat].append((tekX,tekY));counter-=5}
                        if waveArray[tekFloat+1][tekY][tekX] == counter-5 {stairsDrawArray.append((tekY, tekX+1, tekFloat, 1));tekFloat+=1;wayWaveArray[tekFloat].append((tekX,tekY));counter-=5}
                        if waveArray[tekFloat+1][tekY+1][tekX+1] == counter-5 {stairsDrawArray.append((tekY, tekX+1, tekFloat, 1));tekX+=1;tekY+=1;tekFloat+=1;wayWaveArray[tekFloat].append((tekX,tekY));counter-=5}
                        if waveArray[tekFloat+1][tekY-1][tekX+1] == counter-5 {stairsDrawArray.append((tekY, tekX+1, tekFloat, 1));tekX+=1;tekY-=1;tekFloat+=1;wayWaveArray[tekFloat].append((tekX,tekY));counter-=5}
                    }
                    flag = true // Потом надо будет пофиксить это говно
                default:
                    switch waveArray[tekFloat][tekY][tekX-1]{
                    case -2:
                        if ((tekFloat-1) >= 1) {
                            if waveArray[tekFloat-1][tekY][tekX] == counter-5 {stairsDrawArray.append((tekY, tekX-1, tekFloat, 0));tekFloat-=1;wayWaveArray[tekFloat].append((tekX,tekY));counter-=5}
                            if waveArray[tekFloat-1][tekY][tekX-2] == counter-5 {stairsDrawArray.append((tekY, tekX-1, tekFloat, 0));tekX-=2;tekFloat-=1;wayWaveArray[tekFloat].append((tekX,tekY));counter-=5}
                            if waveArray[tekFloat-1][tekY+1][tekX-1] == counter-5 {stairsDrawArray.append((tekY, tekX-1, tekFloat, 0));tekX-=1;tekY+=1;tekFloat-=1;wayWaveArray[tekFloat].append((tekX,tekY));counter-=5}
                            if waveArray[tekFloat-1][tekY-1][tekX-1] == counter-5 {stairsDrawArray.append((tekY, tekX-1, tekFloat, 0));tekX-=1;tekY-=1;tekFloat-=1;wayWaveArray[tekFloat].append((tekX,tekY));counter-=5}
                        }
                        if ((tekFloat+1) <= 2) {
                            if waveArray[tekFloat+1][tekY][tekX] == counter-5 {stairsDrawArray.append((tekY, tekX-1, tekFloat, 1));tekFloat+=1;wayWaveArray[tekFloat].append((tekX,tekY));counter-=5}
                            if waveArray[tekFloat+1][tekY][tekX-2] == counter-5 {stairsDrawArray.append((tekY, tekX-1, tekFloat, 1));tekX-=2;tekFloat+=1;wayWaveArray[tekFloat].append((tekX,tekY));counter-=5}
                            if waveArray[tekFloat+1][tekY+1][tekX-1] == counter-5 {stairsDrawArray.append((tekY, tekX-1, tekFloat, 1));tekX-=1;tekY+=1;tekFloat+=1;wayWaveArray[tekFloat].append((tekX,tekY));counter-=5}
                            if waveArray[tekFloat+1][tekY-1][tekX-1] == counter-5 {stairsDrawArray.append((tekY, tekX-1, tekFloat, 1));tekX-=1;tekY-=1;tekFloat+=1;wayWaveArray[tekFloat].append((tekX,tekY));counter-=5}
                        }
                        flag = true // Потом надо будет пофиксить это говно
                    default:
                        switch waveArray[tekFloat][tekY+1][tekX]{
                        case -2:
                            if (tekFloat-1>0) {
                                if waveArray[tekFloat-1][tekY+1][tekX+1] == counter-5 {stairsDrawArray.append((tekY+1, tekX, tekFloat, 0));tekX+=1;tekY+=1;tekFloat-=1;wayWaveArray[tekFloat].append((tekX,tekY));counter-=5}
                                if waveArray[tekFloat-1][tekY+1][tekX-1] == counter-5 {stairsDrawArray.append((tekY+1, tekX, tekFloat, 0));tekY+=1;tekX-=1;tekFloat-=1;wayWaveArray[tekFloat].append((tekX,tekY));counter-=5}
                                if waveArray[tekFloat-1][tekY+2][tekX] == counter-5 {stairsDrawArray.append((tekY+1, tekX, tekFloat, 0));tekY+=2;tekFloat-=1;wayWaveArray[tekFloat].append((tekX,tekY));counter-=5}
                                if waveArray[tekFloat-1][tekY][tekX] == counter-5 {stairsDrawArray.append((tekY+1, tekX, tekFloat, 0));tekFloat-=1;wayWaveArray[tekFloat].append((tekX,tekY));counter-=5}
                            }
                            if (tekFloat+1<3) {
                                if waveArray[tekFloat+1][tekY+1][tekX+1] == counter-5 {stairsDrawArray.append((tekY+1, tekX, tekFloat, 1));tekX+=1;tekY+=1;tekFloat+=1;wayWaveArray[tekFloat].append((tekX,tekY));counter-=5}
                                if waveArray[tekFloat+1][tekY+1][tekX-1] == counter-5 {stairsDrawArray.append((tekY+1, tekX, tekFloat, 1));tekY+=1;tekX-=1;tekFloat+=1;wayWaveArray[tekFloat].append((tekX,tekY));counter-=5}
                                if waveArray[tekFloat+1][tekY+2][tekX] == counter-5 {stairsDrawArray.append((tekY+1, tekX, tekFloat, 1));tekY+=2;tekFloat+=1;wayWaveArray[tekFloat].append((tekX,tekY));counter-=5}
                                if waveArray[tekFloat+1][tekY][tekX] == counter-5 {stairsDrawArray.append((tekY+1, tekX, tekFloat, 1));tekFloat+=1;wayWaveArray[tekFloat].append((tekX,tekY));counter-=5}
                            }
                            flag = true // Потом надо будет пофиксить это говно
                        default:
                            switch waveArray[tekFloat][tekY-1][tekX]{
                            case -2:
                                if (tekFloat-1>0) {
                                    if waveArray[tekFloat-1][tekY-1][tekX+1] == counter-5 {stairsDrawArray.append((tekY-1, tekX, tekFloat, 0));tekX-=1;tekY+=1;tekFloat-=1;wayWaveArray[tekFloat].append((tekX,tekY));counter-=5}
                                    if waveArray[tekFloat-1][tekY-1][tekX-1] == counter-5 {stairsDrawArray.append((tekY-1, tekX, tekFloat, 0));tekY-=1;tekX-=1;tekFloat-=1;wayWaveArray[tekFloat].append((tekX,tekY));counter-=5}
                                    if waveArray[tekFloat-1][tekY][tekX] == counter-5 {stairsDrawArray.append((tekY-1, tekX, tekFloat, 0));tekFloat-=1;wayWaveArray[tekFloat].append((tekX,tekY));counter-=5}
                                    if waveArray[tekFloat-1][tekY-2][tekX] == counter-5 {stairsDrawArray.append((tekY-1, tekX, tekFloat, 0));tekY-=2;tekFloat-=1;wayWaveArray[tekFloat].append((tekX,tekY));counter-=5}
                                }
                                if (tekFloat+1<3) {
                                    if waveArray[tekFloat+1][tekY-1][tekX+1] == counter-5 {stairsDrawArray.append((tekY-1, tekX, tekFloat, 1));tekX-=1;tekY+=1;tekFloat+=1;wayWaveArray[tekFloat].append((tekX,tekY));counter-=5}
                                    if waveArray[tekFloat+1][tekY-1][tekX-1] == counter-5 {stairsDrawArray.append((tekY-1, tekX, tekFloat, 1));tekY-=1;tekX-=1;tekFloat+=1;wayWaveArray[tekFloat].append((tekX,tekY));counter-=5}
                                    if waveArray[tekFloat+1][tekY][tekX] == counter-5 {stairsDrawArray.append((tekY-1, tekX, tekFloat, 1));tekFloat+=1;wayWaveArray[tekFloat].append((tekX,tekY));counter-=5}
                                    if waveArray[tekFloat+1][tekY-2][tekX] == counter-5 {stairsDrawArray.append((tekY-1, tekX, tekFloat, 1));tekY-=2;tekFloat+=1;wayWaveArray[tekFloat].append((tekX,tekY));counter-=5}
                                }
                                flag = true // Потом надо будет пофиксить это говно
                            default:
                                break
                            }
                        }
                    }
                }
            }
            
        }
        if flag {// ну это зашквар конечно сори
            for float in 1...2 {
                var lustKoord = wayWaveArray[float][0]
                for koord in wayWaveArray[float] {
                    floatImageWave[float+1] = DrawOnImage(startingImage: floatImageWave[float+1], startKoord: lustKoord, moveToKoord: koord)
                    lustKoord = koord
                }
            }
        } else {
            for float in 1...1 {
                var lustKoord = wayWaveArray[float][0]
                for koord in wayWaveArray[float] {
                    floatImageWave[float+1] = DrawOnImage(startingImage: floatImageWave[float+1], startKoord: lustKoord, moveToKoord: koord)
                    lustKoord = koord
                }
            }
        }
        
        floatImageWave[whereFromVar.float] = DrawOnImageStartCyrcle(startingImage: floatImageWave[whereFromVar.float], startKoord: (Int(Double(whereFromVar.koordX) * moveConstant), Int(Double(whereFromVar.koordY) * moveConstant)))
        floatImageWave[whereWaveVar.float] = DrawOnImageEndCyrcle(startingImage: floatImageWave[whereWaveVar.float], endKoord: (Int(Double(whereWaveVar.koordX) * moveConstant), Int(Double(whereWaveVar.koordY) * moveConstant)))
        for item in stairsDrawArray {
            floatImageWave[item.2] = DrawOnImageStairs(startingImage: floatImageWave[item.2], koord: ((Int(Double(item.1) * moveConstant)),Int(Double(item.0) * moveConstant)), napr: item.3)
        }
        mapImageView.image = floatImageWave[changableFloatNumber]
    }
    
    func ZapolnWaveArray(waveArrayLet: [[[Int]]], counter: Int) -> [[[Int]]]{
        var waveArray = waveArrayLet
        for float in 1...2{//<----------------------------------- Тут перечисляются этажи
            for y in 1...98 {
                for x in 1...98 {
                    if waveArray[float][y][x] == counter {
                        if waveArray[float][y][x+1] == 0 {
                            waveArray[float][y][x+1] = counter+1
                        } else {
                            if waveArray[float][y][x+1] == -2 {
                                if (float-1>0) {
                                    if waveArray[float-1][y][x+2] == 0 {waveArray[float-1][y][x+2] = counter+5}
                                    if waveArray[float-1][y][x] == 0 {waveArray[float-1][y][x] = counter+5}
                                    if waveArray[float-1][y+2][x] == 0 {waveArray[float-1][y+2][x] = counter+5}
                                    if waveArray[float-1][y][x] == 0 {waveArray[float-1][y][x] = counter+5}
                                }
                                if (float+1<3) {
                                    if waveArray[float+1][y][x+2] == 0 {waveArray[float+1][y][x+2] = counter+5}
                                    if waveArray[float+1][y][x] == 0 {waveArray[float+1][y][x] = counter+5}
                                    if waveArray[float+1][y+1][x+1] == 0 {waveArray[float+1][y+1][x+1] = counter+5}
                                    if waveArray[float+1][y-1][x+1] == 0 {waveArray[float+1][y-1][x+1] = counter+5}
                                }
                            }
                        }
                        if waveArray[float][y][x-1] == 0 {
                            waveArray[float][y][x-1] = counter+1
                        } else {
                            if waveArray[float][y][x-1] == -2 {
                                if (float-1>0) {
                                    if waveArray[float-1][y][x] == 0 {waveArray[float-1][y][x] = counter+5}
                                    if waveArray[float-1][y][x-2] == 0 {waveArray[float-1][y][x-2] = counter+5}
                                    if waveArray[float-1][y+1][x-1] == 0 {waveArray[float-1][y+1][x-1] = counter+5}
                                    if waveArray[float-1][y-1][x-1] == 0 {waveArray[float-1][y-1][x-1] = counter+5}
                                }
                                if (float+1<3) {
                                    if waveArray[float+1][y][x] == 0 {waveArray[float+1][y][x] = counter+5}
                                    if waveArray[float+1][y][x-2] == 0 {waveArray[float+1][y][x-2] = counter+5}
                                    if waveArray[float+1][y+1][x-1] == 0 {waveArray[float+1][y+1][x-1] = counter+5}
                                    if waveArray[float+1][y-1][x-1] == 0 {waveArray[float+1][y-1][x-1] = counter+5}
                                }
                            }
                        }
                        if waveArray[float][y+1][x] == 0 {
                            waveArray[float][y+1][x] = counter+1
                        } else {
                            if waveArray[float][y+1][x] == -2 {
                                if (float-1>0) {
                                    if waveArray[float-1][y+1][x+1] == 0 {waveArray[float-1][y+1][x+1] = counter+5}
                                    if waveArray[float-1][y+1][x-1] == 0 {waveArray[float-1][y+1][x-1] = counter+5}
                                    if waveArray[float-1][y+2][x] == 0 {waveArray[float-1][y+2][x] = counter+5}
                                    if waveArray[float-1][y][x] == 0 {waveArray[float-1][y][x] = counter+5}
                                }
                                if (float+1<3) {
                                    if waveArray[float+1][y+1][x+1] == 0 {waveArray[float+1][y+1][x+1] = counter+5}
                                    if waveArray[float+1][y+1][x-1] == 0 {waveArray[float+1][y+1][x-1] = counter+5}
                                    if waveArray[float+1][y+2][x] == 0 {waveArray[float+1][y+2][x] = counter+5}
                                    if waveArray[float+1][y][x] == 0 {waveArray[float+1][y][x] = counter+5}
                                }
                            }
                        }
                        if waveArray[float][y-1][x] == 0 {
                            waveArray[float][y-1][x] = counter+1
                        } else {
                            if waveArray[float][y-1][x] == -2 {
                                if (float-1>0) {
                                    if waveArray[float-1][y-1][x+1] == 0 {waveArray[float-1][y-1][x+1] = counter+5}
                                    if waveArray[float-1][y-1][x-1] == 0 {waveArray[float-1][y-1][x-1] = counter+5}
                                    if waveArray[float-1][y][x] == 0 {waveArray[float-1][y][x] = counter+5}
                                    if waveArray[float-1][y-2][x] == 0 {waveArray[float-1][y-2][x] = counter+5}
                                }
                                if (float+1<3) {
                                    if waveArray[float+1][y-1][x+1] == 0 {waveArray[float+1][y-1][x+1] = counter+5}
                                    if waveArray[float+1][y-1][x-1] == 0 {waveArray[float+1][y-1][x-1] = counter+5}
                                    if waveArray[float+1][y][x] == 0 {waveArray[float+1][y][x] = counter+5}
                                    if waveArray[float+1][y-2][x] == 0 {waveArray[float+1][y-2][x] = counter+5}
                                }
                            }
                        }
                        if waveArray[float][y+1][x+1] == 0 {
                            waveArray[float][y+1][x+1] = counter+1
                        } else {
                            if waveArray[float][y+1][x+1] == -2 {
                                if (float-1>0) {
                                    if waveArray[float-1][y+1][x+2] == 0 {waveArray[float-1][y+1][x+2] = counter+5}
                                    if waveArray[float-1][y+1][x] == 0 {waveArray[float-1][y+1][x] = counter+5}
                                    if waveArray[float-1][y+2][x+1] == 0 {waveArray[float-1][y+2][x+1] = counter+5}
                                    if waveArray[float-1][y][x+1] == 0 {waveArray[float-1][y][x+1] = counter+5}
                                }
                                if (float+1<3) {
                                    if waveArray[float+1][y+1][x+2] == 0 {waveArray[float+1][y+1][x+2] = counter+5}
                                    if waveArray[float+1][y+1][x] == 0 {waveArray[float+1][y+1][x] = counter+5}
                                    if waveArray[float+1][y+2][x+1] == 0 {waveArray[float+1][y+2][x+1] = counter+5}
                                    if waveArray[float+1][y][x+1] == 0 {waveArray[float+1][y][x+1] = counter+5}
                                }
                            }
                        }
                        if waveArray[float][y+1][x-1] == 0 {
                            waveArray[float][y+1][x-1] = counter+1
                        } else {
                            if waveArray[float][y+1][x-1] == -2 {
                                if (float-1>0) {
                                    if waveArray[float-1][y+1][x] == 0 {waveArray[float-1][y+1][x] = counter+5}
                                    if waveArray[float-1][y+1][x-2] == 0 {waveArray[float-1][y+1][x-2] = counter+5}
                                    if waveArray[float-1][y+2][x-1] == 0 {waveArray[float-1][y+2][x-1] = counter+5}
                                    if waveArray[float-1][y][x-1] == 0 {waveArray[float-1][y][x-1] = counter+5}
                                }
                                if (float+1<3) {
                                    if waveArray[float+1][y+1][x] == 0 {waveArray[float+1][y+1][x] = counter+5}
                                    if waveArray[float+1][y+1][x-2] == 0 {waveArray[float+1][y+1][x-2] = counter+5}
                                    if waveArray[float+1][y+2][x-1] == 0 {waveArray[float+1][y+2][x-1] = counter+5}
                                    if waveArray[float+1][y][x-1] == 0 {waveArray[float+1][y][x-1] = counter+5}
                                }
                            }
                        }
                        if waveArray[float][y-1][x+1] == 0 {
                            waveArray[float][y-1][x+1] = counter+1
                        } else {
                            if waveArray[float][y-1][x+1] == -2 {
                                if (float-1>0) {
                                    if waveArray[float-1][y-1][x+2] == 0 {waveArray[float-1][y-1][x+2] = counter+5}
                                    if waveArray[float-1][y-1][x] == 0 {waveArray[float-1][y-1][x] = counter+5}
                                    if waveArray[float-1][y][x+1] == 0 {waveArray[float-1][y][x+1] = counter+5}
                                    if waveArray[float-1][y-2][x+1] == 0 {waveArray[float-1][y-2][x+1] = counter+5}
                                }
                                if (float+1<3) {
                                    if waveArray[float+1][y-1][x+2] == 0 {waveArray[float+1][y-1][x+2] = counter+5}
                                    if waveArray[float+1][y-1][x] == 0 {waveArray[float+1][y-1][x] = counter+5}
                                    if waveArray[float+1][y][x+1] == 0 {waveArray[float+1][y][x+1] = counter+5}
                                    if waveArray[float+1][y-2][x+1] == 0 {waveArray[float+1][y-2][x+1] = counter+5}
                                }
                            }
                        }
                        if waveArray[float][y-1][x-1] == 0 {
                            waveArray[float][y-1][x-1] = counter+1
                        } else {
                            if waveArray[float][y-1][x-1] == 0 {
                                if (float-1>0) {
                                    if waveArray[float-1][y-1][x] == 0 {waveArray[float-1][y-1][x] = counter+5}
                                    if waveArray[float-1][y-1][x-2] == 0 {waveArray[float-1][y-1][x-2] = counter+5}
                                    if waveArray[float-1][y][x-1] == 0 {waveArray[float-1][y][x-1] = counter+5}
                                    if waveArray[float-1][y-2][x-1] == 0 {waveArray[float-1][y-2][x-1] = counter+5}
                                }
                                if (float+1<3) {
                                    if waveArray[float+1][y-1][x] == 0 {waveArray[float+1][y-1][x] = counter+5}
                                    if waveArray[float+1][y-1][x-2] == 0 {waveArray[float+1][y-1][x-2] = counter+5}
                                    if waveArray[float+1][y][x-1] == 0 {waveArray[float+1][y][x-1] = counter+5}
                                    if waveArray[float+1][y-2][x-1] == 0 {waveArray[float+1][y-2][x-1] = counter+5}
                                }
                            }
                        }
                    }
                }
            }
        }
        return waveArray
    }
    
    func DrawOnImage(startingImage: UIImage, startKoord: (Int,Int), moveToKoord: (Int,Int)) -> UIImage {
        UIGraphicsBeginImageContext(startingImage.size)
        startingImage.draw(at: CGPoint.zero)
        let context = UIGraphicsGetCurrentContext()!
        
        context.setLineWidth(4.0)
        context.setStrokeColor(UIColor.red.cgColor)
        context.move(to: CGPoint(x: Int(Double(startKoord.0) * moveConstant)+250, y: Int(Double(startKoord.1) * moveConstant)+250))
        context.addLine(to: CGPoint(x: Int(Double(moveToKoord.0) * moveConstant)+250, y: Int(Double(moveToKoord.1) * moveConstant)+250))
        context.strokePath()
        
        let myImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return myImage!
    }
    
    func DrawOnImageStartCyrcle(startingImage: UIImage, startKoord: (Int, Int)) -> UIImage {
        
        UIGraphicsBeginImageContext(startingImage.size)
        startingImage.draw(at: CGPoint.zero)

        let startImage = UIImage(named: "Start")
        startImage!.draw(in: CGRect(x: startKoord.0 + 230, y: startKoord.1 + 210, width: 40, height: 40))
        
        
        let myImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return myImage!
    }
    
    func DrawOnImageEndCyrcle(startingImage: UIImage, endKoord: (Int, Int)) -> UIImage {
        
        UIGraphicsBeginImageContext(startingImage.size)
        startingImage.draw(at: CGPoint.zero)
        
        let finishImage = UIImage(named: "Finish")
        finishImage!.draw(in: CGRect(x: endKoord.0+230, y: endKoord.1+230, width: 40, height: 40))
        
        let myImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return myImage!
    }
    
    func DrawOnImageStairs(startingImage: UIImage, koord: (Int, Int), napr: Int) -> UIImage {
        
        UIGraphicsBeginImageContext(startingImage.size)
        startingImage.draw(at: CGPoint.zero)
        
        if napr == 1 {
            let stairsImage = UIImage(named: "down")
            stairsImage!.draw(in: CGRect(x: koord.0+240, y: koord.1+240, width: 20, height: 20))
        } else {
            let stairsImage = UIImage(named: "up")
            stairsImage!.draw(in: CGRect(x: koord.0+240, y: koord.1+240, width: 20, height: 20))
        }
        
        let myImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return myImage!
    }
    
//    func searchInWaveArray(whereWave:String) -> ClassRoom {
//        var flag = true
//        for float in floatClassArray{
//            for classRoom in float{
//                if String(classRoom.numb) == whereWave {
//                    whereWaveVar=classRoom
//                    flag = false
//                }
//            }
//        }
//        if (flag) {
//            for float in floatClassArray{
//                for classRoom in float{ if String(classRoom.nazvanie) == whereWave { whereWaveVar=classRoom } }
//            }
//        }
//    }
    
}
