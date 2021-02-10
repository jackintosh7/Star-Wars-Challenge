//
//  SpeciesViewController.swift
//  Star Wars Challenge
//
//  Created by Jack Higgins on 2/9/21.
//

import UIKit

class SpeciesViewController: UIViewController {
    
    var tableView: UITableView = UITableView()
    
    private let repo = SpeciesRepository()
    private let filmsRepo = FilmRepository()
    private let peopleRepo = PeopleRepository()

    enum SpeciesProperties: String {
        case Name
        case Classification
        case Designation
        case Avg_Height
        case Avg_Lifespan
        case Eye_Color
        case Hair_Color
        case Skin_Color
        case Language
        case Homeworld
        case People
        case Films
        case Created
    }
    
    var properties = [
        SpeciesProperties.Name,
        SpeciesProperties.Classification,
        SpeciesProperties.Designation,
        SpeciesProperties.Avg_Height,
        SpeciesProperties.Avg_Lifespan,
        SpeciesProperties.Eye_Color,
        SpeciesProperties.Hair_Color,
        SpeciesProperties.Skin_Color,
        SpeciesProperties.Language,
        SpeciesProperties.Homeworld,
        SpeciesProperties.People,
        SpeciesProperties.Films,
        SpeciesProperties.Created
    ]
    
    var objectID: String?
    var speciesObject: SpeciesModel?
    
    var filmNames: String = ""
    var peopleNames: String = ""

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
        
        self.fetchSpecies()
    }
}

extension SpeciesViewController {
    func fetchSpecies() {
        if let id = self.objectID {
            repo.fetchByID(id: id) { result in
                switch result {
                case .success(let species):
                    self.speciesObject = species
                    self.title = species.name.uppercased()
                    self.tableView.reloadData()
                    self.fetchFilms()
                case .failure(let error):
                    print("error", error)
                }
            }
        }
    }
    
    func fetchFilms() {
        guard let species = self.speciesObject else { return }
        let fetchGroup = DispatchGroup()
        
        for url in species.films {
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
            self.fetchPeople()
        }
    }
    
    func fetchPeople() {
        guard let species = self.speciesObject else { return }
        let fetchGroup = DispatchGroup()
        
        for url in species.people {
            fetchGroup.enter()
            let id = url.digits
            peopleRepo.fetchByID(id: id) { result in
                switch result {
                case .success(let person):
                    self.peopleNames.append(person.name + ", ")
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

extension SpeciesViewController: UITableViewDelegate, UITableViewDataSource {
    
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
        headerView.avatar.avatarText.text = Utilities.sharedManager.initalGenerator(text: speciesObject?.name ?? "-")
        headerView.titleText.text = speciesObject?.classification
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
            let date = self.speciesObject?.created.toISODate()
            cell.value.text = date?.date.toFormat("MM/dd/yyyy")
        case .Films:
            cell.value.text = self.filmNames
        case .People:
            cell.value.text = self.peopleNames
        case .Name:
            cell.value.text = self.speciesObject?.name
        case .Classification:
            cell.value.text = self.speciesObject?.classification
        case .Designation:
            cell.value.text = self.speciesObject?.designation
        case .Avg_Height:
            cell.value.text = self.speciesObject?.avgHeight
        case .Avg_Lifespan:
            cell.value.text = self.speciesObject?.avgLifespan
        case .Eye_Color:
            cell.value.text = self.speciesObject?.eyeColors
        case .Hair_Color:
            cell.value.text = self.speciesObject?.hairColors
        case .Skin_Color:
            cell.value.text = self.speciesObject?.skinColors
        case .Language:
            cell.value.text = self.speciesObject?.language
        case .Homeworld:
            cell.value.text = self.speciesObject?.homeworld
        }
        return cell
    }
}
