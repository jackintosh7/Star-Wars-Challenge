//
//  PlanetViewController.swift
//  Star Wars Challenge
//
//  Created by Jack Higgins on 2/9/21.
//

import UIKit
import RealmSwift
import SwiftDate

class PlanetViewController: UIViewController {
    
    var tableView: UITableView = UITableView()
    
    private let repo = PlanetsRepository()
    private let filmsRepo = FilmRepository()
    private let peopleRepo = PeopleRepository()
    
    enum PlanetProperties: String {
        case Name
        case Diameter
        case Rotation_Period
        case Orbital_Period
        case Gravity
        case Population
        case Climate
        case Terrain
        case Surface_Water
        case Residents
        case Films
        case Created
    }
    
    var properties = [
        PlanetProperties.Name,
        PlanetProperties.Diameter,
        PlanetProperties.Rotation_Period,
        PlanetProperties.Orbital_Period,
        PlanetProperties.Gravity,
        PlanetProperties.Population,
        PlanetProperties.Climate,
        PlanetProperties.Terrain,
        PlanetProperties.Surface_Water,
        PlanetProperties.Residents,
        PlanetProperties.Films,
        PlanetProperties.Created
    ]
    
    var objectID: String?
    var planetObject: PlanetsModel?
    
    var filmNames: String = ""
    var residentNames: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        
        self.title = "STAR WARS API"
        
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: displayWidth, height: displayHeight - DeviceDimensions.barHeight), style: .grouped)
        let nib = UINib(nibName: "ItemTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "ItemCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        
        tableView.backgroundColor = UIColor.clear
        self.view.backgroundColor = UIColor.black
        self.view.addSubview(tableView)
        
        self.fetchPlanet()
    }
}

extension PlanetViewController {
    
    func fetchPlanet() {
        if let id = self.objectID {
            repo.fetchByID(id: id) { result in
                switch result {
                case .success(let planet):
                    self.planetObject = planet
                    self.title = planet.name.uppercased()
                    self.tableView.reloadData()
                    self.fetchFilms()
                case .failure(let error):
                    print("error", error)
                }
            }
        }
    }

    func fetchFilms() {
        guard let planet = self.planetObject else { return }
        let fetchGroup = DispatchGroup()
        
        for url in planet.films {
            fetchGroup.enter()
            let id = url.digits
            filmsRepo.fetchByID(id: id) { result in
                
                switch result {
                case .success(let film):
                    self.filmNames.append(film.title + ", ")
                case .failure(let error):
                    print("error", error)
                }
                fetchGroup.leave()
            }
        }
        fetchGroup.notify(queue: .main) {
            self.fetchResidents()
        }
    }
    
    func fetchResidents() {
        guard let planet = self.planetObject else { return }
        let fetchGroup = DispatchGroup()
        
        for url in planet.residents {
            fetchGroup.enter()
            let id = url.digits
            peopleRepo.fetchByID(id: id) { result in
                switch result {
                case .success(let person):
                    self.residentNames.append(person.name + ", ")
                case .failure(let error):
                    print("error", error)
                }
                fetchGroup.leave()
            }
        }
        fetchGroup.notify(queue: .main) {
            self.tableView.reloadData()
        }
    }
}

extension PlanetViewController: UITableViewDelegate, UITableViewDataSource {
    
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
        headerView.avatar.avatarText.text = Utilities.sharedManager.initalGenerator(text: planetObject?.name ?? "-")
        headerView.titleText.text = planetObject?.name
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
            let date = self.planetObject?.created.toISODate()
            cell.value.text = date?.date.toFormat("MM/dd/yyyy")
        case .Climate:
            cell.value.text = self.planetObject?.climate
        case .Diameter:
            cell.value.text = self.planetObject?.diameter
        case .Gravity:
            cell.value.text = self.planetObject?.gravity
        case .Name:
            cell.value.text = self.planetObject?.name
        case .Orbital_Period:
            cell.value.text = self.planetObject?.orbitalPeriod
        case .Population:
            cell.value.text = self.planetObject?.population
        case .Films:
            cell.value.text = self.filmNames
        case .Residents:
            cell.value.text = self.residentNames
        case .Terrain:
            cell.value.text = self.planetObject?.terrain
        case .Surface_Water:
            cell.value.text = self.planetObject?.surfaceWater
        case .Rotation_Period:
            cell.value.text = self.planetObject?.rotationPeriod
        }
        return cell
    }
}
