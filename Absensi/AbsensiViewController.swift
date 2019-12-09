//
//  AbsensiViewController.swift
//  Absensi
//
//  Created by Unit TSI on 06/12/19.
//  Copyright © 2019 technesia. All rights reserved.
//

import UIKit
import Alamofire
import JGProgressHUD
import ActionSheetPicker_3_0

class AbsensiViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    let token = UserDefaults.standard.object(forKey: "token") as? String
    
    @IBOutlet weak var textfieldperiode: UITextField!
    @IBOutlet weak var tableabsen: UITableView!
    @IBOutlet weak var labelmakan: UILabel!
    @IBOutlet weak var labelinsentif: UILabel!
    @IBOutlet weak var labeltotalmakan: UILabel!
    @IBOutlet weak var labeltotalinsentif: UILabel!
    @IBOutlet weak var viewtotal: UIView!
    @IBAction func buttonrefresh(_ sender: Any) {
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.showHUDWithTransform()
        }
    }
    @IBAction func addperiode(_ sender: Any) {
        let acp = ActionSheetMultipleStringPicker(title: "Periode", rows: [
            Months,
            array
            ], initialSelection: [self.selectedmonth, self.selectedyear], doneBlock: {
                picker, values, indexes in
                
                self.selectedmonth = values![0] as! Int
                self.selectedyear = values![1] as! Int
                let row = indexes as? NSArray
                let bulan = row?[0] as! String
                let tahun = String(describing: row![1])
                self.textfieldperiode.text = tahun+"-"+String(format: "%02d", self.selectedmonth + 1)
                self.monthString = String(format: "%02d", self.selectedmonth + 1)
                self.yearString = tahun
                
//                self.blth.text = bulan + " " + tahun
//                self.monthyear = tahun+String(format: "%02d", self.selectedmonth+1)
                return
        }, cancel: { ActionMultipleStringCancelBlock in return }, origin: sender)
        acp?.show()
    }
    
    let Months = ["January","February","March","April","May","June","July","August","September","October","November","December"]
    
    var absensi:Absensi?
    var hud : JGProgressHUD?
    
    var array: [Int] = [Int]()
    var selectedmonth: Int = 0
    var selectedyear: Int = 0
    var monthString:String?
    var yearString:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM"
        monthString = dateFormatter.string(from: Date())
        let monthInt = Int(monthString!)!
        
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "yyyy"
        yearString = format.string(from: date)
        let yearint = Int(yearString!)!
        
        array = Array(1900...yearint)
        
        selectedmonth = monthInt - 1
        selectedyear = array.endIndex - 1
        
        self.textfieldperiode.text = yearString!+"-"+monthString!
        
        self.viewtotal.isHidden     = true

        self.tableabsen.delegate    = self
        self.tableabsen.dataSource  = self
        textfieldperiode.delegate   = self
        
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.showHUDWithTransform()
        }
        
//        loaddata()
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return false
    }
    
    func loaddata(){
        let headers = ["Authorization" : "Bearer "+token!+"",
                       "Content-Type": "application/json"]
        
        Alamofire.request("http://sim.fk.unair.ac.id/api/absensikehadiran-get/\(yearString!)-\(monthString!)", method: .get ,parameters: nil, encoding: JSONEncoding.default, headers: headers).responseAbsensi{
            (response) in
            switch response.result {
            case .success( _):
                self.hud?.dismiss()
                self.absensi                    = response.result.value!
                self.tableabsen.reloadData()
                
                if (self.absensi?.data.count ?? 0) > 0 {
                    self.labelmakan.text            = self.absensi?.makan.desc
                    self.labelinsentif.text         = self.absensi?.insentif.desc
                    
                    let formatter = NumberFormatter()
                    formatter.locale = Locale(identifier: "id_ID")
                    formatter.groupingSeparator = "."
                    formatter.numberStyle = .decimal
                    if let formattedTipAmount = formatter.string(from: self.absensi?.makan.fee as! NSNumber) {
                        self.labeltotalmakan.text       = "Rp" + formattedTipAmount
                    }
                    
                    if let formattedintensif = formatter.string(from: self.absensi?.insentif.fee as! NSNumber) {
                        self.labeltotalinsentif.text    = "Rp" + formattedintensif
                    }
                    self.viewtotal.isHidden = false
                } else {
                    self.viewtotal.isHidden = true
                }
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
        
        loaddata()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.absensi?.data.count ?? 0)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "absensicell", for: indexPath)
            as! AbsensiTableViewCell
        
        let dateFormatterGet        = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let jam                     = DateFormatter()
        jam.dateFormat              = "HH:mm"
        
        let tanggal                 = DateFormatter()
        tanggal.dateFormat          = "dd"
        
        let hari                    = DateFormatter()
        hari.dateFormat             = "EEEE"
        
        cell.labelmasuk.text        = jam.string(from:  dateFormatterGet.date(from: (self.absensi?.data[indexPath.row].checkIn)!)!)
        
        if self.absensi?.data[indexPath.row].checkOut == nil {
            cell.labelpulang.text   = "-"
            cell.labelwaktu.text    = "-"
        } else {
            cell.labelpulang.text   = jam.string(from:  dateFormatterGet.date(from: (self.absensi?.data[indexPath.row].checkOut)!)!)
            cell.labelwaktu.text    = self.absensi?.data[indexPath.row].menit
        }
        
        cell.labeltanggal.text      = tanggal.string(from:  dateFormatterGet.date(from: (self.absensi?.data[indexPath.row].checkIn)!)!)
        cell.labelhari.text         = hari.string(from:  dateFormatterGet.date(from: (self.absensi?.data[indexPath.row].checkIn)!)!)
//        cell.labelmatkul.text   = self.jadwalkelas?.data[indexPath.row].ploting.namaMk
//        cell.labelkelas.text    = self.jadwalkelas?.data[indexPath.row].ploting.namaKelas
        return cell
    }
}
