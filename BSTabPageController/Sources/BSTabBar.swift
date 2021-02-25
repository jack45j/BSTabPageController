//
//  BSMenuBar.swift
//  BSTabPageController
//
//  Created by 林翌埕-20001107 on 2021/2/24.
//

import UIKit

class BSMenuBar: UIView, UICollectionViewDelegateFlowLayout {
    
    var items: [BSTabPageDataSource]
    
    weak var delegate: BSMenuBarDelegate?
    var config: BSTabPageViewConfiguration!
        
    let horizontalBarView = UIView()
	lazy var horizontalBarCenterXAnchorConstraint: NSLayoutConstraint = .init()
    
    func setupHorizontalBar() {
        // Bar background view
        let backgroundView = UIView()
        addSubview(backgroundView)
        backgroundView.backgroundColor = config.menuBarLineBackgroundColor
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        backgroundView.widthAnchor.constraint(equalTo: menuItemCollectionView.widthAnchor, multiplier: 1).isActive = true
        backgroundView.heightAnchor.constraint(equalToConstant: config.menuBarLineHeight).isActive = true
        
        // Bar view
        horizontalBarView.backgroundColor = config.menuBarLineColor
        horizontalBarView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(horizontalBarView)
        horizontalBarView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        horizontalBarView.widthAnchor.constraint(equalTo: menuItemCollectionView.widthAnchor, multiplier: CGFloat(1.0 / Double(items.count))).isActive = true
        horizontalBarView.heightAnchor.constraint(equalToConstant: config.menuBarLineHeight).isActive = true
    }
    
    init(config: BSTabPageViewConfiguration, items: [BSTabPageDataSource]) {
        self.items = items
        self.config = config
        super.init(frame: .zero)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func commonInit() {
        menuItemCollectionView.register(BSTabCell.self, forCellWithReuseIdentifier: String(describing: BSTabCell.self))
        
        addSubview(menuItemCollectionView)
        setFillConstraint(parent: self, child: menuItemCollectionView)
        setupHorizontalBar()
    }
    
    lazy var menuItemCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: frame, collectionViewLayout: BSMenuBarFlowLayout(itemCount: items.count))
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = config.menuBarBackgroundColor
        return collectionView
    }()
    
    func selectTab(index: Int) {
        delegate?.didSelectTab(index: index)
        menuItemCollectionView.visibleCells.forEach { $0.isHighlighted = menuItemCollectionView.indexPath(for: $0) == IndexPath(item: index, section: 0) }
        menuItemCollectionView.selectItem(at: .init(item: index, section: 0), animated: true, scrollPosition: .centeredHorizontally)
		horizontalBarCenterXAnchorConstraint.isActive = false
		guard let cell = menuItemCollectionView.cellForItem(at: .init(item: index, section: 0)) else { return }
		horizontalBarCenterXAnchorConstraint = horizontalBarView.centerXAnchor.constraint(equalTo: cell.centerXAnchor)
		horizontalBarCenterXAnchorConstraint.isActive = true
		
		UIView.animate(withDuration: 0.5) {
			self.layoutSubviews()
        }
    }
}

extension BSMenuBar: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectTab(index: indexPath.item)
    }
}

extension BSMenuBar: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: BSTabCell.self), for: indexPath) as? BSTabCell else { fatalError() }
        cell.titleLabel.text = items[indexPath.item].tabTitle
        cell.titleLabel.font = config.menuBarFont
        cell.titleLabel.highlightedTextColor = config.menuBarHighlightedTextColor
        cell.titleLabel.textColor = config.menuBarTextColor
        cell.iconImageView.image = items[indexPath.item].tabIcon?.image ?? .none
        cell.iconImageView.highlightedImage = items[indexPath.item].tabIcon?.highlightedImage ?? .none
        cell.stackView.axis = config.menuBarArrangedDirection
        cell.backgroundColor = cell.isHighlighted ? config.menuBarHighlightedBackgroundColor : config.menuBarBackgroundColor
        return cell
    }
}

protocol BSMenuBarDelegate: class {
    func didSelectTab(index: Int)
}
