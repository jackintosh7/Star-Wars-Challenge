//
//  ViewController.swift
//  Star Wars Challenge
//
//  Created by Jack Higgins on 2/3/21.
//

import UIKit

class CategoryTableViewController: UIViewController {
    
    var tableView: UITableView = UITableView()
    
    var categories = [
        SWCategories.People,
        SWCategories.Films,
        SWCategories.Starships,
        SWCategories.Vehicles,
        SWCategories.Species,
        SWCategories.Planets
    ]
    
    var categoryIcons = [
        UIImage.peopleIcon,
        UIImage.filmsIcon,
        UIImage.starshipsIcon,
        UIImage.vehiclesIcon,
        UIImage.speciesIcon,
        UIImage.planetIcon
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        
        self.title = "STAR WARS API"
        
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: displayWidth, height: displayHeight), style: .grouped)
        let nib = UINib(nibName: "CategoryTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "CategoryCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none

        
        let footerViewXIB = Bundle.main.loadNibNamed("TableViewFooterView", owner: self, options: nil)
        let footerView = footerViewXIB?.first as! UIView
        footerView.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: 125)

        //Add that view in Table Footer View.
        tableView.tableFooterView = footerView
        
        tableView.backgroundColor = UIColor.clear
        self.view.backgroundColor = SWColors.lightGray
        
        self.view.addSubview(tableView)
    }
}

extension CategoryTableViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 325
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        let headerViewXIB = Bundle.main.loadNibNamed("HeaderView", owner: self, options: nil)
        let headerView = headerViewXIB?.first as! HeaderView
        headerView.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: 325)

        return headerView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! CategoryTableViewCell
        
        cell.titleLabel.text = self.categories[indexPath.row].rawValue
        cell.iconImageView.image = self.categoryIcons[indexPath.row]
//        cell.bgView.backgroundColor = UIColor.white
        return cell
    }
     func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

        cell.backgroundColor = UIColor.clear
    }
    
    //    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //        let movie = self.categories[indexPath.row]
    //        let vc = MovieDetailViewController()
    //        vc.movie = movie
    //        self.navigationController?.pushViewController(vc, animated: true)
    //    }
    
}
