//
//  PageTitleView.swift
//  test
//
//  Created by Sheng Zhao Huang on 2019/9/7.
//  Copyright © 2019 Sheng Zhao Huang. All rights reserved.
//

import UIKit

private let kscrollLineH : CGFloat = 2

class PageTitleView: UIView {

    private var titles : [String]
    
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

        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height-kscrollLineH, width: firstLabel.frame.width, height: kscrollLineH)
         //scrollView.addSubview(scrollLine)
        addSubview(scrollLine)
    }
}
