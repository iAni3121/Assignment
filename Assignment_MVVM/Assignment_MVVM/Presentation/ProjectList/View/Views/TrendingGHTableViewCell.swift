//
//  TrendingGHTableViewCell.swift
//  Assignment_MVVM
//
//  Created by Anirudha Kumar on 14/06/22.
//

import UIKit

class TrendingGHTableViewCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var starCountLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupCellData(cellData: ProjectViewModel?) {
        nameLabel.text = cellData?.name?.capitalized
        starCountLabel.text = "\(0) Stars"
        descriptionLabel.text = cellData?.description
    }

    
}
