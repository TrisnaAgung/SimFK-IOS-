//
//  RuangViewController.swift
//  Absensi
//
//  Created by Unit TSI on 19/11/19.
//  Copyright © 2019 technesia. All rights reserved.
//

import UIKit
import JGProgressHUD

class RuangViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    @IBOutlet weak var searchruang: UISearchBar!
    @IBOutlet weak var tableruang: UITableView!
    let token = UserDefaults.standard.object(forKey: "token") as? String
    var ruang:Ruang?
    var hud : JGProgressHUD?
    var detailToSend: RuangData?
    var filter: [RuangData]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.gray.withAlphaComponent(0.8)
        
        self.tableruang.delegate    = self
        self.tableruang.dataSource  = self
        self.searchruang.delegate   = self
        filter                      = ruang?.data
        
    }
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filter.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "popupruangcell", for: indexPath)
            as! PopUpRuangTableViewCell
        cell.labelruang.text  = "\(filter[indexPath.row].namaGedung ?? "") - \(filter[indexPath.row].namaRuang ?? "")"
        return cell
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filter = searchText.isEmpty ? self.ruang?.data : self.ruang?.data.filter { (item: RuangData) -> Bool in
            return (item.namaGedung?.lowercased().contains(searchText.lowercased()) ?? false) || (item.namaRuang?.lowercased().contains(searchText.lowercased()) ?? false)
        }
        tableruang.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "unwindSegueToVC2" {
            if let vc : AddJadwalController = segue.destination as? AddJadwalController {
                vc.data1 = detailToSend
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        detailToSend = filter[indexPath.row]
        self.performSegue(withIdentifier: "unwindSegueToVC2", sender: self)
    }
}
