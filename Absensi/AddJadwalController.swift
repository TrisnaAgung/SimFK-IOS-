//
//  AddJadwalController.swift
//  Absensi
//
//  Created by Unit TSI on 15/11/19.
//  Copyright © 2019 technesia. All rights reserved.
//

import UIKit
import Alamofire
import JGProgressHUD
import ActionSheetPicker_3_0

class AddJadwalController: UIViewController,UITextFieldDelegate {
    
    var data:JadwalData?
    var data1:RuangData?
    var datatipe:TipeData?
    var data2:Datum?
    let token = UserDefaults.standard.object(forKey: "token") as? String
    var ruang:Ruang?
    var matkul:Matkul?
    var tipekelas:Tipe?
    var hud : JGProgressHUD?
    var edit: Bool =  false
    var datemulai:Date?
    var dateselesai:Date?
    var tanggal:Date?
    var tipe:String?
    var idjadwalkelas:Int?
    var ruangbaru:String?
    var id:Int?
    var jenis:String?
    
    @IBOutlet weak var labelhari: UILabel!
    @IBOutlet weak var labeltanggal: UILabel!
    @IBOutlet weak var labelmulai: UILabel!
    @IBOutlet weak var labelselesai: UILabel!
    @IBOutlet weak var labelruangan: UILabel!
    @IBOutlet weak var labelprodi: UILabel!
    @IBOutlet weak var labelsemester: UILabel!
    @IBOutlet weak var labeltipe: UILabel!
    
    
    @IBOutlet weak var textfieldhari: UITextField!
    @IBOutlet weak var textfieldtanggal: UITextField!
    @IBOutlet weak var textfieldmulai: UITextField!
    @IBOutlet weak var textfieldselesai: UITextField!
    @IBOutlet weak var textfieldmatkul: UITextField!
    @IBOutlet weak var textfieldruangan: UITextField!
    @IBOutlet weak var textfieldprodi: UITextField!
    @IBOutlet weak var textfieldsemester: UITextField!
    @IBOutlet weak var textfieldtipe: UITextField!
    @IBOutlet weak var scrollview: UIScrollView!
    
    @IBOutlet weak var buttonsimpan: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
//        scrollview.delaysContentTouches = true

        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.showHUDWithTransform()
        }
        
        textfieldmatkul.delegate    = self
        textfieldmulai.delegate     = self
        textfieldselesai.delegate   = self
        textfieldtanggal.delegate   = self
        textfieldhari.delegate      = self
        textfieldruangan.delegate   = self
        textfieldprodi.delegate     = self
        textfieldsemester.delegate  = self
        textfieldtipe.delegate      = self
        
        labelhari.isHidden          = true
        labeltanggal.isHidden       = true
        labelmulai.isHidden         = true
        labelselesai.isHidden       = true
        labelruangan.isHidden       = true
        labelprodi.isHidden         = true
        labelsemester.isHidden      = true
        labeltipe.isHidden          = true
        
        textfieldmulai.isHidden     = true
        textfieldselesai.isHidden   = true
        textfieldhari.isHidden      = true
        textfieldtanggal.isHidden   = true
        textfieldruangan.isHidden   = true
        textfieldprodi.isHidden     = true
        textfieldsemester.isHidden  = true
        textfieldtipe.isHidden      = true
        
        buttonsimpan.isHidden       = true
        
        datemulai                   = Date()
        dateselesai                 = Date()
        tanggal                     = Date()
        
        if data != nil {
            textfieldmulai.text         = data?.jamAwal
            textfieldselesai.text       = data?.jamAkhir
//            textfieldhari.text          = data?.ploting.namaHari
            textfieldmatkul.text        = "\(data?.ploting.namaMk ?? "") - \(data?.ploting.namaKelas ?? "")"
            textfieldruangan.text       = data?.ruangbaru.namaRuang
            textfieldprodi.text         = data?.ploting.namaProdi
            textfieldsemester.text      = data?.ploting.tingkatSemester
            textfieldtanggal.text       = data?.tanggal
            if data?.tipemengajar != nil {
                textfieldtipe.text      = data?.tipemengajar?.desc
            } else {
                textfieldtipe.text      = "-"
            }
            
            let dateFormatter           = DateFormatter()
            dateFormatter.dateFormat    = "HH:mm"
            
            let tanggalFormatter        = DateFormatter()
            tanggalFormatter.dateFormat = "yyyy-MM-dd"
            
            let hari                    = DateFormatter()
            hari.dateFormat             = "EEEE"

            datemulai                   = dateFormatter.date(from: "\(data?.jamAwal ?? "")")
            dateselesai                 = dateFormatter.date(from: "\(data?.jamAkhir ?? "")")
            tanggal                     = tanggalFormatter.date(from: "\(data?.tanggal ?? "")")
            ruangbaru                   = data?.ruangBaru
            jenis                       = data?.tipe
            textfieldhari.text          = hari.string(from: self.tanggal!)
            
            labelhari.isHidden          = false
            labeltanggal.isHidden       = false
            labelmulai.isHidden         = false
            labelselesai.isHidden       = false
            labelruangan.isHidden       = false
            labelprodi.isHidden         = false
            labelsemester.isHidden      = false
            labeltipe.isHidden          = false
            
            textfieldmulai.isHidden     = false
            textfieldselesai.isHidden   = false
            textfieldhari.isHidden      = false
            textfieldtanggal.isHidden   = false
            textfieldruangan.isHidden   = false
            textfieldprodi.isHidden     = false
            textfieldsemester.isHidden  = false
            textfieldtipe.isHidden      = false
            
            buttonsimpan.isHidden       = false
        }
    }

    @IBAction func popupmatkul(_ sender: Any) {
        if edit == false {
            if let vc = self.storyboard?.instantiateViewController(withIdentifier:"dialog") as? MatkulViewController {
                vc.modalTransitionStyle     = .crossDissolve;
                vc.modalPresentationStyle   = .overCurrentContext
                vc.matkul                   = self.matkul
                self.present(vc, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func popuptipe(_ sender: Any) {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier:"dialog2") as? TipeViewController {
            vc.modalTransitionStyle     = .crossDissolve;
            vc.modalPresentationStyle   = .overCurrentContext
            vc.tipekelas                = self.tipekelas
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    override func viewDidLayoutSubviews() {
        let contentRect: CGRect = scrollview.subviews.reduce(into: .zero) { rect, view in
            rect = rect.union(view.frame)
        }
        scrollview.contentSize = contentRect.size
    }
    
    @IBAction func unwindToVC1(segue:UIStoryboardSegue) {
        if data2 != nil {
            textfieldmulai.text         = data2?.jamMulai
            textfieldselesai.text       = data2?.jamSelesai
            textfieldhari.text          = data2?.namaHari
            textfieldmatkul.text        = "\(data2?.namaMk ?? "") - \(data2?.namaKelas ?? "")"
            textfieldruangan.text       = data2?.namaRuangan
            textfieldprodi.text         = data2?.namaProdi
            textfieldsemester.text      = data2?.tingkatSemester
            
            let dateFormatter           = DateFormatter()
            dateFormatter.dateFormat    = "HH:mm"
            
            datemulai                   = dateFormatter.date(from: "\(data2?.jamMulai ?? "")")
            dateselesai                 = dateFormatter.date(from: "\(data2?.jamSelesai ?? "")")
            ruangbaru                   = data2?.idRuangan
            
            labelhari.isHidden          = false
            labeltanggal.isHidden       = false
            labelmulai.isHidden         = false
            labelselesai.isHidden       = false
            labelruangan.isHidden       = false
            labelprodi.isHidden         = false
            labelsemester.isHidden      = false
            labeltipe.isHidden          = false
            
            textfieldmulai.isHidden     = false
            textfieldselesai.isHidden   = false
            textfieldhari.isHidden      = false
            textfieldtanggal.isHidden   = false
            textfieldruangan.isHidden   = false
            textfieldprodi.isHidden     = false
            textfieldsemester.isHidden  = false
            textfieldtipe.isHidden      = false
            
            buttonsimpan.isHidden       = false
        }
    }
    
    @IBAction func unwindToVC2(segue:UIStoryboardSegue) {
        if data1 != nil {
            data?.ruangBaru             = data1?.kodeCyber ?? ""
            data?.ruangbaru.namaRuang   = data1?.namaRuang ?? ""
            data?.ruangbaru.kodeCyber   = data1?.kodeCyber ?? ""
            ruangbaru                   = data1?.kodeCyber ?? ""
            
            textfieldruangan.text       = data1?.namaRuang ?? ""
        }
    }
    
    @IBAction func unwindToVC3(segue:UIStoryboardSegue) {
        if datatipe != nil {
            textfieldtipe.text      = datatipe?.desc ?? ""
            jenis                   = datatipe?.kode ?? ""
        }
    }
    
    func loadmatkul(){
        let headers = ["Authorization" : "Bearer "+token!+"",
                       "Content-Type": "application/json"]
        
        Alamofire.request("http://sim.fk.unair.ac.id/api/ploting-list", method: .get ,parameters: nil, encoding: JSONEncoding.default, headers: headers).responseMatkul{
            (response) in
            switch response.result {
            case .success( _):
                self.matkul = response.result.value!
                self.loadruang()
            case .failure(let error):
                self.hud?.dismiss()
                print(error)
            }
        }
    }
    
    func loadruang(){
        let headers = ["Authorization" : "Bearer "+token!+"",
                       "Content-Type": "application/json"]
        
        Alamofire.request("http://sim.fk.unair.ac.id/api/ruang-list", method: .get ,parameters: nil, encoding: JSONEncoding.default, headers: headers).responseRuang{
            (response) in
            switch response.result {
            case .success( _):
//                self.hud?.dismiss()
                self.ruang = response.result.value!
                self.loadtipe()
            case .failure(let error):
                self.hud?.dismiss()
                print(error)
            }
        }
    }
    
    func loadtipe(){
        let headers = ["Authorization" : "Bearer "+token!+"",
                       "Content-Type": "application/json"]
        
        Alamofire.request("http://sim.fk.unair.ac.id/api/tipekelas-list", method: .get ,parameters: nil, encoding: JSONEncoding.default, headers: headers).responseTipe{
            (response) in
            switch response.result {
            case .success( _):
                self.hud?.dismiss()
                self.tipekelas = response.result.value!
            case .failure(let error):
                self.hud?.dismiss()
                print(error)
            }
        }
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return false
    }
    
    func showHUDWithTransform() {
        hud = JGProgressHUD(style: .dark)
        hud?.vibrancyEnabled = true
        hud?.textLabel.text = "Loading"
        hud?.backgroundColor = UIColor(white: 0, alpha: 0.4)
        hud?.layoutMargins = UIEdgeInsets.init(top: 0.0, left: 0.0, bottom: 10.0, right: 0.0)
        
        hud?.show(in: self.view)
        
        loadmatkul()
    }
    
    @IBAction func addjammulai(_ sender: Any) {
        let datePicker = ActionSheetDatePicker(title: "Jam Mulai", datePickerMode: UIDatePickerMode.time, selectedDate: datemulai, doneBlock: {
            picker, value, index in
            
            let dateFormatterGet        = DateFormatter()
            dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
            
            let dateFormatter           = DateFormatter()
            dateFormatter.dateFormat    = "HH:mm"
            
            self.datemulai              = dateFormatterGet.date(from: "\(value ?? "")")

            self.textfieldmulai.text    = dateFormatter.string(from: self.datemulai!)
            self.data?.jamAwal          = dateFormatter.string(from: self.datemulai!)
        
            return
        }, cancel: { ActionStringCancelBlock in return }, origin: sender as! UIView)
        datePicker?.show()
    }
    @IBAction func addjamselesai(_ sender: Any) {
        let datePicker = ActionSheetDatePicker(title: "Jam Selesai", datePickerMode: UIDatePickerMode.time, selectedDate: dateselesai, doneBlock: {
            picker, value, index in
            
            let dateFormatterGet        = DateFormatter()
            dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
            
            let dateFormatter           = DateFormatter()
            dateFormatter.dateFormat    = "HH:mm"
            
            self.dateselesai            = dateFormatterGet.date(from: "\(value ?? "")")
            
            let jam                     = dateFormatter.string(from: self.dateselesai!)
            
            let difference = Calendar.current.dateComponents([.hour, .minute], from: dateFormatter.date(from: self.textfieldmulai.text!)!, to: dateFormatter.date(from: jam)!)
            
            if difference.hour! < 0 || difference.minute! < 0 {
                print("error")
            } else {
                self.textfieldselesai.text  = dateFormatter.string(from: self.dateselesai!)
                self.data?.jamAkhir         = dateFormatter.string(from: self.dateselesai!)
            }
            
            return
        }, cancel: { ActionStringCancelBlock in return }, origin: sender as! UIView)
        datePicker?.show()
    }
    @IBAction func addtanggal(_ sender: Any) {
        let datePicker = ActionSheetDatePicker(title: "Date:", datePickerMode: UIDatePickerMode.date, selectedDate: tanggal, doneBlock: {
            picker, value, index in
            
            let dateFormatterGet        = DateFormatter()
            dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
            
            let dateFormatter           = DateFormatter()
            dateFormatter.dateFormat    = "yyyy-MM-dd"
            
            let hari                    = DateFormatter()
            hari.dateFormat             = "EEEE"
            
            self.tanggal                = dateFormatterGet.date(from: "\(value ?? "")")

            self.textfieldtanggal.text  = dateFormatter.string(from: self.tanggal!)
            
            self.data?.tanggal          = dateFormatter.string(from: self.tanggal!)
            
            self.textfieldhari.text     = hari.string(from: self.tanggal!)
            
            return
        }, cancel: { ActionStringCancelBlock in return }, origin: sender as! UIView)
        datePicker?.show()
    }
    @IBAction func popupruang(_ sender: Any) {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier:"dialog1") as? RuangViewController {
            vc.modalTransitionStyle     = .crossDissolve;
            vc.modalPresentationStyle   = .overCurrentContext
            vc.ruang                    = self.ruang
            self.present(vc, animated: true, completion: nil)
        }
    }
    @IBAction func simpan(_ sender: Any) {
        if self.jenis == nil {
            let alert = UIAlertController(title: "Peringatan", message: "Tipe Kelas Tidak boleh Kosong", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                switch action.style{
                case .default:
                    print("default")
                    
                case .cancel:
                    print("cancel")
                    
                case .destructive:
                    print("destructive")
                    
                    
                }}))
            self.present(alert, animated: true, completion: nil)
        } else if self.textfieldtanggal.text?.count == 0 {
            let alert = UIAlertController(title: "Peringatan", message: "Tanggal Tidak boleh Kosong", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                switch action.style{
                case .default:
                    print("default")
                    
                case .cancel:
                    print("cancel")
                    
                case .destructive:
                    print("destructive")
                    
                    
                }}))
            self.present(alert, animated: true, completion: nil)
        } else {
            SweetAlert().showAlert("Simpan", subTitle: "Apakah anda yakin dengan \n data anda?", style: AlertStyle.warning, buttonTitle:"Iya", buttonColor:UIColor.green , otherButtonTitle:  "Tidak", otherButtonColor: UIColor.red) { (isOtherButton) -> Void in
                if isOtherButton == true {
                    self.simpan()
                }
                else {
                    print("Cancel Button  Pressed")
                }
            }
        }
    }
    
    func simpan(){
        hud?.show(in: self.view)
        if edit == false {
            tipe            = "Add"
            idjadwalkelas   = data2?.idJadwalKelas
            id              = 0
        } else{
            tipe            = "Edit"
            idjadwalkelas   = Int(data?.idJadwalKelas ?? "")
            id              = data?.id
        }
        
        let headers = ["Authorization" : "Bearer "+token!+"",
                       "Content-Type": "application/json"]
        
        let parameters : Parameters = [
            "id"                : id as Any,
            "tipe"              : tipe as Any,
            "id_jadwal_kelas"   : idjadwalkelas as Any,
            "tanggal"           : self.textfieldtanggal.text as Any,
            "ruang_baru"        : ruangbaru as Any,
            "jam_awal"          : self.textfieldmulai.text as Any,
            "jam_akhir"         : self.textfieldselesai.text as Any,
            "jenis"             : jenis as Any,
            ]
        Alamofire.request("http://sim.fk.unair.ac.id/api/jadwalkelas-simpan", method: .post ,parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseSimpanMatkul{
            (response) in
            switch response.result {
            case .success( _):
                self.hud?.dismiss()
                SweetAlert().showAlert(response.result.value?.data.status ?? "", subTitle: "Data Berhasil Disimpan", style: AlertStyle.success, buttonTitle:  "OK") { (isOtherButton) -> Void in
                    if isOtherButton == true {
                        self.performSegue(withIdentifier: "refresh", sender: self)
                    }
                }
            case .failure(let error):
                self.hud?.dismiss()
                print("Error \(error)")
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "refresh" {
            if let vc : JadwalController = segue.destination as? JadwalController {
//                vc.data1 = detailToSend
            }
        }
    }
}
