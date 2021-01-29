//
//  HouseManager.swift
//  GameOfThrones
//
//

import Foundation

protocol HouseManagerDelegate {
    func didUpdateHouses(houses: [HouseModel])
}

class HouseManager {
    var delegate: HouseManagerDelegate?
    var additonalResults = true
    let housesURL = K.housesURL
    var pageNumber = 1
    
    func fetchHouses() {
        let urlString = "\(housesURL)page=\(pageNumber)&pageSize=50"
        
        performRequest(urlString: urlString)
    }
    
    func performRequest(urlString: String) {
        if let url = URL(string: urlString) {
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { (data, response, error) in
                
                if error != nil {
                    print(error!)
                    return
                }
                
                if let houses = self.parseJSON(housesData: data!) {
                    self.delegate?.didUpdateHouses(houses: houses)
                }
                
            }
            task.resume()
        }
    }
    
    func parseJSON(housesData: Data) -> [HouseModel]? {
        var houses: [HouseModel] = []
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode([HouseModel].self, from: housesData)
            
            print(decodedData)
            
            if decodedData.count > 0 {
                self.pageNumber += 1
                houses += decodedData
            } else {
                additonalResults = false
                print("No (additional) results returned")
            }
        } catch {
            print("Parsing Error:\(error)")
        }
        return houses
    }
}
