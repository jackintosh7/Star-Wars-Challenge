//
//  FilmViewController.swift
//  Star Wars Challenge
//
//  Created by Jack Higgins on 2/9/21.
//

import UIKit

class FilmViewController: UIViewController {
    
    var tableView: UITableView = UITableView()
    
    private let repo = FilmRepository()
    private let peopleRepo = PeopleRepository()
    private let vehiclesRepo = VehiclesRepository()
    private let speciesRepo = SpeciesRepository()
    private let starshipsRepo = StarshipsRepository()
    private let planetRepo = StarshipsRepository()
    
    enum FilmProperties: String {
        case Title
        case EpisodeID
        case Opening_Crawl
        case Director
        case Producer
        case Release_Date
        case Species
        case Starships
        case Vehicles
        case Characters
        case Planets
        case Created
    }
    
    var properties = [
        FilmProperties.Title,
        FilmProperties.EpisodeID,
        FilmProperties.Opening_Crawl,
        FilmProperties.Director,
        FilmProperties.Producer,
        FilmProperties.Release_Date,
        FilmProperties.Species,
        FilmProperties.Starships,
        FilmProperties.Vehicles,
        FilmProperties.Characters,
        FilmProperties.Planets,
        FilmProperties.Created
    ]
    
    var objectID: String?
    var filmObject: FilmsModel?
    
    var vehicleNames: String = ""
    var starshipNames: String = ""
    var characterNames: String = ""
    var planetNames: String = ""
    var speciesNames: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: displayWidth, height: displayHeight - DeviceDimensions.barHeight), style: .grouped)
        let nib = UINib(nibName: "ItemTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "ItemCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        
        tableView.backgroundColor = UIColor.clear
        self.view.backgroundColor = UIColor.black
        self.view.addSubview(tableView)
        
        self.fetchFilms()
    }
}

extension FilmViewController {
    func fetchFilms() {
        if let id = self.objectID {
            repo.fetchByID(id: id) { result in
                switch result {
                case .success(let film):
                    self.filmObject = film
                    self.title = film.title.uppercased()
                    self.tableView.reloadData()
                    self.fetchVehicles()
                case .failure(let error):
                    print("error", error)
                }
            }
        }
    }
    
    func fetchVehicles() {
        guard let film = self.filmObject else { return }
        
        for url in film.vehicles {
            let id = url.digits
            vehiclesRepo.fetchByID(id: id) { result in
                switch result {
                case .success(let vehicle):
                    self.vehicleNames.append(vehicle.name + ", ")
                case .failure(let error):
                    print("error", error)
                }
                if url == film.vehicles.last {
                    self.fetchStarships()
                }
            }
        }
    }
    
    func fetchStarships() {
        guard let film = self.filmObject else { return }
        
        for url in film.starships {
            let id = url.digits
            starshipsRepo.fetchByID(id: id) { result in
                switch result {
                case .success(let starships):
                    self.starshipNames.append(starships.model + ", ")
                case .failure(let error):
                    print("error", error)
                }
                if url == film.starships.last {
                    self.fetchSpecies()
                }
            }
        }
    }
    
    func fetchSpecies() {
        guard let film = self.filmObject else { return }
        
        for url in film.species {
            let id = url.digits
            speciesRepo.fetchByID(id: id) { result in
                switch result {
                case .success(let species):
                    self.speciesNames.append(species.name + ", ")
                case .failure(let error):
                    print("error", error)
                }
                if url == film.species.last {
                    self.fetchPlanets()
                }
            }
        }
    }
    
    func fetchPlanets() {
        guard let film = self.filmObject else { return }
        
        for url in film.planets {
            let id = url.digits
            planetRepo.fetchByID(id: id) { result in
                switch result {
                case .success(let planet):
                    self.planetNames.append(planet.model + ", ")
                case .failure(let error):
                    print("error", error)
                }
                if url == film.planets.last {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
}

extension FilmViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 133
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 283
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerViewXIB = Bundle.main.loadNibNamed("ItemHeaderView", owner: self, options: nil)
        let headerView = headerViewXIB?.first as! ItemHeaderView
        headerView.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: 283)
        headerView.avatar.avatarText.text = Utilities.sharedManager.initalGenerator(text: filmObject?.title ?? "-")
        headerView.titleText.text = self.filmObject?.openingCrawl
        return headerView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.properties.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemTableViewCell
        
        let property = self.properties[indexPath.row]
        
        cell.property.text = property.rawValue.replacingOccurrences(of: "_", with: " ")

        switch property {
        case .Created:
            let date = self.filmObject?.created.toISODate()
            cell.value.text = date?.date.toFormat("MM/dd/yyyy")
        case .Title:
            cell.value.text = self.filmObject?.title
        case .EpisodeID:
            cell.value.text = String(self.filmObject?.episodeId ?? 0)
        case .Opening_Crawl:
            cell.value.text = self.filmObject?.openingCrawl
        case .Director:
            cell.value.text = self.filmObject?.director
        case .Producer:
            cell.value.text = self.filmObject?.producer
        case .Release_Date:
            cell.value.text = self.filmObject?.releaseDate
        case .Species:
            cell.value.text = speciesNames
        case .Starships:
            cell.value.text = starshipNames
        case .Vehicles:
            cell.value.text = vehicleNames
        case .Characters:
            cell.value.text = characterNames
        case .Planets:
            cell.value.text = planetNames
            
        }
        return cell
    }
}
