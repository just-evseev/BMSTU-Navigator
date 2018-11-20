//
//  ImageDrawer.swift
//  IOSDev
//
//  Created by En-ios1 on 16/11/2018.
//  Copyright © 2018 Ilya. All rights reserved.
//

import Foundation
import Photos

class ImageDrawer {
    
    private var moveConstant = 5.0
    
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
        startImage!.draw(in: CGRect(x: Int(Double(startKoord.0) * moveConstant) + 230, y: Int(Double(startKoord.1) * moveConstant) + 210, width: 40, height: 40))
        
        
        let myImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return myImage!
    }
    
    func DrawOnImageEndCyrcle(startingImage: UIImage, endKoord: (Int, Int)) -> UIImage {
        
        UIGraphicsBeginImageContext(startingImage.size)
        startingImage.draw(at: CGPoint.zero)
        
        let finishImage = UIImage(named: "Finish")
        finishImage!.draw(in: CGRect(x: Int(Double(endKoord.0) * moveConstant) + 230, y: Int(Double(endKoord.1) * moveConstant) + 230, width: 40, height: 40))
        
        let myImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return myImage!
    }
    
    func DrawOnImageStairs(startingImage: UIImage, koord: (Int, Int), napr: Int) -> UIImage {
        
        UIGraphicsBeginImageContext(startingImage.size)
        startingImage.draw(at: CGPoint.zero)
        
        if napr == 1 {
            let stairsImage = UIImage(named: "down")
            stairsImage!.draw(in: CGRect(x: Int(Double(koord.0) * moveConstant) + 240, y: Int(Double(koord.1) * moveConstant) + 240, width: 20, height: 20))
        } else {
            let stairsImage = UIImage(named: "up")
            stairsImage!.draw(in: CGRect(x: Int(Double(koord.0) * moveConstant) + 240, y: Int(Double(koord.1) * moveConstant) + 240, width: 20, height: 20))
        }
        
        let myImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return myImage!
    } 
}
