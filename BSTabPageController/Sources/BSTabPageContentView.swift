//
//  BSTabPageContentView.swift
//  BSTabPageController
//
//  Created by 林翌埕-20001107 on 2021/2/24.
//

import UIKit

class BSTabPageContentView: UIView, UICollectionViewDelegateFlowLayout {
    
    let contentPages: [BSTabPageViewType]
    
    weak var delegate: BSTabPageContentViewDelegate?
    
    lazy var contentCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: bounds, collectionViewLayout: BSTabBarContentFlowLayout())
        collectionView.isPagingEnabled = true
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .black
        collectionView.contentInsetAdjustmentBehavior = .never
        return collectionView
    }()
    
    init(frame: CGRect, contentPages: [BSTabPageViewType]) {
        self.contentPages = contentPages
        super.init(frame: frame)
        commonInit()
        backgroundColor = .gray
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func commonInit() {
        contentCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "EmptyCell")
        addSubview(contentCollectionView)
        setFillConstraint(parent: self, child: contentCollectionView)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        delegate?.shouldLockGesture(true)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let index = Int(targetContentOffset.pointee.x / frame.width)
        delegate?.contentDidChange(index: index)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        delegate?.shouldLockGesture(false)
    }
}

extension BSTabPageContentView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        contentPages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EmptyCell", for: indexPath)
        let content = contentPages[indexPath.item].pageView
        cell.contentView.addSubview(content)
        setFillConstraint(parent: cell.contentView, child: content)
        return cell
    }
}

protocol BSTabPageContentViewDelegate: class {
    func contentDidChange(index: Int)
    func shouldLockGesture(_ lock: Bool)
}
