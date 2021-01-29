//
//  DetailViewController.swift
//  GameOfThrones
//
//

import UIKit

class DetailViewController: UIViewController {
    
    var house: HouseModel!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var coatOfArmsTextView: UITextView!
    @IBOutlet weak var coatOfArmsStaticLabel: UILabel!
    @IBOutlet weak var wordsStaticLabel: UILabel!
    @IBOutlet weak var wordsLabel: UILabel!
    @IBOutlet weak var regionImageView: UIImageView!
    @IBOutlet weak var regionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if house != nil {
            updateUI() }
    }
    
    func updateUI() {
        nameLabel.text = house.name
        
        regionImageView.image = UIImage(named: house.region)
        
        coatOfArmsTextView.text = house.coatOfArms
        if coatOfArmsTextView.text == "" {
            coatOfArmsStaticLabel.isHidden = true
        }
        
        wordsLabel.text = house.words
        if wordsLabel.text == "" {
            wordsStaticLabel.isHidden = true
        }
        
        regionLabel.text = house.region
    }
}


