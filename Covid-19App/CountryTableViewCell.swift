//
//  CountryTableViewCell.swift
//  Covid-19App
//
//  Created by iosdev on 23.4.2020.
//  Copyright © 2020 Covid-19App. All rights reserved.
//

import UIKit

class CountryTableViewCell: UITableViewCell {

    @IBOutlet weak var countryName: UILabel!
    
    @IBOutlet weak var recovered: UILabel!
    
    @IBOutlet weak var fatalities: UILabel!
    
    @IBOutlet weak var infected: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
