//
//  BSTabPageViewConfiguration.swift
//  BSTabPageController
//
//  Created by 林翌埕-20001107 on 2021/2/25.
//

import UIKit

struct BSTabPageViewConfiguration {
    var menuBarHeight: CGFloat = 60
    var menuBarFont: UIFont? = nil
    var menuBarTextColor: UIColor = .lightGray
    var menuBarHighlightedTextColor: UIColor = .black
    var menuBarLineHeight: CGFloat = 4
    var menuBarLineBackgroundColor: UIColor = .lightGray
    var menuBarLineColor: UIColor = .black
    var menuBarBackgroundColor: UIColor = .clear
    var menuBarHighlightedBackgroundColor: UIColor = .black
    var menuBarArrangedDirection: NSLayoutConstraint.Axis = .vertical
    var defaultSelectPage: Int = 0
}
