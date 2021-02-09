//
//  CategoryDetailTableViewController.swift
//  Star Wars Challenge
//
//  Created by Jack Higgins on 2/8/21.
//

import UIKit
import SwiftDate

class CategoryDetailTableViewController: UIViewController {
    
    var tableView: UITableView = UITableView()
    
    private let repo = CategoryRepository()
    
    var categoryItems = [CategoryListModel]()
    var category: SWCategories?
    var page = 1
    var totalResults: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: displayWidth, height: displayHeight), style: .grouped)
        let nib = UINib(nibName: "CategoryDetailTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "detailCategoryCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        
        self.view.addSubview(tableView)
        self.view.backgroundColor = UIColor.white
        
        if let category = self.category {
            self.title = category.rawValue.uppercased()
        }
        self.fetchCategoryItems()
    }
}

extension CategoryDetailTableViewController {
    func fetchCategoryItems() {
        if let category = self.category {
            self.repo.fetchAll(page: self.page, category: category) { result in
                switch result {
                case .success(let categoryData):
                    self.categoryItems.append(contentsOf: categoryData.categoryItems)
                    self.totalResults = categoryData.totalResults
                    self.tableView.reloadData()
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}

extension CategoryDetailTableViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerViewXIB = Bundle.main.loadNibNamed("CategoryDetailHeader", owner: self, options: nil)
        let headerView = headerViewXIB?.first as! CategoryDetailHeaderView
        headerView.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: 60)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.categoryItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailCategoryCell", for: indexPath) as! CategoryItemTableViewCell
        let categoryItem = self.categoryItems[indexPath.row]
        
        cell.headerLabel.text = categoryItem.title
        cell.subTextLabel.text = categoryItem.subTitle
        cell.createdAtLabel.text = categoryItem.created?.toDate("yyyy-MM-dd HH:mm")?.toString()
        
        if indexPath.row == categoryItems.count - 1 { // last cell
            if categoryItems.count != totalResults {
                self.page += 1
                self.fetchCategoryItems()
            }
        }
        return cell
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.clear
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let categoryItem = self.categoryItems[indexPath.row]
        
        var vc : UIViewController?

        if let category = self.category {
            switch category {
            case .Films:
                vc = FilmViewController()
            case .People:
                vc = PeopleViewController()
            case .Planets:
                vc = PlanetViewController()
            case .Species:
                vc = SpeciesViewController()
            case .Starships:
                vc = StarshipViewController()
            case .Vehicles:
                vc = VehicleViewController()
            }
        }
        
        if let vc = vc {
            //set URL
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
}
