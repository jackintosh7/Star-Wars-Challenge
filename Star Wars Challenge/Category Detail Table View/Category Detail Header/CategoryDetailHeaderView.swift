//
//  CategoryDetailHeaderView.swift
//  Star Wars Challenge
//
//  Created by Jack Higgins on 2/8/21.
//

import UIKit

class CategoryDetailHeaderView: UIView {
    
    @IBOutlet weak var headerText: UILabel!
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        headerText.setCharacterSpacing(4)
        headerText.setLineSpacing(lineSpacing: -0.24)
        self.backgroundColor = SWColors.lightGray
    }
}
