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

class JadwalController: UIViewController,UITableViewDataSource, UITableViewDelegate{
    
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
        
        Alamofire.request("http://sim.fk.unair.ac.id/api/jadwalkelas-list", method: .get ,parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJadwalKelas{
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
        cell.labelkelas.text    = self.jadwalkelas?.data[indexPath.row].ploting.namaKelas
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        detailToSend = self.jadwalkelas?.data[indexPath.row]
        performSegue(withIdentifier: "addjadwal", sender: detailToSend)
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
