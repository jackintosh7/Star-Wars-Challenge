//
//  StarshipViewController.swift
//  Star Wars Challenge
//
//  Created by Jack Higgins on 2/9/21.
//

import UIKit

class StarshipViewController: UIViewController {

    var tableView: UITableView = UITableView()
    
    private let repo = StarshipsRepository()
    private let filmsRepo = FilmRepository()
    private let peopleRepo = PeopleRepository()
    
    enum StarshipProperties: String {
        case Name
        case Model
        case Manufacturer
        case Cost_In_Credits
        case Length
        case Max_Atmosphering_Speed
        case Hyperdrive_Rating
        case MGLT
        case Crew
        case Passengers
        case Cargo_Capacity
        case Consumables
        case Starship_Class
        case Pilots
        case Films
        case Created
    }
    
    var properties = [
        StarshipProperties.Name,
        StarshipProperties.Model,
        StarshipProperties.Manufacturer,
        StarshipProperties.Cost_In_Credits,
        StarshipProperties.Length,
        StarshipProperties.Max_Atmosphering_Speed,
        StarshipProperties.MGLT,
        StarshipProperties.Crew,
        StarshipProperties.Passengers,
        StarshipProperties.Cargo_Capacity,
        StarshipProperties.Consumables,
        StarshipProperties.Hyperdrive_Rating,
        StarshipProperties.Starship_Class,
        StarshipProperties.Pilots,
        StarshipProperties.Films,
        StarshipProperties.Created
    ]
    
    var objectID: String?
    var starshipObject: StarshipsModel?
    
    var filmNames: String = ""
    var pilotNames: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        
        self.title = "STAR WARS API"
        
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: displayWidth, height: displayHeight), style: .grouped)
        let nib = UINib(nibName: "ItemTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "ItemCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        
        tableView.backgroundColor = UIColor.clear
        self.view.backgroundColor = UIColor.black
        self.view.addSubview(tableView)
        
        self.fetchStarship()
    }
}

extension StarshipViewController {
    func fetchStarship() {
        if let id = self.objectID {
            repo.fetchByID(id: id) { result in
                switch result {
                case .success(let starship):
                    self.starshipObject = starship
                    self.title = starship.name.uppercased()
                    self.tableView.reloadData()
                    self.fetchFilms()
                case .failure(let error):
                    print("error", error)
                }
            }
        }
    }
    
    func fetchFilms() {
        guard let starship = self.starshipObject else { return }
        
        for url in starship.films {
            let id = url.digits
            filmsRepo.fetchByID(id: id) { result in
                switch result {
                case .success(let film):
                    self.filmNames.append(film.title + ", ")
                case .failure(let error):
                    print("error", error)
                }
                if url == starship.films.last {
                    self.fetchPilots()
                }
            }
        }
    }
    
    func fetchPilots() {
        guard let starship = self.starshipObject else { return }

        for url in starship.pilots {
            let id = url.digits
            peopleRepo.fetchByID(id: id) { result in
                switch result {
                case .success(let starship):
                    self.pilotNames.append(starship.name + ", ")
                case .failure(let error):
                    print("error", error)
                }
                if url == starship.pilots.last {
                    self.tableView.reloadData()
                }
            }
        }
    }
}

extension StarshipViewController: UITableViewDelegate, UITableViewDataSource {
    
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
        headerView.avatar.avatarText.text = Utilities.sharedManager.initalGenerator(text: starshipObject?.name ?? "-")
        headerView.titleText.text = self.starshipObject?.model
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
            cell.value.text = self.starshipObject?.created
        case .Films:
            cell.value.text = self.filmNames
        case .Name:
            cell.value.text = self.starshipObject?.name
        case .Model:
            cell.value.text = self.starshipObject?.model
        case .Manufacturer:
            cell.value.text = self.starshipObject?.manufacturer
        case .Cost_In_Credits:
            cell.value.text = self.starshipObject?.costInCredits
        case .Length:
            cell.value.text = self.starshipObject?.length
        case .Max_Atmosphering_Speed:
            cell.value.text = self.starshipObject?.maxAtmospheringSpeed
        case .Crew:
            cell.value.text = self.starshipObject?.crew
        case .Passengers:
            cell.value.text = self.starshipObject?.passengers
        case .Cargo_Capacity:
            cell.value.text = self.starshipObject?.cargoCapacity
        case .Consumables:
            cell.value.text = self.starshipObject?.consumables
        case .Starship_Class:
            cell.value.text = self.starshipObject?.starshipClass
        case .Pilots:
            cell.value.text = self.pilotNames
        case .Hyperdrive_Rating:
            cell.value.text = self.starshipObject?.hyperdriveRating
        case .MGLT:
            cell.value.text = self.starshipObject?.mglt
        }
        return cell
    }
}
