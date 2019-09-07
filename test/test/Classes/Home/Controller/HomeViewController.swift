//
//  HomeViewController.swift
//  test
//
//  Created by Sheng Zhao Huang on 2019/9/7.
//  Copyright © 2019 Sheng Zhao Huang. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }
}

extension HomeViewController{
    private func setupUI(){
    
    setupNavigationBar()
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
