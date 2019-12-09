//
//  MatkulViewController.swift
//  Absensi
//
//  Created by Unit TSI on 14/11/19.
//  Copyright © 2019 technesia. All rights reserved.
//

import UIKit
import Alamofire
import JGProgressHUD

class MatkulViewController: UIViewController,UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    @IBOutlet weak var tablematkul: UITableView!
    @IBOutlet weak var searchmatkul: UISearchBar!
    
    let token = UserDefaults.standard.object(forKey: "token") as? String
    var matkul:Matkul?
    var hud : JGProgressHUD?
    var detailToSend: Datum?
    var filter: [Datum]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.gray.withAlphaComponent(0.8)
        
        self.tablematkul.delegate   = self
        self.tablematkul.dataSource = self
        self.searchmatkul.delegate  = self
        filter                      = matkul?.data
        
    }
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filter.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "popupmatkulcell", for: indexPath)
            as! PopUpMatkulTableViewCell
        cell.labelmatkulkelas.text  = "\(filter[indexPath.row].namaMk) - \(filter[indexPath.row].namaKelas)"
        return cell
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filter = searchText.isEmpty ? self.matkul?.data : self.matkul?.data.filter { (item: Datum) -> Bool in
            return item.namaMk.lowercased().contains(searchText.lowercased()) || item.namaKelas.lowercased().contains(searchText.lowercased())
        }
        tablematkul.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "unwindSegueToVC1" {
            if let vc : AddJadwalController = segue.destination as? AddJadwalController {
                vc.data2 = detailToSend
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        detailToSend = filter[indexPath.row]
        self.performSegue(withIdentifier: "unwindSegueToVC1", sender: self)
    }
}
