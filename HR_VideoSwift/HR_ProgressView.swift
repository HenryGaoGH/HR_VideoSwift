//
//  HR_ProgressView.swift
//  HR_VideoSwift
//
//  Created by HenryGao on 2017/7/25.
//  Copyright © 2017年 HenryGao. All rights reserved.
//

import UIKit

class HR_ProgressView: UIProgressView {
    
    var hr_progress = UIProgressView()

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
        
        self.progressTintColor = UIColor.gray
        
        hr_progress.progressTintColor = UIColor.red
        hr_progress.backgroundColor = UIColor.clear
        hr_progress.trackTintColor = UIColor.clear
        addSubview(hr_progress)
        
    }
    
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        hr_progress.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
    }
    
    
    
    
    
    
    
    
    
    
    
    

}
