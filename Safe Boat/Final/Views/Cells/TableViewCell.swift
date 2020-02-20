//
//  TableViewCell.swift
//  Final
//
//  Created by Ivan on 18.02.2020.
//  Copyright © 2020 Ivan Baranov. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet weak var cellText: UILabel!
    override func prepareForReuse() {
        cellText.text = nil
    }
}
