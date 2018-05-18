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
    var way:[Int] = []
    var classroom:[(Int,Int)] = []
    var schet:Int = 0
    let moveConstant = 4.85
    var wayWaveArray = [(Int,Int)]()
    
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
        mapScrollView.maximumZoomScale = 6.0
        mapScrollView.minimumZoomScale = 1.0
        mapScrollView.zoomScale = 1.0
        
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
            WaveAlgorithm(whereWave: Int(whereTextField.text!)!, whereFrom: Int(whereFromTextField.text!)!)
        }
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)        
        self.navigationController?.setNavigationBarHidden(false, animated: animated)

    }
    
//    func viewForZooming(mapScrollView: UIScrollView) -> UIView? {
//        return self.mapImageView
//    }
    
    func WaveAlgorithm(whereWave: Int, whereFrom:Int){
        var whereWaveVar,whereFromVar:ClassRoom
        whereWaveVar = ClassRoom(numb: 200, koordX: 97, koordY: 96, float: 2, litera: "_", nazvanie: "_")
        whereFromVar = whereWaveVar
        
        for float in floatClassArray{
            for classRoom in float{
                if classRoom.numb==whereWave {
                    whereWaveVar=classRoom
                    print("======куда======")
                    print(whereWaveVar)
                }
                if classRoom.numb==whereFrom {
                    whereFromVar=classRoom
                     print("======откуда======")
                    print(whereFromVar)
                }
            }
        }
        var waveArray = floatWaveArray
        var counter:Int = 0
        var flagWave:Bool = true
        print("Этаж \(whereWaveVar.float-1); X=\(whereWaveVar.koordX),Y=\(whereWaveVar.koordY)")
        print("То, куда мы 1 кладем (Должно быть 0): \(waveArray[whereFromVar.float-1][whereFromVar.koordY][whereFromVar.koordX])")
        print("Тут должен быть 0: \(waveArray[whereWaveVar.float-1][whereWaveVar.koordX][whereWaveVar.koordY])")
        waveArray[whereFromVar.float-1][whereFromVar.koordY][whereFromVar.koordX] = 1
        while  (waveArray[whereWaveVar.float-1][whereWaveVar.koordY][whereWaveVar.koordX] == 0)&&(flagWave) {
            flagWave = false
            counter += 1
            for float in 1...1 {//<- тут перечисление уже готовых этажей для обработки
                for y in 1...98 {
                    for x in 1...98 {
                        if waveArray[float][y][x] == counter {
                            print("\(x),\(y); \(counter)")
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
            let tekFloat = whereWaveVar.float-1
            counter = waveArray[whereWaveVar.float-1][whereWaveVar.koordY][whereWaveVar.koordX]
            wayWaveArray.append((tekX,tekY))

//            let startingImage = mapImageView.image!
//            UIGraphicsBeginImageContext(startingImage.size)
//            startingImage.draw(at: CGPoint.zero)
//            let context = UIGraphicsGetCurrentContext()!
//            context.setLineWidth(2.0)
//            context.setStrokeColor(UIColor.red.cgColor)
//            context.move(to: CGPoint(x: Int(Double(tekX)*moveConstant), y: Int(Double(tekY)*moveConstant)))
            
            print("counter = \(counter)")
            while counter > 2 {
                counter -= 1
                if (waveArray[tekFloat][tekY][tekX+1] == counter) {
                    tekX+=1
                    wayWaveArray.append((tekX,tekY))
//                    context.addLine(to: CGPoint(x: Int(Double(tekX)*moveConstant), y: Int(Double(tekY)*moveConstant)))
//                    print("Float:\(tekFloat); X:\(tekX); Y\(tekY)")
                    
                }
                else{ if (waveArray[tekFloat][tekY][tekX-1] == counter) {
                        tekX-=1
                        wayWaveArray.append((tekX,tekY))
//                        context.addLine(to: CGPoint(x: Int(Double(tekX)*moveConstant), y: Int(Double(tekY)*moveConstant)))
//                        print("Float:\(tekFloat); X:\(tekX); Y\(tekY)")
                    
                }
                    else{ if (waveArray[tekFloat][tekY+1][tekX] == counter) {
                            tekY+=1
                            wayWaveArray.append((tekX,tekY))
//                        context.addLine(to: CGPoint(x: Int(Double(tekX)*moveConstant), y: Int(Double(tekY)*moveConstant)))
//                            print("Float:\(tekFloat); X:\(tekX); Y\(tekY)")
                    
                    }
                        else{
                            tekY-=1
                            wayWaveArray.append((tekX,tekY))
//                            context.addLine(to: CGPoint(x: Int(Double(tekX)*moveConstant), y: Int(Double(tekY)*moveConstant)))
//                            print("Float:\(tekFloat); X:\(tekX); Y\(tekY)")
                            
                        }
                    }
                }
                
            }
//            context.strokePath()

//            let myImage = UIGraphicsGetImageFromCurrentImageContext()
//            UIGraphicsEndImageContext()
//            mapImageView.image = myImage
            
            print(wayWaveArray)
            var lustKoord = wayWaveArray[0]
            for koord in wayWaveArray {
                mapImageView.image = DrawOnImage(startingImage: mapImageView.image!, startKoord: lustKoord, moveToKoord: koord)
                lustKoord = koord
            }
        }
    }
    
    func DrawOnImage(startingImage: UIImage, startKoord: (Int,Int), moveToKoord: (Int,Int)) -> UIImage {
        
        // Create a context of the starting image size and set it as the current one
        UIGraphicsBeginImageContext(startingImage.size)
        
        // Draw the starting image in the current context as background
        startingImage.draw(at: CGPoint.zero)
        
        // Get the current context
        let context = UIGraphicsGetCurrentContext()!
        
        // Draw a red line
        context.setLineWidth(2.0)
        context.setStrokeColor(UIColor.red.cgColor)
        print("X координата туда откуда идти линии \(Int(Double(startKoord.0) * moveConstant))")
        print("Y координата туда откуда идти линии \(Int(Double(startKoord.1) * moveConstant))")
        context.move(to: CGPoint(x: Int(Double(startKoord.0) * moveConstant), y: Int(Double(startKoord.1) * moveConstant)))
        print("X координата туда куда идти линии \(Int(Double(moveToKoord.0) * moveConstant))")
        print("Y координата туда куда идти линии \(Int(Double(moveToKoord.1) * moveConstant))")
        context.addLine(to: CGPoint(x: Int(Double(moveToKoord.0) * moveConstant), y: Int(Double(moveToKoord.1) * moveConstant)))
        context.strokePath()
        
        // Save the context as a new UIImage
        let myImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        // Return modified image
        return myImage!
    }
    
}
