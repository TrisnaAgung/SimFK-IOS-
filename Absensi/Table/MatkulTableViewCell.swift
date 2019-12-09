//
//  MatkulTableViewCell.swift
//  Absensi
//
//  Created by Unit TSI on 18/11/19.
//  Copyright © 2019 technesia. All rights reserved.
//

import UIKit

class MatkulTableViewCell: UITableViewCell {

    @IBOutlet weak var labelmatkul: UILabel!
    @IBOutlet weak var labelkelas: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
