//
//  ScannerViewController.swift
//  Absensi
//
//  Created by Unit TSI on 18/12/19.
//  Copyright © 2019 technesia. All rights reserved.
//

import UIKit
import AVFoundation
import MTBBarcodeScanner

class ScannerViewController: UIViewController {
    
    @IBOutlet var preview: UIView!
    var scanner: MTBBarcodeScanner?
    var stringValue:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.scanner = MTBBarcodeScanner(previewView: self.preview)
            
            MTBBarcodeScanner.requestCameraPermission(success: { success in
                if success {
                    do {
                        // Start scanning with the back camera
                        try self.scanner?.startScanning(with: .back,
                                                        resultBlock: { codes in
                                                            self.scanner?.captureStillImage({ (image, error) in
                                                                NSLog("The image and/or error are accessible here");
                                                                if let codes = codes {
                                                                    for code in codes {
                                                                        self.stringValue = code.stringValue!
                                                                        print("Found code: \(self.stringValue)")
                                                                    }
                                                                    self.performSegue(withIdentifier: "scanner", sender: self)
                                                                }
                                                            })
                                                            self.scanner?.freezeCapture()
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
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "unwindSegueToVC2" {
//            if let vc : AddJadwalController = segue.destination as? AddJadwalController {
//                vc.data1 = detailToSend
//            }
//        }
//    }
}
