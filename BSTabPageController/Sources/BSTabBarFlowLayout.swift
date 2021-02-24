//
//  BSTabBarFlowLayout.swift
//  BSTabPageController
//
//  Created by 林翌埕-20001107 on 2021/2/24.
//

import UIKit

class BSTabBarContentFlowLayout: UICollectionViewFlowLayout {
    override func prepare() {
        super.prepare()
        guard let cv = collectionView else { return }
        scrollDirection = .horizontal
        minimumLineSpacing = 0
        minimumInteritemSpacing = 0
		sectionInset = .zero
    }
}

class BSTabBarFlowLayout: UICollectionViewFlowLayout {
    
    private let itemCount: Int
    
    init(itemCount: Int) {
        self.itemCount = itemCount
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepare() {
        super.prepare()
        
        guard let cv = collectionView else { return }
        
        let lineSpacing = 0
        let interSpacing = 0
        minimumLineSpacing = CGFloat(lineSpacing)
        minimumInteritemSpacing = CGFloat(interSpacing)
        cv.layoutMargins = .zero
		cv.contentOffset = .zero
		cv.contentInset = .zero
        itemSize = .init(width: cv.frame.width / CGFloat(itemCount), height: cv.frame.height)
    }
}
