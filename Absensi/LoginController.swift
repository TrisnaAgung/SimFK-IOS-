//
//  LoginController.swift
//  Absensi
//
//  Created by Unit TSI on 11/11/19.
//  Copyright © 2019 technesia. All rights reserved.
//

import UIKit
import Toast_Swift
import Alamofire
import JGProgressHUD

class LoginController: UIViewController {

    
    @IBOutlet weak var help: UILabel!
    var iconClick = true
    @IBOutlet weak var user: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var iconpassword: UIButton!
    var hud : JGProgressHUD?
    var test: Bool!
    
    @IBOutlet weak var viewbackground: UIView!
    @IBAction func showhidepassword(_ sender: Any) {
        if(iconClick == true) {
            password.isSecureTextEntry = false
            let origImage = UIImage(named: "eyeon")
            let tintedImage = origImage?.withRenderingMode(.alwaysTemplate)
            iconpassword.setImage(tintedImage, for: .normal)
            iconpassword.tintColor = .gray
        } else {
            password.isSecureTextEntry = true
            let origImage = UIImage(named: "eyeoff")
            let tintedImage = origImage?.withRenderingMode(.alwaysTemplate)
            iconpassword.setImage(tintedImage, for: .normal)
            iconpassword.tintColor = .gray
        }
        
        iconClick = !iconClick
    }
    
    @IBAction func login(_ sender: Any) {
        hud?.show(in: self.view)
        let parameters : Parameters = [
            "username" : self.user.text as Any,
            "password" : self.password.text as Any,
        ]
        Alamofire.request("http://sim.fk.unair.ac.id/api/login", method: .post ,parameters: parameters, encoding: JSONEncoding.default).responseJSON{
            (response) in
            switch response.result {
            case .success(let json):
                self.hud?.dismiss()
                let jsondata = json as! [String : AnyObject]
                if jsondata["code"] as! Int == 200 {
                    let json1 = jsondata["success"] as! [String: AnyObject]
                    let json2 = jsondata["data"] as! [String: AnyObject]
                    let preferences = UserDefaults.standard
                    preferences.set(json2["id"] as! Int, forKey: "id")
                    preferences.set(json2["nama"] as! String, forKey: "nama")
                    preferences.set(json2["username"] as! String, forKey: "username")
                    preferences.set(json2["tipe"] as! String, forKey: "tipe")
                    preferences.set(json2["nip_nim"] as! String, forKey: "nip_nim")
                    preferences.set(json1["token"] as! String, forKey: "token")
                    preferences.set(true, forKey: "Login")
                    preferences.synchronize()
                    Switcher.updateRootVC()
                } else{
                    print("gagal")
                }
            case .failure(let error):
                self.hud?.dismiss()
                print(error)
            }
        }
//        if user.text == "test" && password.text == "test" {
//            let preferences = UserDefaults.standard
//            preferences.set(true, forKey: "Login")
//            preferences.set(user.text, forKey: "username")
//            preferences.synchronize()
//            Switcher.updateRootVC()
//        } else{
//            self.view.makeToast("Invalid User Or Password")
//        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nameleft        = UIImageView()
        let imagename       = UIImage(named:"ic_user")
        nameleft.image      = imagename
        leftimage(textfield: user, img: imagename!)

        let passleft        = UIImageView()
        let imagepass       = UIImage(named:"ic_password")
        passleft.image      = imagepass
        leftimage(textfield: password, img: imagepass!)

        let origImage = UIImage(named: "eyeoff")
        let tintedImage = origImage?.withRenderingMode(.alwaysTemplate)
        iconpassword.setImage(tintedImage, for: .normal)
        iconpassword.tintColor = .gray
        
        hud = JGProgressHUD(style: .dark)
        hud?.vibrancyEnabled = true
        hud?.textLabel.text = "Loading"
        hud?.backgroundColor = UIColor(white: 0, alpha: 0.4)
        hud?.layoutMargins = UIEdgeInsets.init(top: 0.0, left: 0.0, bottom: 10.0, right: 0.0)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapFunction))
        help.isUserInteractionEnabled = true
        help.addGestureRecognizer(tap)
        
//        let gradientLayer:CAGradientLayer = CAGradientLayer()
//        gradientLayer.frame.size = self.viewbackground.frame.size
//        gradientLayer.colors =
//            [UIColor.white.cgColor,UIColor.red.withAlphaComponent(1).cgColor]
//        viewbackground.layer.addSublayer(gradientLayer)
        
//        viewbackground.layer.addSublayer(gradient)
        
    }
    
    @objc func tapFunction(sender:UITapGestureRecognizer) {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier:"help") as? HelpViewController {
            vc.modalTransitionStyle     = .crossDissolve;
            vc.modalPresentationStyle   = .overCurrentContext
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    override func viewDidLayoutSubviews() {
        let gradient = CAGradientLayer()
        
        gradient.frame = viewbackground.frame
        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        let color = UIColor(hexString: "#066000")
        let color1 = UIColor(hexString: "#66F51D")
        gradient.colors = [color.cgColor, color1.cgColor]
        
        viewbackground.layer.insertSublayer(gradient, at: 0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func leftimage(textfield: UITextField, img: UIImage) {
        let size = 20
        let padding = 12
        let outer = UIView(frame: CGRect(x: 0, y: 0, width: size+padding, height: size))
        let imageleft = UIImageView(frame: CGRect(x: 10, y: 0, width: img.size.width, height: img.size.height))
        imageleft.image = img
        imageleft.tintColor = UIColor.black
        outer.addSubview(imageleft)
        textfield.leftView = outer
        textfield.leftViewMode = .always
        textfield.leftViewMode = UITextFieldViewMode.always
    }
    
    func rightimage(textfield: UITextField, img: UIImage) {
        let size = 20
        let padding = 12
        let outer = UIView(frame: CGRect(x: 0, y: 0, width: size+padding, height: size))
        let imageright = UIImageView(frame: CGRect(x: 10, y: 0, width: img.size.width, height: img.size.height))
        imageright.image = img
        imageright.tintColor = UIColor.black
        outer.addSubview(imageright)
        textfield.rightView = outer
        textfield.rightViewMode = .always
        textfield.rightViewMode = UITextFieldViewMode.always
    }
}

extension UIColor {
    convenience init(hexString: String, alpha: CGFloat = 1.0) {
        let hexString: String = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
        if (hexString.hasPrefix("#")) {
            scanner.scanLocation = 1
        }
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        let red = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue = CGFloat(b) / 255.0
        self.init(red:red, green:green, blue:blue, alpha:alpha)
        
    }
    
    func toHexString() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: &a)
        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        return String(format:"#%06x", rgb)
    }
}
