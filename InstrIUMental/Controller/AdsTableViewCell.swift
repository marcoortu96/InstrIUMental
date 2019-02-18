//
//  AdsTableViewCell.swift
//  InstrIUMental
//
//  Created by Marco Ortu on 08/02/2019.
//  Copyright © 2019 Sora. All rights reserved.
//

import UIKit

class AdsTableViewCell: UITableViewCell {
    @IBOutlet weak var adImageView: UIImageView!
    @IBOutlet weak var adTitleLabel: UILabel!
    @IBOutlet weak var adDescrLabel: UILabel!
    @IBOutlet weak var nameUserLabel: UILabel!
    @IBOutlet weak var adDateLabel: UILabel!
    @IBOutlet weak var adPriceLabel: UILabel!
    @IBOutlet weak var adRegionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
