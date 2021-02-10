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
        
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: displayWidth, height: displayHeight - DeviceDimensions.barHeight), style: .grouped)
        let nib = UINib(nibName: "CategoryDetailTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "detailCategoryCell")
        tableView.dataSource = self
        tableView.delegate = self
        
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
        return 84
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerViewXIB = Bundle.main.loadNibNamed("CategoryDetailHeader", owner: self, options: nil)
        let headerView = headerViewXIB?.first as! CategoryDetailHeaderView
        headerView.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: 84)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.categoryItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailCategoryCell", for: indexPath) as! CategoryItemTableViewCell
        let categoryItem = self.categoryItems[indexPath.row]
        
        cell.subTextLabel.text = categoryItem.subTitle
        
        if let createdAt = categoryItem.created {
            let date = createdAt.toISODate()
            cell.createdAtLabel.text = date?.date.toFormat("MM/dd/yyyy")
        }
        
        cell.avatarView.layer.cornerRadius = cell.avatarView.frame.size.width/2
        cell.avatarView.clipsToBounds = true
        cell.selectionStyle = .none

        /// Generate Initals
        if let title = categoryItem.title {
            cell.avatarView.avatarText.text = Utilities.sharedManager.initalGenerator(text: title)
            cell.headerLabel.text = categoryItem.title
        } else {
            cell.headerLabel.text = "-"
        }
        
        /// Pagination Config
        /// TODO: Setup data dask to ensure all items are being fetched and returned (Stability improvement)
        if indexPath.row == categoryItems.count - 1 {
            if categoryItems.count != totalResults {
                self.page += 1
                self.fetchCategoryItems()
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let categoryItem = self.categoryItems[indexPath.row]
        let id = categoryItem.url?.digits
        
        
        /// Navigate to specific object VC based on category
        if let category = self.category {
            switch category {
            case .Films:
                let vc = FilmViewController()
                vc.objectID = id
                self.navigationController?.pushViewController(vc, animated: true)
            case .People:
                let vc = PeopleViewController()
                vc.objectID = id
                self.navigationController?.pushViewController(vc, animated: true)
            case .Planets:
                let vc = PlanetViewController()
                vc.objectID = id
                self.navigationController?.pushViewController(vc, animated: true)
            case .Species:
                let vc = SpeciesViewController()
                vc.objectID = id
                self.navigationController?.pushViewController(vc, animated: true)
            case .Starships:
                let vc = StarshipViewController()
                vc.objectID = id
                self.navigationController?.pushViewController(vc, animated: true)
            case .Vehicles:
                let vc = VehicleViewController()
                vc.objectID = id
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
}
