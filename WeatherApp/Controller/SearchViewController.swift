//
//  SearchViewController.swift
//  WeatherApp
//
//  Created by Ricardo Bravo on 6/07/21.
//

import UIKit
import MapKit

class SearchViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet var tableView: UITableView!
    
    private var searchCompleter = MKLocalSearchCompleter()
    private var searchResults = [MKLocalSearchCompletion]()
    
    private weak var delegate: SearchViewDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.searchBar.showsCancelButton = true
        self.searchBar.becomeFirstResponder()
        self.searchCompleter.delegate = self
    }
    
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            searchResults.removeAll()
            tableView.reloadData()
        }
        searchCompleter.queryFragment = searchText
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension SearchViewController: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        searchResults = completer.results
        tableView.reloadData()
    }
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath)
        let searchResult = searchResults[indexPath.row]
        cell.textLabel?.text = searchResult.title
        return cell
    }
    
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedResult = searchResults[indexPath.row]
        let searchRequest = MKLocalSearch.Request(completion: selectedResult)
        let search = MKLocalSearch(request: searchRequest)
        search.start { (response, error) in
            guard error == nil else {
                print(error?.localizedDescription)
                return
            }
            guard let placeMark = response?.mapItems[0].placemark else {
                return
            }
            let locationName = "\(placeMark.locality ?? selectedResult.title)"
            self.delegate?.addLocation(location: Location(name: locationName, latitude: placeMark.coordinate.latitude, longitude: placeMark.coordinate.longitude))
            print("Location: \(locationName)")
            self.dismiss(animated: true, completion: nil)
        }
    }
}
