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
        
        let view2 = UIView()
        view2.backgroundColor = .lightGray
        
        let controller1 = UIViewController()
        controller1.view.backgroundColor = .yellow
        
        let controller2 = UIViewController()
        controller2.view.backgroundColor = .purple
        let tabBarConfig = BSTabPageViewConfiguration(menuBarHeight: 60,
                                                      menuBarLineHeight: 2,
                                                      menuBarLineBackgroundColor: .lightGray,
                                                      menuBarLineColor: .green,
                                                      menuBarBackgroundColor: .white,
                                                      menuBarHighlightedBackgroundColor: .white)
		tabPage.config = tabBarConfig
        tabPage.dataSources = [
            BSTabPageDataSource(tabTitle: "ABC", page: view1),
            BSTabPageDataSource(tabTitle: "CBA", page: controller1),
			BSTabPageDataSource(tabTitle: "DDD", page: view2),
			BSTabPageDataSource(tabTitle: "CBAA", page: controller2)
        ]
    }
}

