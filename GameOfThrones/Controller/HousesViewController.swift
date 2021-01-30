//
//  HousesViewController.swift
//  GameOfThrones
//
//

import UIKit

class HousesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var houseManager = HouseManager()
    var houses: [HouseModel] = []
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        houseManager.delegate = self
        houseManager.fetchHouses()
        
        let cellNib = UINib(nibName: K.CellIdentifiers.nothingFoundCell, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: K.CellIdentifiers.nothingFoundCell)
    }
    
}

// MARK:- TableView Methods
extension HousesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if houses.count == 0 {
            return
        } else {
            performSegue(withIdentifier: K.detailSegueIdenifier, sender: indexPath)
        }
    }
    
    // MARK:- Navigation
    override func prepare(for segue: UIStoryboardSegue,
                          sender: Any?) {
        if segue.identifier == K.detailSegueIdenifier {
            let detailViewController = segue.destination
                as! DetailViewController
            let indexPath = sender as! IndexPath
            let house = houses[indexPath.row]
            detailViewController.house = house
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !houseManager.performedRequest {
            return 0
        } else if houses.count == 0 {
            return 1
        } else {
            return houses.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if houses.count == 0 {
            
            return tableView.dequeueReusableCell(withIdentifier:
            K.CellIdentifiers.nothingFoundCell, for: indexPath)
      
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: K.CellIdentifiers.houseCell, for: indexPath)
            
            cell.textLabel?.text = houses[indexPath.row].name
            
            if indexPath.row == houses.count - 1 && houseManager.additonalResults {
                houseManager.fetchHouses()
                
            
            }
         return cell
            
        }
        
       
    }
    
}

// MARK:- House Manager Delegate
extension HousesViewController: HouseManagerDelegate {
    
    func didUpdateHouses(houses: [HouseModel]) {
        self.houses += houses
        houseManager.performedRequest = true
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
}
