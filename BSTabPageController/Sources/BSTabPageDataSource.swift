//
//  BSTabPageDataSource.swift
//  BSTabPageController
//
//  Created by 林翌埕-20001107 on 2021/2/24.
//

import UIKit

// DataSource of BSTabPageView
struct BSTabPageDataSource {
    
    // Tab item Icon
    var tabIcon: UIImageView? = nil
    
    // Tab title String.
    var tabTitle: String
    
    // Tab content page. Can be UIView and UIViewController.
    var page: BSTabPageViewType

    
//    init(title: String, page: BSTabPageViewType) {
//        self.tabTitle = title
//        self.page = page
//    }
    
}

protocol BSTabPageViewType {
    var pageView: UIView { get }
}

extension UIViewController: BSTabPageViewType {
    var pageView: UIView {
        return self.view
    }
}

extension UIView: BSTabPageViewType {
    var pageView: UIView {
        return self
    }
}
