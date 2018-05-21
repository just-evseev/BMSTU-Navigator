//
//  ViewController.swift
//  IOSDev
//
//  Created by Илья on 22.03.2018.
//  Copyright © 2018 Ilya. All rights reserved.
//

import UIKit
import Firebase

struct ClassRoom {
    var numb:Int
    var koordX:Int
    var koordY:Int
    var float:Int
    var litera: String
    var nazvanie: String
}

var ref: DatabaseReference!
var floatWaveArray = [[[Int]]]()
var floatClassArray = [[ClassRoom]]()
let prost = [[[Int]]]()


class ViewController: UIViewController{

    @IBOutlet weak var HeightConstraintOutlet: NSLayoutConstraint!
    @IBOutlet weak var BmstuLogo: UIImageView!
    @IBOutlet weak var ButtonPressed: UIButton!
    
    var downloadIdent = true
    
    func logoAnimate() {
        
        BmstuLogo.isHidden = false
        self.HeightConstraintOutlet.constant = 100
        UIView.animate(withDuration: 2.0, animations: {
            self.view.layoutIfNeeded()

        }) { _ in
            if (floatWaveArray == prost) {
                let alert = UIAlertController(title: "Нет подключения", message: "Приложение будет работать в офлайн режиме", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "хорошо", style: .cancel, handler: { _ in
                    
                }))
                self.present(alert, animated: true, completion: nil)
            }
            self.ButtonPressed.alpha = 1.0
        }
        
    }
    
    override func viewDidLoad() {
        self.ButtonPressed.alpha = 0.0
        ref = Database.database().reference()
        
        for i in 0...10 {
            ref.child("Wave").child("Plan").child("Float\(i+1)").observe(DataEventType.value) { (snapshot) in
                if let item = snapshot.value! as? [[Int]] {
                    floatWaveArray.append(item)
                }
            }
            
            ref.child("Wave").child("ClassRooms").child("Float\(i+1)").observe(DataEventType.value) { (snapshot) in
                if let item = snapshot.value! as? [[String]] {
                    for tekClassRoom in item {
                        let classRoom = ClassRoom(numb: Int(tekClassRoom[0])!, koordX: Int(tekClassRoom[1])!, koordY: Int(tekClassRoom[2])!, float: i+1, litera: tekClassRoom[3], nazvanie: tekClassRoom[4])
                        floatClassArray.append([classRoom])
                    }
                }
            }
        }
        
        logoAnimate()
        super.viewDidLoad()
    }
}

func downloatDataBase() {
    
}
