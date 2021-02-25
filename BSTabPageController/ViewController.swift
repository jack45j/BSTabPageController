//
//  ViewController.swift
//  BSTabPageController
//
//  Created by 林翌埕-20001107 on 2021/2/24.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tabPage: BSTabPageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let view1 = UIView()
        view1.backgroundColor = .blue
        
        let controller = UIViewController()
        controller.view.backgroundColor = .yellow
		tabPage.config.menuBarHeight = 60
        tabPage.dataSources = [
            BSTabPageDataSource(title: "ABC", page: view1),
            BSTabPageDataSource(title: "CBA", page: controller),
			BSTabPageDataSource(title: "DDD", page: view1),
			BSTabPageDataSource(title: "CBAA", page: controller)
        ]
    }
}

