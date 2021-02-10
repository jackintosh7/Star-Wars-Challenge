//
//  PeopleViewController.swift
//  Star Wars Challenge
//
//  Created by Jack Higgins on 2/9/21.
//

import UIKit

class PeopleViewController: UIViewController {
    
    var tableView: UITableView = UITableView()
    
    private let repo = PeopleRepository()
    private let filmsRepo = FilmRepository()
    private let vehiclesRepo = VehiclesRepository()
    private let speciesRepo = SpeciesRepository()
    private let starshipsRepo = StarshipsRepository()
    
    enum PeopleProperties: String {
        case Name
        case Height
        case Mass
        case Hair_Color
        case Skin_Color
        case Eye_Color
        case Birth_Year
        case Gender
        case Homeworld
        case Films
        case Species
        case Starships
        case Vehicles
        case Created
    }
    
    var properties = [
        PeopleProperties.Name,
        PeopleProperties.Height,
        PeopleProperties.Mass,
        PeopleProperties.Hair_Color,
        PeopleProperties.Skin_Color,
        PeopleProperties.Eye_Color,
        PeopleProperties.Birth_Year,
        PeopleProperties.Gender,
        PeopleProperties.Homeworld,
        PeopleProperties.Films,
        PeopleProperties.Species,
        PeopleProperties.Starships,
        PeopleProperties.Vehicles,
        PeopleProperties.Created
    ]
    
    var objectID: String?
    var peopleObject: PeopleModel?
    
    var filmNames: String = ""
    var speciesNames: String = ""
    var starshipsName: String = ""
    var vehiclesName: String = ""
    
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
        
        self.fetchPerson()
    }
}

extension PeopleViewController {
    func fetchPerson() {
        if let id = self.objectID {
            repo.fetchByID(id: id) { result in
                switch result {
                case .success(let person):
                    self.peopleObject = person
                    self.title = person.name.uppercased()
                    self.tableView.reloadData()
                    self.fetchFilms()
                case .failure(let error):
                    print("error", error)
                }
            }
        }
    }
    
    func fetchFilms() {
        guard let person = self.peopleObject else { return }
        
        for url in person.films {
            let id = url.digits
            filmsRepo.fetchByID(id: id) { result in
                switch result {
                case .success(let film):
                    self.filmNames.append(film.title + ", ")
                case .failure(let error):
                    print("error", error)
                }
                if url == person.films.last {
                    self.fetchVehicles()
                }
            }
        }
    }
    
    func fetchVehicles() {
        guard let person = self.peopleObject else { return }
        
        for url in person.vehicles {
            let id = url.digits
            vehiclesRepo.fetchByID(id: id) { result in
                switch result {
                case .success(let vehicle):
                    self.vehiclesName.append(vehicle.name + ", ")
                case .failure(let error):
                    print("error", error)
                }
                if url == person.vehicles.last {
                    self.fetchStarships()
                }
            }
        }
    }
    
    func fetchStarships() {
        guard let person = self.peopleObject else { return }
        
        for url in person.starships {
            let id = url.digits
            starshipsRepo.fetchByID(id: id) { result in
                switch result {
                case .success(let starships):
                    self.starshipsName.append(starships.model + ", ")
                case .failure(let error):
                    print("error", error)
                }
                if url == person.starships.last {
                    self.fetchVehicles()
                }
            }
        }
    }
    
    func fetchSpecies() {
        guard let person = self.peopleObject else { return }
        
        for url in person.species {
            let id = url.digits
            speciesRepo.fetchByID(id: id) { result in
                switch result {
                case .success(let species):
                    self.speciesNames.append(species.name + ", ")
                case .failure(let error):
                    print("error", error)
                }
                if url == person.species.last {
                    self.tableView.reloadData()
                }
            }
        }
    }
}

extension PeopleViewController: UITableViewDelegate, UITableViewDataSource {
    
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
        headerView.avatar.avatarText.text = Utilities.sharedManager.initalGenerator(text: peopleObject?.name ?? "-")
        headerView.titleText.text = self.peopleObject?.birthYear
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
            let date = self.peopleObject?.created.toISODate()
            cell.value.text = date?.date.toFormat("MM/dd/yyyy")
        case .Gender:
            cell.value.text = self.peopleObject?.gender
        case .Birth_Year:
            cell.value.text = self.peopleObject?.birthYear
        case .Eye_Color:
            cell.value.text = self.peopleObject?.eyeColor
        case .Hair_Color:
            cell.value.text = self.peopleObject?.hairColor
        case .Homeworld:
            cell.value.text = self.peopleObject?.hairColor
        case .Height:
            cell.value.text = self.peopleObject?.height
        case .Films:
            cell.value.text = self.filmNames
        case .Starships:
            cell.value.text = self.starshipsName
        case .Vehicles:
            cell.value.text = self.vehiclesName
        case .Species:
            cell.value.text = self.speciesNames
        case .Skin_Color:
            cell.value.text = self.peopleObject?.skinColor
        case .Name:
            cell.value.text = self.peopleObject?.name
        case .Mass:
            cell.value.text = self.peopleObject?.mass
        }
        return cell
    }
}
