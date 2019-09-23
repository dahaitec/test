//
//  PageTitleView.swift
//  test
//
//  Created by Sheng Zhao Huang on 2019/9/7.
//  Copyright © 2019 Sheng Zhao Huang. All rights reserved.
//

import UIKit

protocol PageTitleViewDelegate : class {
    func pageTitleView(titleView : PageTitleView,selectedIndex index:Int)
}

private let kscrollLineH : CGFloat = 2

private let kNormalColor : (CGFloat,CGFloat,CGFloat) = (85,85,85)
private let kSelectColor : (CGFloat,CGFloat,CGFloat) = (255,128,0)




class PageTitleView: UIView {

    private var currentIndex : Int = 0
    private var titles : [String]
    weak var delegate : PageTitleViewDelegate?
    
    
    private lazy var titleLabels : [UILabel] = [UILabel]()
    
    private lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        
        return scrollView
        
    }()
    
    private lazy var scrollLine : UIView = {
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.orange
        
        return scrollLine
        
    }()
    
    init(frame: CGRect, titles: [String]) {
        self.titles = titles
        super.init(frame: frame)
        setupUI()

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension PageTitleView {
    private func setupUI() {
        //1.添加UIScrollView
        addSubview(scrollView)
        scrollView.frame = bounds
        //2.添加title对应的Label
        setupTitleLabels()
        
        //3
        setupBottomLineAndScrolline()
    }
    
    private func setupTitleLabels() {

        let lableW : CGFloat = frame.width / CGFloat(titles.count)
        let lableH : CGFloat = frame.height - kscrollLineH

        let lableY : CGFloat = 0
        
        for (index,title) in titles.enumerated() {
            //1.create uilable
            let label = UILabel()
            
            //2 lable proprity
            label.text = title
            label.tag = index
            label.font = UIFont.systemFont(ofSize: 16.0)
            label.textColor = UIColor.darkGray
            label.textAlignment = .center
            
            //3.frame

            let lableX : CGFloat = lableW * CGFloat(index)
            label.frame = CGRect(x: lableX, y: lableY, width: lableW, height: lableH)
            
            scrollView.addSubview(label)
            titleLabels.append(label)
            label.isUserInteractionEnabled = true
            
            let  tapGes = UITapGestureRecognizer(target: self, action: #selector(self.titleLabelClick(tapGes:)))
            label.addGestureRecognizer(tapGes)
        }
        
    }
    
    private func setupBottomLineAndScrolline(){
        //1
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.lightGray
        let lineH : CGFloat = 0.5
        bottomLine.frame = CGRect(x: 0, y: frame.height - lineH, width: frame.width, height: lineH)
        addSubview(bottomLine)
        //2
        
        guard let firstLabel = titleLabels.first else { return }
        firstLabel.textColor = UIColor.orange
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height-kscrollLineH, width: firstLabel.frame.width, height: kscrollLineH)
         //scrollView.addSubview(scrollLine)
        addSubview(scrollLine)
    }
}

extension PageTitleView {
    
    @objc private func titleLabelClick(tapGes: UITapGestureRecognizer) {
        guard let currentLabel = tapGes.view as? UILabel else {return}
        
        let oldLabel = titleLabels[currentIndex]
        
        currentLabel.textColor  = UIColor(r: kSelectColor.0, g: kSelectColor.1 , b: kSelectColor.2)
        oldLabel.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1 , b: kNormalColor.2)
        
        currentIndex = currentLabel.tag
        
        let scrollLineX = CGFloat( currentLabel.tag ) * scrollLine.frame.width
        UIView.animate(withDuration: 0.05){
            self.scrollLine.frame.origin.x = scrollLineX
        }
        
        delegate?.pageTitleView(titleView: self, selectedIndex: currentIndex)
    }
}

extension PageTitleView {
    
    func setTitleWithProgress(progress: CGFloat,sourceIndex : Int,targetIndex : Int){
       let  sourceLabel = titleLabels[sourceIndex]
       let  targetLabel = titleLabels[targetIndex]
        
       let moveTotalX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
       let moveX = moveTotalX*progress
       scrollLine.frame.origin.x = sourceLabel.frame.origin.x + moveX
    
        let colorDelta = (kSelectColor.0 - kNormalColor.0,kSelectColor.1-kNormalColor.1,kNormalColor.2-kSelectColor.2)
        sourceLabel.textColor = UIColor(r:kSelectColor.0-colorDelta.0 * progress,g:kSelectColor.1-colorDelta.1 * progress,b:kSelectColor.2-colorDelta.2 * progress)
        
        targetLabel.textColor = UIColor(r:kSelectColor.0-colorDelta.0 * progress,g:kSelectColor.1-colorDelta.1 * progress,b:kSelectColor.2-colorDelta.2 * progress)
        
        currentIndex = targetIndex
    }
}
