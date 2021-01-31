//
//  Cells.swift
//
//  Created by My Apps on 11/10/2020.
//  Copyright © 2020 Angela Yu. All rights reserved.
//

import UIKit

class LoadingCell: UITableViewCell {
    
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        spinner.startAnimating()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    
}
