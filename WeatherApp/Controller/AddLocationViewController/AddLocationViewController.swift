//
//  AddLocationViewController.swift
//  WeatherApp
//
//  Created by Ricardo Bravo on 6/07/21.
//

import Foundation
import UIKit
import CoreData

class AddLocationViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var fetchedResultsController: NSFetchedResultsController<Location>!
    
    var dataController: DataController! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.dataController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpFetchedResultsController()
    }
    
    @IBAction func addLocation(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "SearchSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SearchSegue" {
            guard let searchViewController = segue.destination as? SearchViewController else {
                return
            }
            searchViewController.delegate = self
        } else if segue.identifier == "DetailSegue" {
            guard let detailViewController = segue.destination as? DetailViewController else {
                return
            }
            let location = sender as! Location
            detailViewController.location = location
        }
    
    }
    
    private func setUpFetchedResultsController() {
        let fetchRequest: NSFetchRequest<Location> = Location.fetchRequest()
    
        let sortDescriptor = NSSortDescriptor(key: "created", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                              managedObjectContext: dataController.viewContext,
                                                              sectionNameKeyPath: nil, cacheName: nil)
        
        fetchedResultsController.delegate = self

        do {
            try fetchedResultsController.performFetch()
        } catch {
            fatalError("The fetch could not be performed: \(error.localizedDescription)")
        }
    }
}

extension AddLocationViewController: SearchViewDelegate {
    
    func addLocation(name: String, latitude: Double, longitude: Double) {
        let location = dataController.location()
        location.latitude = latitude
        location.longitude = longitude
        location.name = name
        
        dataController.save()
        tableView.reloadData()
    }
    
}
