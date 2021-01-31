//
//  SplashScreenViewController.swift
//  GameOfThrones
//
//

import UIKit

class SplashScreenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func imageTapped(_ sender: UITapGestureRecognizer) {
        performSegue(withIdentifier: K.SegueIdentifiers.houseListSegue, sender: nil)
    }
}
