//
//  HomeViewController.swift
//  test
//
//  Created by Sheng Zhao Huang on 2019/9/7.
//  Copyright © 2019 Sheng Zhao Huang. All rights reserved.
//

import UIKit

private let kTitleViewH : CGFloat = 80

class HomeViewController: UIViewController {

    private lazy var pageTitleView : PageTitleView = { [weak self] in
       let titleFrame = CGRect(x: 0, y: kStatusBarH+kNavigationBarH, width: kScreenW, height: kTitleViewH)
       let titles = ["推荐","游戏","娱乐","趣玩"]
       let titleView = PageTitleView(frame: titleFrame, titles: titles)
       //titleView.backgroundColor = UIColor.red
        titleView.delegate = self
        
       return titleView
        
    }()
    
    private lazy var pageContentView : PageContentView = {[weak self] in
        let contentH = kScreenH-kStatusBarH-kNavigationBarH-kTitleViewH
        let contentFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH+kTitleViewH, width: kScreenH, height: contentH)
        
        var childVcs = [UIViewController]()
        for _ in 0..<4{
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor(r:CGFloat(arc4random_uniform(255)),g:CGFloat(arc4random_uniform(255)),b:CGFloat(arc4random_uniform(255)))
            childVcs.append(vc)
        }
        let contentView = PageContentView(frame: contentFrame, childVcs:childVcs, parentViewControllor: self)
        contentView.delegate = self
        
        return contentView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }
}

//MARK：设置UI界面
extension HomeViewController{
    private func setupUI(){
     UITableView.appearance().contentInsetAdjustmentBehavior = .never
    //1 设置导航栏
        setupNavigationBar()

    //2 添加TitleView
        view.addSubview(pageTitleView)
        
    //3 content
        view.addSubview(pageContentView)
        pageContentView.backgroundColor = UIColor.orange
        
    }
    
    
    private func setupNavigationBar(){

     navigationItem.leftBarButtonItem = UIBarButtonItem(imageName:"homeLogoIcon")
        

     
     let size = CGSize(width: 40, height: 40)
     let historyItem = UIBarButtonItem(imageName: "dyla_image_new", highImageName: "dyla_Image_no_data", size: size )
     let searchItem = UIBarButtonItem(imageName: "dyla_Image_no_data", highImageName: "dyla_image_new", size: size)
     let qrCodeItem = UIBarButtonItem(imageName: "wearBtn_unSelected", highImageName: "wearBtn_Selected", size: size)

      navigationItem.rightBarButtonItems = [historyItem, searchItem , qrCodeItem]
    }
    
}

extension HomeViewController : PageTitleViewDelegate {
    
    func pageTitleView(titleView: PageTitleView, selectedIndex index: Int) {
        pageContentView.setCurrentIndex(index)

    }
}

extension HomeViewController : PageContentViewDelegate {
    func pageContentView(contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        pageTitleView.setTitleWithProgress(progress: progress,sourceIndex:sourceIndex,targetIndex: targetIndex)
    }
    
    
  
}

