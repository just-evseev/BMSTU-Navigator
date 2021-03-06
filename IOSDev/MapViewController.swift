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
        
        for _ in 0...10 {
            wayWaveArray.append([])
        }
        
        view.addSubview(upView)
        updateImage()
        mapImageView.image = floatImageWave[changableFloatNumber]
        upView.superview?.bringSubviewToFront(upView)
        
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

        if (whereFromTextField.text != "") && (whereTextField.text != "") {
            updateImage()
            mapImageView.image = floatImageWave[changableFloatNumber]
            wayWaveArray.removeAll()
            for _ in 0...10 {
                wayWaveArray.append([])
            }
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
                    floatImageWave[float + 1] = ImageDrawer().DrawOnImage(startingImage: floatImageWave[float+1], startKoord: lustKoord, moveToKoord: koord)
                    lustKoord = koord
                }
            }
        } else {
            for float in 1...1 {
                var lustKoord = wayWaveArray[float][0]
                for koord in wayWaveArray[float] {
                    floatImageWave[float + 1] = ImageDrawer().DrawOnImage(startingImage: floatImageWave[float+1], startKoord: lustKoord, moveToKoord: koord)
                    lustKoord = koord
                }
            }
        }
        
        floatImageWave[whereFromVar.float] = ImageDrawer().DrawOnImageStartCyrcle(startingImage: floatImageWave[whereFromVar.float], startKoord: (Int(Double(whereFromVar.koordX)), Int(Double(whereFromVar.koordY))))
        floatImageWave[whereWaveVar.float] = ImageDrawer().DrawOnImageEndCyrcle(startingImage: floatImageWave[whereWaveVar.float], endKoord: (Int(Double(whereWaveVar.koordX)), Int(Double(whereWaveVar.koordY))))
        for item in stairsDrawArray {
            floatImageWave[item.2] = ImageDrawer().DrawOnImageStairs(startingImage: floatImageWave[item.2], koord: ((Int(Double(item.1))),Int(Double(item.0))), napr: item.3)
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
    
       
}
