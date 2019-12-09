//
//  Switcher.swift
//  Absensi
//
//  Created by Unit TSI on 11/11/19.
//  Copyright © 2019 technesia. All rights reserved.
//

import Foundation
import UIKit

class Switcher {
    
    static func updateRootVC(){
        
        let preferences = UserDefaults.standard
        preferences.register(defaults: ["Login" : false])
        let status = preferences.bool(forKey: "Login")
        var rootVC : UIViewController?
        
        if(status == true){
            rootVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "navigationhome")
        }else{
            rootVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginController") as! LoginController
        }
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = rootVC
        
    }
    
}
