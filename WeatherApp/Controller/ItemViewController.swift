//
//  ItemViewController.swift
//  WeatherApp
//
//  Created by Ricardo Bravo on 6/07/21.
//

import Foundation
import UIKit

class ItemViewController: UIViewController {
    
    static let identifier = "ItemViewController"
    var location : Location!
    var index = 0
    
    lazy var view0: UIView = {
        let view = UIView()
        view.backgroundColor = .systemTeal
        let label = UILabel()
        label.text = "Page 0"
        label.textAlignment = .center
        view.addSubview(label)
        label.edgeTo(view: view)
        return view
    }()
    
    lazy var view1: UIView = {
        let view = UIView()
        view.backgroundColor = .systemYellow
        let label = UILabel()
        label.text = "Page 1"
        label.textAlignment = .center
        view.addSubview(label)
        label.edgeTo(view: view)
        return view
    }()
    
    lazy var view2: UIView = {
        let view = UIView()
        view.backgroundColor = .systemRed
        let label = UILabel()
        label.text = "Page 2"
        label.textAlignment = .center
        view.addSubview(label)
        label.edgeTo(view: view)
        return view
    }()
    
    lazy var views = [view0, view1, view2]
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.isPagingEnabled = true
        scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(views.count), height: view.frame.height)
        
        for i in 0..<views.count {
            scrollView.addSubview(views[i])
            views[i].frame = CGRect(x: view.frame.width * CGFloat(i), y: 0, width: view.frame.width, height: view.frame.height)
        }
        
        scrollView.delegate = self
        
        return scrollView
    }()
    
    override func viewDidLoad() {
        view.addSubview(scrollView)
        scrollView.edgeTo(view: view)
    }
    
}


extension ItemViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
}
