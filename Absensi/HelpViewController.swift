//
//  HelpViewController.swift
//  Absensi
//
//  Created by Unit TSI on 06/01/20.
//  Copyright © 2020 technesia. All rights reserved.
//

import UIKit

class HelpViewController: UIViewController {

    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var label4: UILabel!
    @IBOutlet weak var viewarea: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.gray.withAlphaComponent(0.8)
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapFunction))
        label1.isUserInteractionEnabled = true
        label1.addGestureRecognizer(tap)
        
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(tapFunction1))
        label2.isUserInteractionEnabled = true
        label2.addGestureRecognizer(tap1)
        
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(tapFunction2))
        label3.isUserInteractionEnabled = true
        label3.addGestureRecognizer(tap2)
        
        let tap3 = UITapGestureRecognizer(target: self, action: #selector(tapFunction3))
        label4.isUserInteractionEnabled = true
        label4.addGestureRecognizer(tap3)
    }
    
    @objc func tapFunction(sender:UITapGestureRecognizer) {
        guard let number = URL(string: "tel://" + "+628155005839") else { return }
        UIApplication.shared.open(number)
    }
    
    @objc func tapFunction1(sender:UITapGestureRecognizer) {
        guard let number = URL(string: "tel://" + "+628972106683") else { return }
        UIApplication.shared.open(number)
    }
    
    @objc func tapFunction2(sender:UITapGestureRecognizer) {
        guard let number = URL(string: "tel://" + "+62811371761") else { return }
        UIApplication.shared.open(number)
    }
    
    @objc func tapFunction3(sender:UITapGestureRecognizer) {
        guard let number = URL(string: "tel://" + "+6281357025404") else { return }
        UIApplication.shared.open(number)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let firstTouch = touches.first {
            let hitView = self.view.hitTest(firstTouch.location(in: self.view), with: event)
            
            if hitView === viewarea {
                print("touch is inside")
            } else {
                dismiss(animated: true, completion: nil)
            }
        }
    }
}
