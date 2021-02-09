//
//  CategoryDetailTableViewController.swift
//  Star Wars Challenge
//
//  Created by Jack Higgins on 2/8/21.
//

import UIKit

class CategoryDetailTableViewController: UIViewController {
  
    var tableView: UITableView = UITableView()
    
    private let starshipRepo = StarshipsRepository()
    private let vehiclesRepo = VehiclesRepository()
    private let filmsRepo = FilmRepository()
    private let peopleRepo = PeopleRepository()
    private let planetRepo = PlanetsRepository()
    private let speciesRepo = SpeciesRepository()

    var categoryItems = [Any]()
    var category: SWCategories?
    var page = 1
    var totalResults: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension CategoryDetailTableViewController {
    func fetchCategoryItems() {
        switch self.category {
        case .Films:
            self.fetchFilms()
        case .People:
            self.fetchPeople()
        case .Planets:
            self.fetchPlanets()
        case .Species:
            self.fetchSpecies()
        case .Starships:
            self.fetchFilms()
        case .Vehicles:
            self.fetchVehicles()
        case .none:
            break
        }
    }
    
    func fetchFilms() {
        filmsRepo.fetchAll(page: page) { result in
            switch result {
            case .success(let filmData):
                self.totalResults = filmData.totalResults
                self.categoryItems.append(contentsOf: filmData.films)
                self.tableView.reloadData()
            //TODO: DISMISS LOADING INDICATOR
            case .failure(let error):
                print("error", error)
            }
        }
    }
    
    func fetchPeople() {
        peopleRepo.fetchAll(page: page) { result in
            switch result {
            case .success(let peopleData):
                self.totalResults = peopleData.totalResults
                self.categoryItems.append(contentsOf: peopleData.people)
                self.tableView.reloadData()
            //TODO: DISMISS LOADING INDICATOR
            case .failure(let error):
                print("error", error)
            }
        }
    }
    
    func fetchPlanets() {
        planetRepo.fetchAll(page: page) { result in
            switch result {
            case .success(let planetData):
                self.totalResults = planetData.totalResults
                self.categoryItems.append(contentsOf: planetData.planets)
                self.tableView.reloadData()
            //TODO: DISMISS LOADING INDICATOR
            case .failure(let error):
                print("error", error)
            }
        }
    }
    
    func fetchSpecies() {
        speciesRepo.fetchAll(page: page) { result in
            switch result {
            case .success(let speciesData):
                self.totalResults = speciesData.totalResults
                self.categoryItems.append(contentsOf: speciesData.species)
                self.tableView.reloadData()
            //TODO: DISMISS LOADING INDICATOR
            case .failure(let error):
                print("error", error)
            }
        }
    }
    
    func fetchVehicles() {
        vehiclesRepo.fetchAll(page: page) { result in
            switch result {
            case .success(let vehicleData):
                self.totalResults = vehicleData.totalResults
                self.categoryItems.append(contentsOf: vehicleData.vehicles)
                self.tableView.reloadData()
            //TODO: DISMISS LOADING INDICATOR
            case .failure(let error):
                print("error", error)
            }
        }
    }
    
    func fetchStarships() {
        starshipRepo.fetchAll(page: page) { result in
            switch result {
            case .success(let starshipData):
                self.totalResults = starshipData.totalResults
                self.categoryItems.append(contentsOf: starshipData.starships)
                self.tableView.reloadData()
            //TODO: DISMISS LOADING INDICATOR
            case .failure(let error):
                print("error", error)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! CategoryTableViewCell
        
//        cell.titleLabel.text = self.categories[indexPath.row]
//        cell.iconImageView.image = self.categoryIcons[indexPath.row]
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
