//
//  BSTabPageController.swift
//  BSTabPageController
//
//  Created by 林翌埕-20001107 on 2021/2/24.
//

import UIKit

final class BSTabPageView: UIView {
    
    var shouldLockGesture: Bool = false {
        didSet {
            menuBar.tabCollectionView.allowsSelection = !shouldLockGesture
        }
    }
    
    // BSTabPageView's dataSources. Page can be UIView or UIViewController.
    var dataSources: [BSTabPageDataSource] = []
    var menuBar: BSTabBar!
    var contentPage: BSTabPageContentView!

    // A CGFloat value to determine menu bar's height.
    var barHeight: CGFloat = 48.0
    
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
        menuBar = BSTabBar(frame: .init(x: 0, y: 0, width: frame.width, height: barHeight), titles: dataSources.map { $0.tabTitle } )
        addSubview(menuBar)
        menuBar.delegate = self
        
        menuBar.translatesAutoresizingMaskIntoConstraints = false
        menuBar.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        menuBar.heightAnchor.constraint(equalToConstant: barHeight).isActive = true
        menuBar.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        menuBar.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
    }
    
    private func setupContentPages() {
        contentPage = BSTabPageContentView(frame: .zero, contentPages: dataSources.map { $0.page })
        addSubview(contentPage)
        contentPage.delegate = self
        
        contentPage.translatesAutoresizingMaskIntoConstraints = false
        contentPage.topAnchor.constraint(equalTo: menuBar.bottomAnchor, constant: 0).isActive = true
        contentPage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        contentPage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        contentPage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
    }
}

extension BSTabPageView: BSTabPageContentViewDelegate {
    func shouldLockGesture(_ lock: Bool) {
        self.shouldLockGesture = lock
    }
    
    func contentDidChange(index: Int) {
        menuBar.selectTab(index: index)
    }
}

extension BSTabPageView: BSTabBarDelegate {
    func didSelectTab(index: Int) {
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
