//
//  BSTabPageController.swift
//  BSTabPageController
//
//  Created by 林翌埕-20001107 on 2021/2/24.
//

import UIKit

final class BSTabPageView: UIView {
	
    var config: BSTabPageViewConfiguration = .init()
    
    var isTabMenuClickable: Bool = false {
        didSet {
            menuBar.menuItemCollectionView.allowsSelection = !isTabMenuClickable
        }
    }
    
    // BSTabPageView's dataSources. Page can be UIView or UIViewController.
    var dataSources: [BSTabPageDataSource] = []
    var menuBar: BSMenuBar!
    var contentView: BSTabPageContentView!
    
    init(frame: CGRect, config: BSTabPageViewConfiguration = .init(), dataSources: [BSTabPageDataSource]) {
        self.config = config
        self.dataSources = dataSources
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        guard menuBar == nil && contentView == nil else { return }
        setupMenuBar()
        setupcontentViews()
    }
    
    private func setupcontentViews() {
        contentView = BSTabPageContentView(contentViews: dataSources.map { $0.page })
		addSubview(contentView.view)
        
        contentView.selected = IndexPath(item: config.defaultSelectPage, section: 0)
        contentView.delegate = self
        
        // Constraints
        contentView.view.translatesAutoresizingMaskIntoConstraints = false
        contentView.view.topAnchor.constraint(equalTo: menuBar.bottomAnchor, constant: 0).isActive = true
        contentView.view.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        contentView.view.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        contentView.view.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
    }
    
    private func setupMenuBar() {
        menuBar = BSMenuBar(config: config, items: dataSources)
        addSubview(menuBar)
        
        menuBar.delegate = self
        
        // Constraints
        menuBar.translatesAutoresizingMaskIntoConstraints = false
        menuBar.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        menuBar.heightAnchor.constraint(equalToConstant: config.menuBarHeight).isActive = true
        menuBar.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        menuBar.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
    }
}

// MARK: BSTabPageContentViewDelegate
extension BSTabPageView: BSTabPageContentViewDelegate {
    func isTabMenuClickable(_ lock: Bool) {
        self.isTabMenuClickable = lock
    }
    
    func contentDidChange(index: Int) {
        menuBar.selectTab(index: index)
    }
}

// MARK: BSTabPageView
extension BSTabPageView: BSMenuBarDelegate {
    func didSelectTab(index: Int) {
		contentView.selected = .init(item: index, section: 0)
        contentView.contentCollectionView.selectItem(at: .init(item: index, section: 0), animated: true, scrollPosition: .centeredHorizontally)
    }
}


func setFillConstraint(parent: UIView, child: UIView) {
    child.translatesAutoresizingMaskIntoConstraints = false
    child.topAnchor.constraint(equalTo: parent.topAnchor, constant: 0).isActive = true
    child.bottomAnchor.constraint(equalTo: parent.bottomAnchor, constant: 0).isActive = true
    child.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 0).isActive = true
    child.trailingAnchor.constraint(equalTo: parent.trailingAnchor, constant: 0).isActive = true
}
