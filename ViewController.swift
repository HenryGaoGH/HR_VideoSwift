//
//  ViewController.swift
//  HR_VideoSwift
//
//  Created by HenryGao on 2017/7/21.
//  Copyright © 2017年 HenryGao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var testV = HR_Video()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
        let sss = HR_CoustemShowView()
        
        testV = HR_Video(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width , height: 240))
        testV.hr_url = NSURL(string: "http://download.3g.joy.cn/video/236/60236937/1451280942752_hd.mp4")!
//        testV.backgroundColor = .red
        testV.coustemView = sss
        view.addSubview(testV)
        
        
        print("===============\(String(describing: testV.hr_url))")
        
        
        
        
        // 加载的 layer的显示 层。
//        let test = HR_VideoLoadLayer()
//        test.bounds = CGRect(x: 0, y: 0, width: 50, height: 50)
//        test.position = CGPoint(x: testV.frame.width / 2, y: testV.frame.height / 2)
//        test.anchorPoint = CGPoint(x: 0.5, y: 0.5)
////        test.backgroundColor = UIColor.red.cgColor
//        
//        testV.layer.addSublayer(test)
        
        
//        let sss = HR_CoustemShowView()
//        sss.backgroundColor = UIColor.red
//        sss.frame = CGRect(x: 0, y: 400, width: view.frame.width, height: 100)
//        view.addSubview(sss)
        
        
        
        
        
    }

    @IBAction func sss(_ sender: Any) {
        
        testV.HR_FullPlayerView()
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) { 
            self.testV.isFullVideo = true
            self.testV.HR_FullPlayerView()
        }
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

