//
//  JadwalLiveViewController.swift
//  Absensi
//
//  Created by Unit TSI on 02/12/19.
//  Copyright © 2019 technesia. All rights reserved.
//

import UIKit
import Alamofire
import JGProgressHUD
import AVFoundation
import MTBBarcodeScanner

class JadwalLiveViewController: UIViewController {

    @IBOutlet weak var textfield_matkul: UITextField!
    @IBOutlet weak var textfield_ruangan: UITextField!
    @IBOutlet weak var textfield_prodi: UITextField!
    @IBOutlet weak var textfield_semester: UITextField!
    @IBOutlet weak var preview: UIImageView!
    var jadwalLive:JadwalLive?
    var scanner: MTBBarcodeScanner?
    
    @IBAction func scan(_ sender: Any) {
        MTBBarcodeScanner.requestCameraPermission(success: { success in
            if success {
                do {
                    // Start scanning with the front camera
                    try self.scanner?.startScanning(with: .back,
                                                    resultBlock: { codes in
                                                        if let codes = codes {
                                                            for code in codes {
                                                                let stringValue = code.stringValue!
                                                                print("Found code: \(stringValue)")
                                                            }
                                                        }
                    })
                    
                } catch {
                    NSLog("Unable to start scanning")
                }
            } else {
                let alertController = UIAlertController(title: "Scanning Unavailable", message: "This app does not have permission to access the camera", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alertController, animated: true, completion: nil)
            }
        })
    }
    let token = UserDefaults.standard.object(forKey: "token") as? String
    var hud : JGProgressHUD?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.showHUDWithTransform()
        }
        
        scanner = MTBBarcodeScanner(previewView: preview)
    }
    
    func loadlive(){
        let headers = ["Authorization" : "Bearer "+token!+"",
                       "Content-Type": "application/json"]
        
        Alamofire.request("http://sim.fk.unair.ac.id/api/jadwallive-get", method: .get ,parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJadwalLive{
            (response) in
            switch response.result {
            case .success( _):
                self.hud?.dismiss()
                self.jadwalLive = response.result.value!
                self.setLayout(live: self.jadwalLive!)
            case .failure(let error):
                self.hud?.dismiss()
                print(error)
            }
        }
    }
    
    func showHUDWithTransform() {
        hud = JGProgressHUD(style: .dark)
        hud?.vibrancyEnabled = true
        hud?.textLabel.text = "Loading"
        hud?.backgroundColor = UIColor(white: 0, alpha: 0.4)
        hud?.layoutMargins = UIEdgeInsets.init(top: 0.0, left: 0.0, bottom: 10.0, right: 0.0)
        
        hud?.show(in: self.view)
        
        loadlive()
    }
    
    func setLayout(live: JadwalLive) {
        textfield_matkul.text       = "\(live.data.ploting.namaMk) - \(live.data.ploting.namaKelas)"
        textfield_ruangan.text      = live.data.ruangbaru.namaRuang
        textfield_prodi.text        = live.data.ploting.namaProdi
        textfield_semester.text     = live.data.ploting.tingkatSemester
    }
}
