//
//  HR_CoustemShowView.swift
//  HR_VideoSwift
//
//  Created by HenryGao on 2017/7/25.
//  Copyright © 2017年 HenryGao. All rights reserved.
//

import UIKit


@objc protocol HR_CoustemShowViewDelegate : NSObjectProtocol {
    @objc optional func HR_CoustemShowViewDelegatePlayButton(aBtn : UIButton)       // 点击 暂停播放
    @objc optional func HR_CoustemShowViewDelegateFullButton(aBtn : UIButton)       // 点击 全屏还原
//    @objc optional func 
    
    
}




class HR_CoustemShowView: UIView {
    
    var sss : HR_VideoDelegate?
    
    var playButton = UIButton()    // 暂停、播放按钮
    var fullButton = UIButton()    // 全屏、还原按钮
    
    //显示 类：播放的时间 、 结束时间、 进度
    var videoTitle = UILabel()     // 标题
    var playTime = UILabel()       // 开始时间
    var allTime = UILabel()        // 结束时间
    var playProgress = HR_ProgressView() // 播放进度
    
    
    
    
    
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createView()
    }
    
    
    
    
    fileprivate func createView(){
        self.backgroundColor = UIColor.clear
        
        
        // 标题
        videoTitle.text = "默认占位标题"
        videoTitle.textAlignment = .center
        addSubview(videoTitle)
        
        
        //设置 播放按钮位置  默认值
        playButton.setImage(#imageLiteral(resourceName: "b"), for: .normal)
        playButton.setImage(#imageLiteral(resourceName: "p"), for: .selected)
        playButton.addTarget(self, action: #selector(playButtonAction(aBtn:)), for: .touchUpInside)
        addSubview(playButton)
        
        
        
        // 播放时间
        playTime.text = "00:00:00"
        playTime.adjustsFontSizeToFitWidth = true
        playTime.textAlignment = .center
        addSubview(playTime)
        
        // 总时间
        allTime.text = "00:00:00"
        allTime.adjustsFontSizeToFitWidth = true
        allTime.textAlignment = .center
        addSubview(allTime)
        
        
        // 播放进度
        
//        playProgress.progress = 0.5
//        playProgress.hr_progress.progress = 0.3
        addSubview(playProgress)
        
        
        
        // 设置 全屏的按钮
        fullButton.setImage(#imageLiteral(resourceName: "fullButtonN"), for: .normal)
        fullButton.addTarget(self, action: #selector(fullButtonAction(aBtn:)), for: .touchUpInside)
        addSubview(fullButton)
        
        
    }
    
    
    
    
    
    
    
    //MARK:- ========== 播放、暂停、全屏操作 ===========
    /** Single line comment spreading
     * HenryGao
     * 写点说明。。。。。
     **/
    @objc fileprivate func playButtonAction(aBtn : UIButton){
        //1。 暂停 播放
        
        //2. 改变button状态
        aBtn.isSelected = !aBtn.isSelected
        
    }
    @objc fileprivate func fullButtonAction(aBtn : UIButton){
        // 全屏操作
        
    }
    
    
    
    
    
    
    
    //MARK:-  ========== 更新位置 ===========
    /** Single line comment spreading
     * HenryGao
     * 写点说明。。。。。
     **/
    override func layoutSubviews() {
        super.layoutSubviews()
        print(frame)
        videoTitle.frame = CGRect(x: 0, y: 20, width: frame.width, height: 40)
        playTime.frame = CGRect(x: 10, y: frame.height - 40, width: 50, height: 30)
        allTime.frame = CGRect(x: frame.width - 104, y: frame.height - 40, width: 50, height: 30)
        playProgress.frame = CGRect(x: 60, y: frame.height - 25, width: frame.width - 164, height: 10)
        playButton.frame = CGRect(x: (frame.width - 40)/2, y: (frame.height - 40)/2, width: 40, height: 40)
        fullButton.frame = CGRect(x: frame.width - 44, y: frame.height - 40, width: 44, height: 30)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    

}
