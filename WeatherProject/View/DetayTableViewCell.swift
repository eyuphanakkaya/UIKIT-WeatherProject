//
//  DetayTableViewCell.swift
//  WeatherProject
//
//  Created by Eyüphan Akkaya on 8.05.2023.
//

import UIKit

class DetayTableViewCell: UITableViewCell {

    @IBOutlet weak var durumImageView: UIImageView!
    @IBOutlet weak var minSicaklikLabel: UILabel!
    @IBOutlet weak var maxSicaklikLabel: UILabel!
    @IBOutlet weak var gunLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
