//
//  BSTabPageContentView.swift
//  BSTabPageController
//
//  Created by 林翌埕-20001107 on 2021/2/24.
//

import UIKit

class BSTabPageContentView: UIViewController {
    
    /// Collection of content views
    let contentViews: [BSTabPageViewType]
    
    /// Selected item
	var selected: IndexPath = .init()
    
    weak var delegate: BSTabPageContentViewDelegate?
	
    lazy var contentCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = .zero
		let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isPagingEnabled = true
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
	
    init(contentViews: [BSTabPageViewType]) {
		self.contentViews = contentViews
		super.init(nibName: nil, bundle: nil)
        contentCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "BSTabPageContentCell")
        view.addSubview(contentCollectionView)
	}
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
	
	override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
		super.viewWillTransition(to: size, with: coordinator)
		view.layoutSubviews()
	}
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		contentCollectionView.collectionViewLayout.invalidateLayout()
		contentCollectionView.frame = view.bounds
		contentCollectionView.layoutAttributesForItem(at: selected)
		delegate?.contentDidChange(index: selected.item)
	}
}

// MARK: ScrollViewDelegate
extension BSTabPageContentView {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        delegate?.didScroll(scrollView)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        delegate?.isTabMenuClickable(true)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let index = Int(targetContentOffset.pointee.x / view.frame.width)
        delegate?.contentDidChange(index: index)
        selected = IndexPath(item: index, section: 0)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        delegate?.isTabMenuClickable(false)
    }
}

// MARK: UICollectionViewDelegate & UICollectionViewDataSource
extension BSTabPageContentView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        contentViews.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BSTabPageContentCell", for: indexPath)
		cell.contentView.addSubview(contentViews[indexPath.item].pageView)
		setFillConstraint(parent: cell.contentView, child: contentViews[indexPath.item].pageView)
        return cell
    }
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return collectionView.frame.size
	}
}

protocol BSTabPageContentViewDelegate: class {
    func contentDidChange(index: Int)
    func isTabMenuClickable(_ lock: Bool)
    func didScroll(_ scrollView: UIScrollView)
}
