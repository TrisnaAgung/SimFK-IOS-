//
//  HistoryMengajarViewController.swift
//  Absensi
//
//  Created by Unit TSI on 19/12/19.
//  Copyright © 2019 technesia. All rights reserved.
//

import UIKit
import JGProgressHUD
import Alamofire

class HistoryMengajarViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {
    
    let token = UserDefaults.standard.object(forKey: "token") as? String
    var jadwalkelas:JadwalKelas?
    var hud : JGProgressHUD?
    var refreshControl = UIRefreshControl()

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
        
        Alamofire.request("http://sim.fk.unair.ac.id/api/absensimengajar-get", method: .get ,parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJadwalKelas{
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "historycell", for: indexPath)
            as! HistoryTableViewCell
        cell.labelmatkul.text   = self.jadwalkelas?.data[indexPath.row].ploting.namaMk
        cell.labelruang.text    = self.jadwalkelas?.data[indexPath.row].ruangbaru.namaRuang
        
        let dateFormatterGet        = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let dateFormatterGet1       = DateFormatter()
        dateFormatterGet1.dateFormat = "yyyy-MM-dd"
        
        let hari                    = DateFormatter()
        hari.dateFormat             = "EEEE"
        
        let tanggal                 = DateFormatter()
        tanggal.dateFormat          = "dd-MM-yyyy"
        
        let jam                     = DateFormatter()
        jam.dateFormat              = "HH:mm"
        
        let tgl                     = dateFormatterGet1.date(from: (self.jadwalkelas?.data[indexPath.row].tanggal)!)

        if self.jadwalkelas?.data[indexPath.row].checkOut == nil {
            cell.labelwaktu.text    = "-"
        } else {
            cell.labelwaktu.text   = "\(hari.string(from: tgl!)), \(tanggal.string(from: tgl!)) [\(jam.string(from:  dateFormatterGet.date(from: (self.jadwalkelas?.data[indexPath.row].checkIn)!)!)) s/d \(jam.string(from:  dateFormatterGet.date(from: (self.jadwalkelas?.data[indexPath.row].checkOut)!)!))]"
        }
        
        if self.jadwalkelas?.data[indexPath.row].tipemengajar?.nama == nil {
            cell.labeltipe.text     = "-"
        } else {
            cell.labeltipe.text     = self.jadwalkelas?.data[indexPath.row].tipemengajar?.nama
        }
        
        return cell
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
