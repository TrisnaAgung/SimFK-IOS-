//
//  JadwalController.swift
//  Absensi
//
//  Created by Unit TSI on 14/11/19.
//  Copyright © 2019 technesia. All rights reserved.
//

import UIKit
import JGProgressHUD
import Alamofire

class JadwalController: UIViewController,UITableViewDataSource, UITableViewDelegate, UIActionSheetDelegate{
    
    let token = UserDefaults.standard.object(forKey: "token") as? String
    var jadwalkelas:JadwalKelas?
    var hud : JGProgressHUD?
    var detailToSend: JadwalData?
    var refreshControl = UIRefreshControl()
    
    @IBAction func click(_ sender: Any) {
        let popOverVC = self.storyboard?.instantiateViewController(withIdentifier: "matkul") as! MatkulViewController
        popOverVC.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        self.present(popOverVC, animated: true)
    }
    @IBOutlet weak var table: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.table.delegate = self
        self.table.dataSource = self
        
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.showHUDWithTransform()
        }
        
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(pullrefresh(sender:)), for: .valueChanged)
        table.addSubview(refreshControl)
    }
    
    func loaddata(){
        let headers = ["Authorization" : "Bearer "+token!+"",
                       "Content-Type": "application/json"]
        
        Alamofire.request("\(BASE_URL)api/jadwalkelas-list", method: .get ,parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJadwalKelas{
            (response) in
            switch response.result {
            case .success( _):
                self.hud?.dismiss()
                self.jadwalkelas = response.result.value!
                self.table.reloadData()
            case .failure(let error):
                self.hud?.dismiss()
                print(error)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.jadwalkelas?.data.count ?? 0)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "matkulcell", for: indexPath)
            as! MatkulTableViewCell
        cell.labelmatkul.text   = self.jadwalkelas?.data[indexPath.row].ploting.namaMk
        cell.labelkelas.text    = self.jadwalkelas?.data[indexPath.row].ruangbaru.namaRuang
        
        let dateFormatterGet1       = DateFormatter()
        dateFormatterGet1.dateFormat = "yyyy-MM-dd"
        
        let hari                    = DateFormatter()
        hari.dateFormat             = "EEEE"
        
        let tanggal                 = DateFormatter()
        tanggal.dateFormat          = "dd-MM-yyyy"
        
        let jam                     = DateFormatter()
        jam.dateFormat              = "HH:mm"
        
        let tgl                     = dateFormatterGet1.date(from: (self.jadwalkelas?.data[indexPath.row].tanggal)!)
        
        cell.labelwaktu.text   = "\(hari.string(from: tgl!)), \(tanggal.string(from: tgl!)) [\(self.jadwalkelas!.data[indexPath.row].jamAwal) s/d \(self.jadwalkelas!.data[indexPath.row].jamAkhir)]"
        
        return cell
    }
    
    func didSelectContact(){
        let alert = UIAlertController(title: "Pilih Salah Satu", message: "", preferredStyle: UIAlertControllerStyle.actionSheet)
        let edit = UIAlertAction(title: "Edit", style: UIAlertActionStyle.default) { (UIAlertAction) in
            self.performSegue(withIdentifier: "addjadwal", sender: self.detailToSend)
        }
        let delete = UIAlertAction(title: "Delete", style: UIAlertActionStyle.default) { (UIAlertAction) in
            SweetAlert().showAlert("Hapus", subTitle: "Apakah anda yakin akan menghapus \n data anda?", style: AlertStyle.warning, buttonTitle:"Iya", buttonColor:UIColor.green , otherButtonTitle:  "Tidak", otherButtonColor: UIColor.red) { (isOtherButton) -> Void in
                if isOtherButton == true {
                    self.matkuldelete(id: (self.detailToSend?.id)!)
                }
                else {
                    print("Cancel Button  Pressed")
                }
            }
        }
//        let cancel = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil)
    
        edit.setValue(UIImage(named:"ic_edit")?.withRenderingMode(.alwaysOriginal), forKey: "image")
        delete.setValue(UIImage(named:"ic_delete")?.withRenderingMode(.alwaysOriginal), forKey: "image")
        alert.addAction(edit)
        alert.addAction(delete)
//        alert.addAction(cancel)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        detailToSend = self.jadwalkelas?.data[indexPath.row]
        self.didSelectContact()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "addjadwal") {
            let viewController          = segue.destination as! AddJadwalController
            viewController.data         = detailToSend
            viewController.edit         = true
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
    
    func matkuldelete(id: Int){
        hud?.show(in: self.view)
        let parameters : Parameters = [
            "id" : id
        ]
        let headers = ["Authorization" : "Bearer "+token!+"",
                       "Content-Type": "application/json"]
        Alamofire.request("\(BASE_URL)api/jadwalkelas-hapus", method: .post ,parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON{
            (response) in
            switch response.result {
            case .success(let json):
                self.hud?.dismiss()
                let jsondata = json as! [String : AnyObject]
                let json2 = jsondata["data"] as! [String: AnyObject]
                SweetAlert().showAlert(json2["status"] as! String, subTitle: "Data Berhasil Dihapus", style: AlertStyle.success, buttonTitle:  "OK") { (isOtherButton) -> Void in
                    if isOtherButton == true {
                        DispatchQueue.main.asyncAfter(deadline: .now()) {
                            self.showHUDWithTransform()
                        }
                    }
                }
//                if jsondata["code"] as! Int == 200 {
//
//                } else{
//                    print("gagal")
//                }
            case .failure(let error):
                self.hud?.dismiss()
                print(error)
            }
        }
    }
    
    @IBAction func refresh(segue:UIStoryboardSegue) {
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.showHUDWithTransform()
        }
    }
    
    @objc func pullrefresh(sender:AnyObject) {
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.showHUDWithTransform()
        }
        refreshControl.endRefreshing()
    }
}
