//
//  AbsensiTableViewCell.swift
//  Absensi
//
//  Created by Unit TSI on 06/12/19.
//  Copyright © 2019 technesia. All rights reserved.
//

import UIKit

class AbsensiTableViewCell: UITableViewCell {

    @IBOutlet weak var labelmasuk: UILabel!
    @IBOutlet weak var labelpulang: UILabel!
    @IBOutlet weak var labelwaktu: UILabel!
    @IBOutlet weak var labelhari: UILabel!
    @IBOutlet weak var labeltanggal: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
