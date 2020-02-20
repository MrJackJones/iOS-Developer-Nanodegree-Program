//
//  TableViewController.swift
//  OnTheMapND
//
//  Created by Ivan on 16.02.2020.
//  Copyright © 2020 Ivan Baranov. All rights reserved.
//

import UIKit

class TableViewController: UIViewController {
    
   
    
    @IBOutlet weak var studentLocationTableView: UITableView!
    @IBOutlet weak var tableActivityIndicatorView: UIActivityIndicatorView!

   
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setViewData()
    }
    
    
    
    //Refresh  tableView:
    @IBAction func refreshAction() {
        refresh()
    }
}
