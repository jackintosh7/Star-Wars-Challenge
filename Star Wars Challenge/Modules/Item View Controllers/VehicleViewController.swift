//
//  VehicleViewController.swift
//  Star Wars Challenge
//
//  Created by Jack Higgins on 2/9/21.
//

import UIKit

class VehicleViewController: UIViewController {
    
    var tableView: UITableView = UITableView()
    
    private let repo = VehiclesRepository()
    private let filmsRepo = FilmRepository()
    private let peopleRepo = PeopleRepository()
    
    enum VehicleProperties: String {
        case Name
        case Model
        case Manufacturer
        case Cost_In_Credits
        case Length
        case Max_Atmosphering_Speed
        case Crew
        case Passengers
        case Cargo_Capacity
        case Consumables
        case Vehicle_Class
        case Pilots
        case Films
        case Created
    }
    
    var properties = [
        VehicleProperties.Name,
        VehicleProperties.Model,
        VehicleProperties.Manufacturer,
        VehicleProperties.Cost_In_Credits,
        VehicleProperties.Length,
        VehicleProperties.Max_Atmosphering_Speed,
        VehicleProperties.Crew,
        VehicleProperties.Passengers,
        VehicleProperties.Cargo_Capacity,
        VehicleProperties.Consumables,
        VehicleProperties.Vehicle_Class,
        VehicleProperties.Pilots,
        VehicleProperties.Films,
        VehicleProperties.Created
    ]
    
    var objectID: String?
    var vehicleObject: VehiclesModel?
    
    var filmNames: String = ""
    var pilotNames: String = ""
    
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
        
        self.fetchVehicle()
    }
}

extension VehicleViewController {
    func fetchVehicle() {
        if let id = self.objectID {
            repo.fetchByID(id: id) { result in
                switch result {
                case .success(let vehicle):
                    self.vehicleObject = vehicle
                    self.title = vehicle.name.uppercased()
                    self.tableView.reloadData()
                    self.fetchFilms()
                case .failure(let error):
                    print("error", error)
                }
            }
        }
    }
    
    func fetchFilms() {
        guard let vehicle = self.vehicleObject else { return }
        let fetchGroup = DispatchGroup()
        
        for url in vehicle.films {
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
            self.fetchPilots()
        }
    }
    
    func fetchPilots() {
        guard let vehicle = self.vehicleObject else { return }
        let fetchGroup = DispatchGroup()
        
        for url in vehicle.pilots {
            let id = url.digits
            peopleRepo.fetchByID(id: id) { result in
                switch result {
                case .success(let vehicle):
                    self.pilotNames.append(vehicle.name + ", ")
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

extension VehicleViewController: UITableViewDelegate, UITableViewDataSource {
    
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
        headerView.avatar.avatarText.text = Utilities.sharedManager.initalGenerator(text: vehicleObject?.name ?? "-")
        headerView.titleText.text = self.vehicleObject?.model
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
            let date = self.vehicleObject?.created.toISODate()
            cell.value.text = date?.date.toFormat("MM/dd/yyyy")
        case .Films:
            cell.value.text = self.filmNames
        case .Name:
            cell.value.text = self.vehicleObject?.name
        case .Model:
            cell.value.text = self.vehicleObject?.model
        case .Manufacturer:
            cell.value.text = self.vehicleObject?.manufacturer
        case .Cost_In_Credits:
            cell.value.text = self.vehicleObject?.costInCredits
        case .Length:
            cell.value.text = self.vehicleObject?.length
        case .Max_Atmosphering_Speed:
            cell.value.text = self.vehicleObject?.maxAtmospheringSpeed
        case .Crew:
            cell.value.text = self.vehicleObject?.crew
        case .Passengers:
            cell.value.text = self.vehicleObject?.passengers
        case .Cargo_Capacity:
            cell.value.text = self.vehicleObject?.cargoCapacity
        case .Consumables:
            cell.value.text = self.vehicleObject?.consumables
        case .Vehicle_Class:
            cell.value.text = self.vehicleObject?.vehicleClass
        case .Pilots:
            cell.value.text = self.pilotNames
        }
        return cell
    }
}
