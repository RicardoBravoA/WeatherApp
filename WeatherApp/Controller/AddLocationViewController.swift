//
//  AddLocationViewController.swift
//  WeatherApp
//
//  Created by Ricardo Bravo on 6/07/21.
//

import Foundation
import UIKit

class AddLocationViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    weak var delegate: AddLocationDelegate?
    var locations = [Location]()
    
    @IBAction func addLocation(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "SearchSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SearchSegue" {
            guard let searchViewController = segue.destination as? SearchViewController else {
                return
            }
            searchViewController.delegate = self
        }
    }
}

extension AddLocationViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.userSelectLocation(at: indexPath.row)
        dismiss(animated: true, completion: nil)
    }
}

extension AddLocationViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LocationCell", for: indexPath)
        let location = locations[indexPath.row]
        cell.textLabel?.text = location.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            locations.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

extension AddLocationViewController: SearchViewDelegate {
    func addLocation(location: Location) {
        print("Location \(location)")
        locations.append(location)
        tableView.reloadData()
    }
}
