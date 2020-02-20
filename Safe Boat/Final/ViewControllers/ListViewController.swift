//
//  ListViewController.swift
//  Final
//
//  Created by Ivan on 18.02.2020.
//  Copyright © 2020 Ivan Baranov. All rights reserved.
//


import UIKit
import  CoreData
class ListViewController: UITableViewController,AlertProtocol {
    var dataController:DataController!
    var fetchedResultsController:NSFetchedResultsController<Boat>!
    fileprivate func setupFetchedResultsController() {
        let fetchRequest:NSFetchRequest<Boat> = Boat.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "boatId", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: dataController.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController.delegate = self
        do {
            try fetchedResultsController.performFetch()
        } catch {
            fatalError("The fetch could not be performed: \(error.localizedDescription)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupFetchedResultsController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupFetchedResultsController()
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: false)
            tableView.reloadRows(at: [indexPath], with: .fade)
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        fetchedResultsController = nil
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let aBoat = fetchedResultsController.object(at: indexPath)
        alert(title: "Boat info", message: "IMO: \(aBoat.imo)\r\nLatitude: \(aBoat.latitude)\r\n Longitude: \(aBoat.longitude)\r\nHeading: \(aBoat.heading) \r\nSpeed: \(Double(aBoat.speed)/10) Knots")
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return fetchedResultsController.sections?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController.sections?[0].numberOfObjects ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let aBoat = fetchedResultsController.object(at: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier:  "boatCell", for: indexPath) as! TableViewCell
        
        cell.cellText.text  = "IMO: \(aBoat.imo)\r\nLatitude: \(aBoat.latitude) Longitude: \(aBoat.longitude)\r\nHeading: \(aBoat.heading) Speed: \(Double(aBoat.speed)/10) Knots"
        
        return cell
    }
    
}
