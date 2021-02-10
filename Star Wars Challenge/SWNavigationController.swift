//
//  SWNavigationController.swift
//  Star Wars Challenge
//
//  Created by Jack Higgins on 2/10/21.
//

import UIKit

class SWNavigationController: UINavigationController, UINavigationControllerDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        
        self.navigationBar.tintColor = UIColor.white
        self.navigationBar.barTintColor = SWColors.darkGray
        self.navigationBar.isTranslucent = false
        self.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.white
        ]
    }

    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        let item = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
        viewController.navigationItem.backBarButtonItem = item
    }
}
