//
//  PageContentView.swift
//  test
//
//  Created by Sheng Zhao Huang on 2019/9/8.
//  Copyright © 2019 Sheng Zhao Huang. All rights reserved.
//

import UIKit

protocol  PageContentViewDelegate : class {
    func pageContentView(contentView : PageContentView, progress : CGFloat,sourceIndex : Int,targetIndex :Int)
}

private let ContentCellID = "ContentCellID"

class PageContentView: UIView {

    private var childVcs : [UIViewController]
    private weak var parentViewControllor : UIViewController?
    private var startOffsetX : CGFloat  = 0
    private var isForbidScrollDelegate : Bool = false
    weak var delegate : PageContentViewDelegate?
    
    private lazy var collectionView : UICollectionView = {[weak self] in
        let layout = UICollectionViewFlowLayout()
       
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.scrollsToTop =  false
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: ContentCellID)
        
        
        return collectionView
        
    }()
    
    init(frame: CGRect,childVcs: [UIViewController],parentViewControllor : UIViewController?) {
        self.childVcs = childVcs
        self.parentViewControllor = parentViewControllor
        
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension PageContentView : UICollectionViewDelegate {
   
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
       isForbidScrollDelegate = false
       startOffsetX = scrollView.contentOffset.x

    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if isForbidScrollDelegate {return}
        var progress : CGFloat = 0
        var sourceIndex : Int = 0
        var targetIndex : Int = 0
        
        let currentOffSetX = scrollView.contentOffset.x
        let scrollViewW = scrollView.bounds.width
        
        if currentOffSetX > startOffsetX{
            progress = currentOffSetX / scrollViewW - floor(currentOffSetX / scrollViewW)
            sourceIndex = Int(currentOffSetX / scrollViewW)
            targetIndex = sourceIndex + 1
            
            if targetIndex >= childVcs.count {
                targetIndex = childVcs.count - 1
            }
            
            if currentOffSetX - startOffsetX == scrollViewW {
                progress = 1
                targetIndex = sourceIndex
            }
            
        }else{
            progress = 1 - (currentOffSetX / scrollViewW - floor(currentOffSetX / scrollViewW))
            targetIndex = Int(currentOffSetX / scrollViewW)
            sourceIndex = targetIndex + 1
            if sourceIndex >= childVcs.count {
                sourceIndex = childVcs.count - 1
            }
        }
        delegate?.pageContentView(contentView: self, progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}

extension PageContentView {
    
    private func setupUI() {
        for childVc in childVcs {
            parentViewControllor?.addChild(childVc)
            
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




extension PageContentView {
    
    func setCurrentIndex(_ currentIndex : Int) {
       let offsetX = CGFloat(currentIndex) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: false)
    }
}
