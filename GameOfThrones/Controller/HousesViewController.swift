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
            print(house)
        }
    }
}

extension HousesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: K.detailSegueIdenifier, sender: indexPath)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return houses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath)
        
        
        cell.textLabel?.text = houses[indexPath.row].name
        
        if indexPath.row == houses.count - 1 && houseManager.additonalResults {
            houseManager.fetchHouses()
        }
        
        return cell
    }
    
}

extension HousesViewController: HouseManagerDelegate {
    
    func didUpdateHouses(houses: [HouseModel]) {
        self.houses += houses
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
}
