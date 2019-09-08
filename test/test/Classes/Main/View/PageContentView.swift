//
//  PageContentView.swift
//  test
//
//  Created by Sheng Zhao Huang on 2019/9/8.
//  Copyright © 2019 Sheng Zhao Huang. All rights reserved.
//

import UIKit

private let ContentCellID = "ContentCellID"

class PageContentView: UIView {

    private var childVcs : [UIViewController]
    private var parentViewControllor : UIViewController
    
    private lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
       
        layout.itemSize = self.bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: ContentCellID)
        
        
        return collectionView
        
    }()
    
    init(frame: CGRect,childVcs: [UIViewController],parentViewControllor : UIViewController) {
        self.childVcs = childVcs
        self.parentViewControllor = parentViewControllor
        
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension PageContentView {
    
    private func setupUI() {
        for childVc in childVcs {
            parentViewControllor.addChild(childVc)
            
            addSubview(collectionView)
            collectionView.frame = bounds
        }
    }
}


extension PageContentView :UICollectionViewDataSource {

    
    func collectionView(_ collectionView: UICollectionView,numberOfItemsInSection section :Int) -> Int {
        
        return childVcs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCellID, for: indexPath)
        
        for view in cell.contentView.subviews {
            
            view.removeFromSuperview()
        }
        
        let childVc = childVcs[indexPath.item]
        childVc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVc.view)
        
        return cell
    }
    
}
