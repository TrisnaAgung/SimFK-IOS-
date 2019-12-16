//
//  TipeViewController.swift
//  Absensi
//
//  Created by Unit TSI on 16/12/19.
//  Copyright © 2019 technesia. All rights reserved.
//

import UIKit
import JGProgressHUD

class TipeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate  {

    @IBOutlet weak var searchtipe: UISearchBar!
    @IBOutlet weak var tabletipe: UITableView!
    let token = UserDefaults.standard.object(forKey: "token") as? String
    var tipekelas:Tipe?
    var hud : JGProgressHUD?
    var detailToSend: TipeData?
    var filter: [TipeData]!
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.gray.withAlphaComponent(0.8)
        
        self.tabletipe.delegate     = self
        self.tabletipe.dataSource   = self
        self.searchtipe.delegate    = self
        filter                      = tipekelas?.data
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filter.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "popuptipecell", for: indexPath)
            as! PopUpTipeTableViewCell
        cell.labeltipe.text  = filter[indexPath.row].desc
        return cell
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filter = searchText.isEmpty ? self.tipekelas?.data : self.tipekelas?.data.filter { (item: TipeData) -> Bool in
            return (item.desc.lowercased().contains(searchText.lowercased()) )
        }
        tabletipe.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "unwindSegueToVC3" {
            if let vc : AddJadwalController = segue.destination as? AddJadwalController {
                vc.datatipe = detailToSend
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        detailToSend = filter[indexPath.row]
        self.performSegue(withIdentifier: "unwindSegueToVC3", sender: self)
    }
}
