//
//  HR_VideoLoadLayer.swift
//  HR_VideoSwift
//
//  Created by HenryGao on 2017/7/22.
//  Copyright © 2017年 HenryGao. All rights reserved.
//  显示 加载 中 视频的 效果

import UIKit

class HR_VideoLoadLayer: CALayer {
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init() {
        super.init()
        
        createLayer()
        
    }
    
    
    
    
    @objc fileprivate func createLayer(){
        
        let temp = UIBezierPath(arcCenter: CGPoint(x: 35, y: 35), radius: 25, startAngle: 0.0, endAngle: .pi * 2 ,  clockwise: true)
        
        // 遮罩
        let shaperL = CAShapeLayer()
        shaperL.fillColor = UIColor.clear.cgColor
        shaperL.strokeColor = UIColor(red: 54/255.0, green: 189/255.0, blue: 164/255.0, alpha: 1).cgColor
        shaperL.lineWidth = 3;
        shaperL.strokeStart = 0;
        shaperL.strokeEnd = 0.8;
        shaperL.lineCap = "round";
        shaperL.lineDashPhase = 0.5;
        shaperL.path = temp.cgPath;
        
        //颜色渐变
        let colors = NSMutableArray(objects:UIColor(red: 54/255.0 , green: 189/255.0, blue: 164/255.0, alpha: 1).cgColor,UIColor.white.cgColor)
        let gradientLayer = CAGradientLayer()
        gradientLayer.shadowPath = temp.cgPath;
        gradientLayer.frame = CGRect(x: 35, y: 35, width: 60, height: 60)
        gradientLayer.startPoint = CGPoint(x: 0, y: 1)
        gradientLayer.endPoint = CGPoint(x: 1,y: 0);
        gradientLayer.colors = colors as? [Any]
        
        self.addSublayer(gradientLayer)//设置颜色渐变
        self.mask = shaperL            //设置圆环遮罩
        
        
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.fromValue = NSNumber(value: 0)
        rotationAnimation.toValue = NSNumber(value: Double.pi * 6.0)
        rotationAnimation.repeatCount = MAXFLOAT;
//        rotationAnimation.beginTime = 0.8; //延时执行，注释掉动画会同时进行
        rotationAnimation.duration = 3;
        
        self.add(rotationAnimation, forKey: "TransAnnimation")
        
    }
    
    
    
    
    override func removeFromSuperlayer() {
        super.removeFromSuperlayer()
        self.removeAnimation(forKey: "TransAnnimation")
        
    }
    
    
    
    
    
    
    

}
