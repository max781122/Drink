//
//  OrderCell.swift
//  Drink
//
//  Created by sourceinn on 2018/5/15.
//  Copyright © 2018年 sourceinn. All rights reserved.
//

import UIKit

class OrderCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var drinkName: UILabel!
    @IBOutlet weak var ice: UILabel!
    @IBOutlet weak var sugar: UILabel!
    @IBOutlet weak var price: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
