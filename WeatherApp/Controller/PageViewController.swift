//
//  PageViewController.swift
//  WeatherApp
//
//  Created by Ricardo Bravo on 6/07/21.
//

import Foundation
import UIKit

class PageViewController: UIViewController {
    private let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
    private let pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    private var pageControl = UIPageControl()
    private var cacheItemViewControllers = NSCache<NSNumber, ItemViewController>()
    private var userLocationList = [Location](){
        didSet {
            self.pageControl.numberOfPages = userLocationList.count
        }
    }
    var lastViewedPageIndex: Int = 0
    
    var dataController: DataController! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.dataController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadLocations()
        setupPageController()
//        
//        ApiClient.weather(latitude: Double("34.053345") ?? 0.0, longitude: Double("-118.242349") ?? 0.0) { response, error in
//            print("Error \(error)")
//            print("Response \(response)")
//        }
        
    }
    
    private func loadLocations() {
        guard let data = try? dataController.fetchLocations() else { return }
        userLocationList = data
    }
    
    private func setupPageController() {
        let pageViewFrame = self.view.frame
        pageViewController(inside: pageViewFrame)
        setUpPageControl(inside: pageViewFrame)
        setupButton(inside: pageViewFrame)
    }
    
    private func pageViewController(inside frame: CGRect) {
        self.pageViewController.delegate = self
        self.pageViewController.dataSource = self
        self.addChild(self.pageViewController)
        self.view.addSubview(self.pageViewController.view)
        let weatherViewRect = CGRect(x: 0, y: 0, width: frame.width, height: frame.height - 50)
        self.pageViewController.view.frame = weatherViewRect
        self.pageViewController.didMove(toParent: self)
    }
    
    private func setUpPageControl(inside frame: CGRect) {
        pageControl = UIPageControl(frame: CGRect(x: 0,y: frame.maxY - 50, width: frame.maxX, height: 50))
        self.pageControl.numberOfPages = userLocationList.count + 1
        self.pageControl.currentPage = lastViewedPageIndex
        self.pageControl.tintColor = .gray
        self.pageControl.pageIndicatorTintColor = .gray
        self.pageControl.currentPageIndicatorTintColor = .white
        self.pageControl.backgroundColor = .clear
        self.view.addSubview(pageControl)
        pageControl.addTarget(self, action: #selector(self.changeCurrentPageViewController), for: .valueChanged)
    }
    
    func setupButton(inside frame: CGRect) {
        let buttonRect = CGRect(x: frame.maxX - 50, y: frame.maxY - 40, width: 20, height: 20)
        let addButton = UIButton(frame: buttonRect)
        addButton.setImage(UIImage(systemName: "list.dash"), for: .normal)
        addButton.addTarget(self, action: #selector(self.showViewController), for: .touchUpInside)
        self.view.addSubview(addButton)
    }
    
    @objc func changeCurrentPageViewController() {
        print("tapped at \(self.pageControl.currentPage)")
        lastViewedPageIndex = self.pageControl.currentPage
        let pickedViewController = itemViewController(at: self.pageControl.currentPage)
        self.pageViewController.setViewControllers([pickedViewController], direction: .forward, animated: false, completion: nil)
    }
    
    @objc func showViewController() {
        performSegue(withIdentifier: "AddLocationSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddLocationSegue" {
            guard let navigationController = segue.destination as? UINavigationController else {
                return
            }
            
            guard let addLocationViewController = navigationController.topViewController as? AddLocationViewController else {
                return
            }
            
            addLocationViewController.delegate = self
        }
    }
}

extension PageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    func itemViewController(at index: Int) -> UIViewController {
        if let cachedWeatherViewController = cacheItemViewControllers.object(forKey: NSNumber(value: index)) {
            return cachedWeatherViewController
        }
        
        guard let itemViewController = mainStoryBoard.instantiateViewController(withIdentifier: ItemViewController.identifier) as? ItemViewController else {
            print("Error getting ItemViewControlller")
            fatalError()
        }
        
        itemViewController.location = userLocationList[index]
        itemViewController.index = index
        
        cacheItemViewControllers.setObject(itemViewController, forKey: NSNumber(value: index))
        return itemViewController
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        if let viewController = viewController as? ItemViewController {
            let currentIndex = viewController.index
            return currentIndex > 0 ? itemViewController(at: currentIndex - 1) : nil
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        if let viewController = viewController as? ItemViewController {
            let currentIndex = viewController.index
            return currentIndex < pageControl.numberOfPages - 1 ? itemViewController(at: currentIndex + 1) : nil
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        guard let visibleViewController = pageViewController.viewControllers?[0] as? ItemViewController else {
            print("Cannot show View Controller")
            return
        }
        self.pageControl.currentPage = visibleViewController.index
        self.lastViewedPageIndex = visibleViewController.index
    }
    
}

extension PageViewController: AddLocationDelegate {
    
    func userSelectLocation(at index: Int) {
        guard let itemViewController = itemViewController(at: index) as? ItemViewController else {
            print("Error userSelectLocation")
            return
        }
        self.pageViewController.setViewControllers([itemViewController], direction: .forward, animated: false, completion: nil)
        self.pageControl.currentPage = index
        self.lastViewedPageIndex = index
    }
    
    func addLocation(location: Location) {
        self.userLocationList.append(location)
    }
    
    func userDeleteLocation(at index: Int) {
        print("page vc delete location at index \(index)")
        if self.lastViewedPageIndex == index {
            self.lastViewedPageIndex = 0
        }
        if self.lastViewedPageIndex > index {
            self.lastViewedPageIndex -= 1
        }
        if isLastItem(index: index) {
            removeLocation(at: index)
            return
        }
        removeLocation(at: index)
        changeOrderLocationList(after: index)
    }
    
    private func isLastItem(index: Int) -> Bool {
        return index == userLocationList.count - 1
    }
    
    private func removeLocation(at index: Int) {
        userLocationList.remove(at: index)
        cacheItemViewControllers.removeObject(forKey: NSNumber(value: index))
    }
    
    private func changeOrderLocationList(after deletingIndex: Int) {
        var needChangeIndex = deletingIndex + 1
        repeat {
            let targetIndex = NSNumber(value: needChangeIndex)
            if let indexChangingViewController = self.cacheItemViewControllers.object(forKey: targetIndex) {
                self.cacheItemViewControllers.removeObject(forKey: targetIndex)
                indexChangingViewController.index -= 1
                self.cacheItemViewControllers.setObject(indexChangingViewController, forKey: NSNumber(value: indexChangingViewController.index))
            }
            needChangeIndex += 1
        } while needChangeIndex <= userLocationList.count
    }
    
}
