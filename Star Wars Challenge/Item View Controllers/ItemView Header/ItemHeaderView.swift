//
//  ItemHeaderView.swift
//  Star Wars Challenge
//
//  Created by Jack Higgins on 2/9/21.
//

import UIKit

class ItemHeaderView: UIView {
    
    @IBOutlet weak var avatar: AvatarView!
    @IBOutlet weak var titleText: UILabel!
    
    override func draw(_ rect: CGRect) {
        // Drawing code
        self.avatar.bgView.layer.cornerRadius = self.avatar.bgView.frame.size.width / 2
        self.avatar.bgView.clipsToBounds = true
        self.avatar.avatarText.font = UIFont.boldSystemFont(ofSize: 40)
    }
}
