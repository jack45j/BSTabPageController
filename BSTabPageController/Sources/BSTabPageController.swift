//
//  BSTabPageController.swift
//  BSTabPageController
//
//  Created by 林翌埕-20001107 on 2021/2/24.
//

import UIKit

struct BSTabPageViewConfiguration {
	var menuBarHeight: CGFloat = 60
	var menuBarFont: UIFont = .systemFont(ofSize: 24)
	var menuBarTextColor: UIColor = .black
	var menuBarHighlightedTextColor: UIColor = .black
	var menuBarLineHeight: CGFloat = 4
	var menuBarLineColor: UIColor = .black
	var menuBarBackgroundColor: CGColor = UIColor.red.cgColor
	var menuBarHighlightedBackgroundColor: CGColor = UIColor.white.cgColor
}

final class BSTabPageView: UIView {
	
	var config: BSTabPageViewConfiguration = .init()
    
    var isTabMenuClickable: Bool = false {
        didSet {
            menuBar.tabCollectionView.allowsSelection = !isTabMenuClickable
        }
    }
    
    // BSTabPageView's dataSources. Page can be UIView or UIViewController.
    var dataSources: [BSTabPageDataSource] = []
    var menuBar: BSTabBar!
    var contentPage: BSTabPageContentView!
    
    init(frame: CGRect, dataSources: [BSTabPageDataSource]) {
        self.dataSources = dataSources
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        setupTabBar()
        setupContentPages()
    }
    
    private func setupTabBar() {
		menuBar = BSTabBar(frame: .init(x: 0, y: 0, width: frame.width, height: config.menuBarHeight), titles: dataSources.map { $0.tabTitle } )
        addSubview(menuBar)
        menuBar.delegate = self
        
        menuBar.translatesAutoresizingMaskIntoConstraints = false
        menuBar.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
		menuBar.heightAnchor.constraint(equalToConstant: config.menuBarHeight).isActive = true
        menuBar.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        menuBar.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
    }
    
    private func setupContentPages() {
        contentPage = BSTabPageContentView(contentPages: dataSources.map { $0.page })
		addSubview(contentPage.view)
		contentPage.selected = IndexPath(item: 0, section: 0)
        contentPage.delegate = self
        
        contentPage.view.translatesAutoresizingMaskIntoConstraints = false
        contentPage.view.topAnchor.constraint(equalTo: menuBar.bottomAnchor, constant: 0).isActive = true
        contentPage.view.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        contentPage.view.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        contentPage.view.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
    }
}

extension BSTabPageView: BSTabPageContentViewDelegate {
    func isTabMenuClickable(_ lock: Bool) {
        self.isTabMenuClickable = lock
    }
    
    func contentDidChange(index: Int) {
        menuBar.selectTab(index: index)
    }
}

extension BSTabPageView: BSTabBarDelegate {
    func didSelectTab(index: Int) {
		contentPage.selected = .init(item: index, section: 0)
        contentPage.contentCollectionView.selectItem(at: .init(item: index, section: 0), animated: true, scrollPosition: .centeredHorizontally)
    }
}


func setFillConstraint(parent: UIView, child: UIView) {
    child.translatesAutoresizingMaskIntoConstraints = false
    child.topAnchor.constraint(equalTo: parent.topAnchor, constant: 0).isActive = true
    child.bottomAnchor.constraint(equalTo: parent.bottomAnchor, constant: 0).isActive = true
    child.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 0).isActive = true
    child.trailingAnchor.constraint(equalTo: parent.trailingAnchor, constant: 0).isActive = true
}
