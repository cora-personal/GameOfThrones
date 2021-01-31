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
        setupCells(tableView: tableView)
    }
    
}

//MARK: - Helper Methods

func setupCells(tableView: UITableView) {
    tableView.register((UINib(nibName: K.CellIdentifiers.nothingFoundCell, bundle: nil)), forCellReuseIdentifier: K.CellIdentifiers.nothingFoundCell)
    tableView.register((UINib(nibName: K.CellIdentifiers.loadingCell, bundle: nil)), forCellReuseIdentifier: K.CellIdentifiers.loadingCell)
}

// MARK:- TableView Methods
extension HousesViewController: UITableViewDelegate, UITableViewDataSource {
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if houseManager.isLoading || houseManager.performedRequest && houses.count == 0 {
            return 1
        } else {
            return houses.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if houseManager.isLoading {
            return tableView.dequeueReusableCell(withIdentifier: K.CellIdentifiers.loadingCell, for: indexPath) as! LoadingCell
        } else if houses.count == 0 {
            return tableView.dequeueReusableCell(withIdentifier: K.CellIdentifiers.nothingFoundCell, for: indexPath)
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: K.CellIdentifiers.houseCell, for: indexPath)
            cell.textLabel?.text = houses[indexPath.row].name
            houseManager.fetchAdditonalResults(row: indexPath.row, lastHouse: houses.count)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        if houses.count > 0 {
            performSegue(withIdentifier: K.SegueIdentifiers.detailSegue, sender: indexPath)
        } else {
            return
        }
    }
    
    //Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        if segue.identifier == K.SegueIdentifiers.detailSegue {
            let detailViewController = segue.destination
                as! DetailViewController
            let indexPath = sender as! IndexPath
            let house = houses[indexPath.row]
            detailViewController.house = house
        }
    }
}


// MARK:- House Manager Delegate
extension HousesViewController: HouseManagerDelegate {
    
    func didUpdateHouses(houses: [HouseModel]) {
        self.houses += houses
        houseManager.performedRequest = true
        houseManager.isLoading = false
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
