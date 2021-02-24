//
//  BSTabBar.swift
//  BSTabPageController
//
//  Created by 林翌埕-20001107 on 2021/2/24.
//

import UIKit

class BSTabBar: UIView, UICollectionViewDelegateFlowLayout {
    
    var tabs: [String]
    
    weak var delegate: BSTabBarDelegate?
        
    let horizontalBarView = UIView()
    lazy var horizontalBarLeftAnchorConstraint: NSLayoutConstraint = horizontalBarView.leftAnchor.constraint(equalTo: self.leftAnchor)
    
    func setupHorizontalBar() {
        horizontalBarView.backgroundColor = .green
        horizontalBarView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(horizontalBarView)
        horizontalBarLeftAnchorConstraint.isActive = true
        horizontalBarView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        horizontalBarView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: CGFloat(1.0 / Double(tabs.count))).isActive = true
        horizontalBarView.heightAnchor.constraint(equalToConstant: 4).isActive = true
    }
    
    init(frame: CGRect, titles: [String]) {
        self.tabs = titles
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func commonInit() {
        tabCollectionView.register(BSTabCell.self, forCellWithReuseIdentifier: String(describing: BSTabCell.self))
        
        addSubview(tabCollectionView)
        setFillConstraint(parent: self, child: tabCollectionView)
        setupHorizontalBar()
    }
    
    lazy var tabCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: frame, collectionViewLayout: BSTabBarFlowLayout(itemCount: tabs.count))
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .black
        collectionView.contentInsetAdjustmentBehavior = .never
        return collectionView
    }()
    
    func selectTab(index: Int) {
        delegate?.didSelectTab(index: index)
        tabCollectionView.selectItem(at: .init(item: index, section: 0), animated: true, scrollPosition: .centeredHorizontally)
        horizontalBarLeftAnchorConstraint.constant = CGFloat(index) * frame.width / CGFloat(tabs.count)
        UIView.animate(withDuration: 0.5) {
            self.layoutIfNeeded()
        }
    }
}

extension BSTabBar: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectTab(index: indexPath.item)
    }
}

extension BSTabBar: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        tabs.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: BSTabCell.self), for: indexPath) as? BSTabCell else { fatalError() }
        cell.titleLabel.text = tabs[indexPath.row]
        return cell
    }
}

protocol BSTabBarDelegate: class {
    func didSelectTab(index: Int)
}
