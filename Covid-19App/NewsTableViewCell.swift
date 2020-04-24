//
//  NewsTableViewCell.swift
//  Covid-19App
//
//  Created by Rafe Ibrahim on 24.4.2020.
//  Copyright © 2020 Covid-19App. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    @IBOutlet weak var newsDescription: UILabel!
    
    @IBOutlet weak var newsTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
