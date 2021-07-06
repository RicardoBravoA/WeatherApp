//
//  SearchTableViewController.swift
//  WeatherApp
//
//  Created by Ricardo Bravo on 6/07/21.
//

import UIKit

class SearchTableViewController: UITableViewController, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    let data = ["Apples", "Bananas", "Oranges", "Pears"]
    var filteredData: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        filteredData = data
        self.searchBar.delegate = self
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell")! as UITableViewCell
        cell.textLabel?.text = filteredData[indexPath.row]
        return cell
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredData = []
        
        if searchText == "" {
            filteredData = data
        } else {
            for fruit in data {
                if fruit.lowercased().contains(searchText.lowercased()) {
                    filteredData.append(fruit)
                }
            }
        }
        
        self.tableView.reloadData()
    }
    
}
