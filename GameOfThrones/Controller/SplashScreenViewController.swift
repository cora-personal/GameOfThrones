//
//  SplashScreenViewController.swift
//  GameOfThrones
//
//  Created by My Apps on 31/01/2021.
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
