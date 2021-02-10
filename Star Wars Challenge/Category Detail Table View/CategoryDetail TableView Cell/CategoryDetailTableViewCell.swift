//
//  CategoryItemTableViewCell.swift
//  Star Wars Challenge
//
//  Created by Jack Higgins on 2/8/21.
//

import UIKit

class CategoryItemTableViewCell: UITableViewCell {
    
    @IBOutlet weak var avatarView: AvatarView!
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var subTextLabel: UILabel!
    @IBOutlet weak var createdAtLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        self.avatarView.bgView.layer.cornerRadius = self.avatarView.bgView.frame.size.width / 2
//        self.avatarView.bgView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
