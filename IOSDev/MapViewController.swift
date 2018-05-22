//
//  NewMapViewController.swift
//  IOSDev
//
//  Created by Илья on 06.04.2018.
//  Copyright © 2018 Ilya. All rights reserved.
//

import UIKit

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

    var changableFloatNumber:Int = numberFloat
    var way:[Int] = []
    var classroom:[(Int,Int)] = []
    var schet:Int = 0
    let moveConstant = 5.0
    var wayWaveArray = [(Int,Int)]()
    
    func fillModelArray() {
        modelArray = []
        for float in floatClassArray{
            for classRoom in float{
                if classRoom.numb != 0 {
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
                let model = AudCellModel()
                model.title = String(classRoom.numb)
                classArray.append(model)
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
        mapScrollView.maximumZoomScale = 6.0
        mapScrollView.minimumZoomScale = 1.0
        
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
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return mapImageView
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
            mapImageView.image = UIImage(named: "Float\(changableFloatNumber)")
            wayWaveArray.removeAll()
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
        var flagWave:Bool = true

        waveArray[whereFromVar.float-1][whereFromVar.koordY][whereFromVar.koordX] = 1
        while  (waveArray[whereWaveVar.float-1][whereWaveVar.koordY][whereWaveVar.koordX] == 0)&&(flagWave) {
            flagWave = false
            counter += 1
            for float in 1...1 {//<- тут перечисление уже готовых этажей для обработки
                for y in 1...98 {
                    for x in 1...98 {
                        if waveArray[float][y][x] == counter {
                            flagWave = true
                            if waveArray[float][y][x+1] == 0 {waveArray[float][y][x+1] = counter+1}
                            if waveArray[float][y][x-1] == 0 {waveArray[float][y][x-1] = counter+1}
                            if waveArray[float][y+1][x] == 0 {waveArray[float][y+1][x] = counter+1}
                            if waveArray[float][y-1][x] == 0 {waveArray[float][y-1][x] = counter+1}
                            if waveArray[float][y+1][x+1] == 0 {waveArray[float][y+1][x+1] = counter+1}
                            if waveArray[float][y+1][x-1] == 0 {waveArray[float][y+1][x-1] = counter+1}
                            if waveArray[float][y-1][x+1] == 0 {waveArray[float][y-1][x+1] = counter+1}
                            if waveArray[float][y-1][x-1] == 0 {waveArray[float][y-1][x-1] = counter+1}
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
            let tekFloat = whereWaveVar.float-1
        
            counter = waveArray[whereWaveVar.float-1][whereWaveVar.koordY][whereWaveVar.koordX]
            wayWaveArray.append((tekX,tekY))
            while counter >= 1 {
                counter -= 1
                if (waveArray[tekFloat][tekY][tekX+1] == counter) {
                    tekX+=1
                    wayWaveArray.append((tekX,tekY))
                }
                else{ if (waveArray[tekFloat][tekY][tekX-1] == counter) {
                        tekX-=1
                        wayWaveArray.append((tekX,tekY))
                    }
                    else{ if (waveArray[tekFloat][tekY+1][tekX] == counter) {
                            tekY+=1
                            wayWaveArray.append((tekX,tekY))
                        }
                        else{ if (waveArray[tekFloat][tekY-1][tekX+1] == counter) {
                            tekX+=1
                            tekY-=1
                            wayWaveArray.append((tekX,tekY))
                        }
                            else{ if (waveArray[tekFloat][tekY-1][tekX-1] == counter) {
                                tekY-=1
                                tekX-=1
                                wayWaveArray.append((tekX,tekY))
                            }
                                else{ if (waveArray[tekFloat][tekY+1][tekX-1] == counter) {
                                    tekY+=1
                                    tekX-=1
                                    wayWaveArray.append((tekX,tekY))
                                }
                                    else{ if (waveArray[tekFloat][tekY+1][tekX+1] == counter) {
                                        tekY+=1
                                        tekX+=1
                                        wayWaveArray.append((tekX,tekY))
                                    }
                                        else{
                                            tekY-=1
                                            wayWaveArray.append((tekX,tekY))
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
            var lustKoord = wayWaveArray[0]
            for koord in wayWaveArray {
                mapImageView.image = DrawOnImage(startingImage: mapImageView.image!, startKoord: lustKoord, moveToKoord: koord)
                lustKoord = koord
            }
            mapImageView.image = DrawOnImageCyrcle(startingImage: mapImageView.image!, startKoord: (Int(Double(whereFromVar.koordX) * moveConstant), Int(Double(whereFromVar.koordY) * moveConstant)), endKoord: (Int(Double(whereWaveVar.koordX) * moveConstant), Int(Double(whereWaveVar.koordY) * moveConstant)))
        }
    }
    
    func DrawOnImage(startingImage: UIImage, startKoord: (Int,Int), moveToKoord: (Int,Int)) -> UIImage {
        UIGraphicsBeginImageContext(startingImage.size)
        startingImage.draw(at: CGPoint.zero)
        let context = UIGraphicsGetCurrentContext()!
        
        context.setLineWidth(2.0)
        context.setStrokeColor(UIColor.green.cgColor)
        context.move(to: CGPoint(x: Int(Double(startKoord.0) * moveConstant)+250, y: Int(Double(startKoord.1) * moveConstant)+250))
        context.addLine(to: CGPoint(x: Int(Double(moveToKoord.0) * moveConstant)+250, y: Int(Double(moveToKoord.1) * moveConstant)+250))
        context.strokePath()
        
        let myImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return myImage!
    }
    
    func DrawOnImageCyrcle(startingImage: UIImage, startKoord: (Int,Int), endKoord: (Int,Int)) -> UIImage {
        
        UIGraphicsBeginImageContext(startingImage.size)
        startingImage.draw(at: CGPoint.zero)

        let startImage = UIImage(named: "Start")
        startImage!.draw(in: CGRect(x: startKoord.0 + 230, y: startKoord.1 + 220, width: 40, height: 40))
        let finishImage = UIImage(named: "Finish")
        finishImage!.draw(in: CGRect(x: endKoord.0+230, y: endKoord.1+230, width: 40, height: 40))
        
        let myImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return myImage!
    }
    
}
