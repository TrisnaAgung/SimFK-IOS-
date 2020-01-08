//
//  HistoryTableViewCell.swift
//  Absensi
//
//  Created by Unit TSI on 19/12/19.
//  Copyright © 2019 technesia. All rights reserved.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {

    @IBOutlet weak var labelmatkul: UILabel!
    @IBOutlet weak var labelruang: UILabel!
    @IBOutlet weak var labelwaktu: UILabel!
    @IBOutlet weak var labeltipe: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
