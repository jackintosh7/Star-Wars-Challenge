//
//  CategoryTableViewCell.swift
//  Star Wars Challenge
//
//  Created by Jack Higgins on 2/4/21.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bgView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
        self.bgView.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.bgView.layer.shadowColor = UIColor.black.cgColor
        self.bgView.layer.shadowRadius = 5
        self.bgView.layer.cornerRadius = 5
        self.bgView.layer.shadowOpacity = 0.15
        self.bgView.layer.masksToBounds = false;
        self.bgView.clipsToBounds = false;
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
