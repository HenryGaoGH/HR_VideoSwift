//
//  HR_Video.swift
//  HR_VideoSwift
//
//  Created by HenryGao on 2017/7/21.
//  Copyright © 2017年 HenryGao. All rights reserved.
//  这是 我们的控制器类



import UIKit

import MediaPlayer
import AVFoundation


enum HR_VideoControlState {
    case Play   // 播放
    case Pause  // 暂停
    case Stop   // 停止
    case Error  // 错误
//    case HR_VideoControlStatePlay,
    
}




@objc protocol HR_VideoDelegate : NSObjectProtocol {
    @objc optional func HR_VideoDelegateResultsInfo(info : NSDictionary)   // 传递 程序中 所有的 状态信息
    @objc optional func HR_VideoDelegateLoadProgressInfo(info : Float)   // 缓冲进度
    @objc optional func HR_VideoDelegatePlayProgressInfo(info : Float)   // 传递 程序中 所有的 状态信息
    
    
}

// 结果闭包
//typealias HR_SendRes = (_ info : NSDictionary) -> Void




class HR_Video: UIView , HR_CoustemShowViewDelegate {
    
    // 播放相关
    fileprivate lazy var hr_player: AVPlayerLayer = {   // 播放层
        let temp = AVPlayerLayer()
        temp.anchorPoint =  CGPoint(x: 0, y: 0)
        temp.bounds = self.bounds
        return temp
    }()
    fileprivate var palyerItems : AVPlayerItem?
    fileprivate var hr_layer : AVPlayer?
    
    
    
    // 控制类
    @objc var hr_showAlert : Bool = false { // 是否显示 亮度、声音、播放进度 提示 默认不显示
        willSet{
            if !newValue { // 清除视图 控制 视图
                centerImg.removeFromSuperview()
            }
        }
    }
    var hr_showPlayView : Bool = false {    // 是否显示 自定义的 播放显示 （标题、进度、时间）
        willSet{
            if !newValue { // 设置 隐藏 （hidden）
                if coustemView != nil {
                    coustemView?.isHidden = true
                }
            }else {
                if coustemView != nil {
                    coustemView?.isHidden = false
                }
            }
        }
    }
    
    
    
    
    
    
    
    // 显示类。
    @objc fileprivate lazy var centerImg: UIImageView = {   // 在中心显示 亮度、进度、声音 的提示 信息
        let temp = UIImageView()
        temp.bounds = CGRect(x: 0, y: 0, width: 40, height: 40)
        temp.center = self.center
        self.addSubview(temp)
        return temp
    }()
    @objc open var coustemView : HR_CoustemShowView? = nil {  // 显示的控制View 播放、暂停、放大缩小、进度显示
        willSet{
            if newValue == nil ||  newValue == coustemView {
                return
            }
            self.coustemView = newValue
            self.coustemView?.frame = frame
            self.coustemView?.backgroundColor = UIColor.clear
            bringSubview(toFront: self.coustemView!)
            addSubview(self.coustemView!)
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    // 设置类
    @objc var hr_VideoDelegate : HR_VideoDelegate?    // 代理
    @objc var hr_url: NSURL?  {   // 资源数据
        willSet{
            
            if hr_url == newValue { return }

            // 判断 URL
            let tempB = HR_isURL(aURL: newValue!)
            if !tempB { return }
            
            self.hr_url = newValue
            // 设置 播放资源
            createVideo(aUrl: newValue!)
            
        }
        
    }
    
    
    
    
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createView()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    
    
    
    
    
    
    func createView(){
        
        // 判断  网络 决定显示 什么 图层
        
        // 可以播放 ： 添加 Layer到 图层 并添加 操作手势
//        layer.addSublayer(hr_player)
        
        
        
        
        
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    
    
    //MARK: ========== 构建播放资源 ===========
    /** Single line comment spreading
     * HenryGao
     * 写点说明。。。。。
     **/
    fileprivate func createVideo(aUrl : NSURL){
        let urlAsset = AVURLAsset(url: aUrl as URL)
        palyerItems = AVPlayerItem(asset: urlAsset)
        hr_layer = AVPlayer(playerItem: palyerItems)
        hr_player.player = hr_layer
        
        setOberver()
    }
    

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    //MARK:- ========== 播放器功能区 ==========
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
//        super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        
        if keyPath == "status" {
            var status = AVPlayerItemStatus.unknown;
            let statusNumber = change?[NSKeyValueChangeKey.newKey] as? NSNumber;
            
//            if (NSNumber.isSubclass(of: statusNumber as! NSNumber)) {
                status =  AVPlayerItemStatus(rawValue: (statusNumber?.intValue)!)! ;
//            }
            
            switch (status) {  // Switch over the status
            case AVPlayerItemStatus.readyToPlay:  // 添加 控制层 清除 加载层
                
                // 添加 Layer 播放
                layer.addSublayer(hr_player)
                hr_layer?.play();
                
                // 设置 显示的总时间
                CMTimeShow((palyerItems?.duration)!)
                let tempAllTime = HR_convertTime(aTime: (palyerItems?.duration)!)  // 总时间
                bringSubview(toFront: coustemView!)
                coustemView?.allTime.text = tempAllTime
                
                
            break;
            case AVPlayerItemStatus.failed:
                // Failed. Examine AVPlayerItem.error
//                _hr_PalyResults(@{@"error":_hr_playerItem.error});
//                [self HR_DissAnimation];
                // 错误 ： 展示 错误页面
//                [self addSubview:self.hr_notifView];
//                _hr_notifView.hr_msgLabel.text =  NSLocalizedString(@"HR_NotifView_VideoResErrorSmall", "");
//                _hr_notifView.state = HR_NotifViewError;
                
                break;
            case AVPlayerItemStatus.unknown:
//                _hr_PalyResults(@{@"error":_hr_playerItem.error});
//                [self HR_DissAnimation];
                // 错误 ： 展示 错误页面
//                [self addSubview:self.hr_notifView];
//                _hr_notifView.hr_msgLabel.text = NSLocalizedString(@"HR_NotifView_VideoUnKnow", "");
//                _hr_notifView.state = HR_NotifViewError;
            
                break;
            }
        }else if keyPath == "loadedTimeRanges" {
            
            // 缓冲时间
            let loadedTimeRanges = palyerItems?.loadedTimeRanges
            let timeRange =  loadedTimeRanges?.first?.timeRangeValue    // 获取已缓冲区域
            let durationSeconds = CMTimeGetSeconds((timeRange?.duration)!)
            
            // 总时间
            let duration = palyerItems?.duration
            let totalDuration = CMTimeGetSeconds(duration!)
            
//            缓冲进度：
            let progress = Float(durationSeconds / totalDuration)
            
            // 回掉 通知用户 加载进度
            self.hr_VideoDelegate?.HR_VideoDelegateLoadProgressInfo!(info: progress)
            
            // 设置 显示缓冲进度
            coustemView?.playProgress.progress = progress
            
            
            
            
        }
    }
    
    //MARK: ========== 播放到结束 ===========
    @objc private func moviePlayDidEnd(aNoF:NSNotification){
        hr_layer?.seek(to: kCMTimeZero, completionHandler:{_ in
            self.hr_layer?.play()
        })
    }
    
    
    
    //MARK:  ========== 暂停、播放、停止 ===========
    func HR_VideoControl(videoAction : HR_VideoControlState) {
        if hr_layer == nil { return }
        
        switch videoAction {
        case .Play:
            hr_layer?.play()
            break
        case .Pause:
            hr_layer?.pause()
            break
        case .Stop:
            hr_layer?.pause()
            hr_layer?.seek(to: kCMTimeZero, completionHandler: { _ in })
            break
            
        default:
            break
        }
    }
    //MARK:- ==========  快进、快退、亮度、声音 ===========
    enum HR_MOVEDIRECTION {     // 默认 识别的 手势 位置。（并不能说明 屏幕 方向）
        case None           // 默认（未识别）
        case Vertical       // 竖屏
        case Horizontal     // 横屏
    }
    fileprivate var firstPoint = CGPoint()
    fileprivate var moveSingeAdd = CGPoint()
    var isV = HR_MOVEDIRECTION.None         // 用来判断 操作 亮度、声音、进度
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        let touch = touches.first
        if touch?.view != self { return }

        firstPoint = (touch?.location(in: self))!
        moveSingeAdd = firstPoint;
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        
        let touch = touches.first
        if touch?.view != self { return };
        
        let endPoint = touch?.location(in: self)
        
        // 判断 移动
        var addMove = 0.0;
        if (isV == .None) {
            let changX = (endPoint?.x)! - firstPoint.x;
            let changY = (endPoint?.y)! - firstPoint.y;
            
            let tempX = changX > 0 ? changX : -changX;
            let tempY = changY > 0 ? changY : -changY;
            
            isV = tempX > tempY  ? .Horizontal: .Vertical;
            
        }else if (isV == .Horizontal){
            addMove = Double(endPoint!.x - moveSingeAdd.x);
            hr_layer?.pause()
            centerImg.image = (endPoint?.x)! - firstPoint.x > 0 ? #imageLiteral(resourceName: "qq") : #imageLiteral(resourceName: "dd")
            centerImg.isHidden = false
            changeVideoBrightnessAndVolumeAndProgressMoveDistance(aDistance: Float(endPoint!.x - firstPoint.x) ,aSingle:Float(addMove), whice: .None)     // 传递单次移动距离
        }else if(isV == .Vertical){
            addMove = Double(endPoint!.y - moveSingeAdd.y);
            changeVideoBrightnessAndVolumeAndProgressMoveDistance(aDistance: Float(endPoint!.y - firstPoint.y), aSingle: Float(addMove), whice: .None)// 传递单次移动距离
        }
        
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        if (isV == .Horizontal) {
            let touch = touches.first
            let endPoint = touch?.location(in: self)
            CMTimeShow(palyerItems!.currentTime());
            
            hr_layer?.seek(to: CMTimeAdd(palyerItems!.currentTime(),CMTimeMakeWithSeconds(Float64((endPoint!.x - firstPoint.x)/8), 1)), completionHandler: {_ in
                //在这里处理进度设置成功后的事情
                CMTimeShow(self.palyerItems!.currentTime());
                self.hr_layer?.play()
            })
        }
        centerImg.isHidden = true
        isV = .None;
    }
    
    func changeVideoBrightnessAndVolumeAndProgressMoveDistance(aDistance : Float , aSingle : Float , whice : HR_MOVEDIRECTION){
        
        if (isV == .Horizontal) {     // 横屏
            
        }else{
            centerImg.image = (firstPoint.x > self.frame.width / 2) ? #imageLiteral(resourceName: "vv") : #imageLiteral(resourceName: "ll")
            centerImg.isHidden = false
            //            he_MessageView.image = [UIImage imageNamed:(firstPoint.x > THISWIDTH / 2) ? @"vv" : @"ll"];
            //            he_MessageView.hidden = NO;
            if (firstPoint.x > self.frame.width / 2) {  // 右边 屏幕。音量
                //            volumeSlider.value = volumeSlider.value - aSingle / 8000;
            }else{  // 亮度
                UIScreen.main.brightness =  CGFloat(Float(UIScreen.main.brightness) - aSingle / 1000);
            }
            
        }
    }
    
    
    
    
    //MARK:-  ==========  全屏、还原 ===========
    var isFullVideo = false         // 默认 非全屏
    var oldFrame = CGRect()         // 记录久的Frame
    
    func HR_FullPlayerView(){       //  全屏
        
//        判断 视频是否是为空
        if palyerItems == nil {
            return
        }
        
        // 判断 当前的播放 状态。是不是 全屏
        if isFullVideo { // 是全屏 展示 不是全屏
            HR_backOldFrame()
            return;
        }
        
        // 记录 Frame
        oldFrame = self.frame;
        
        // 判断 视频的信息 长宽 比例 根据 比例 是否让 视频    并 旋转 执行 全屏 操作
        let videoSize = palyerItems?.presentationSize;
        
        if videoSize!.width > videoSize!.height {    // 宽长的 全屏时-》 横屏显示
            // 旋转 ：重新 设置 Frame：
            HR_ChangeFullWidth()
        
        }else{ // 直接改变 frame 为 竖屏 全屏
            HR_ChangeFullHeight()
        }
        
        // 改变 记录全屏
        isFullVideo = !isFullVideo;
    }
    fileprivate func HR_ChangeFullWidth() {
        UIView.animate(withDuration: 0.5, animations: { 
            self.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi / 2))
            self.frame = CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            if self.coustemView != nil {
//                print(frame)
                self.coustemView?.frame = CGRect(x: 0, y: 0, width: self.frame.height, height: self.frame.width);
            }
            
        }) { (resBool) in
            self.isFullVideo = true;
        }
    }
    fileprivate func HR_ChangeFullHeight() {
        UIView.animate(withDuration: 0.5, animations: {
            self.frame = CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        }) { (resBool) in
            self.isFullVideo = true;
        }
    }
    fileprivate func HR_backOldFrame() {    // 返回 yuanframeCGAffineTransformIdentity
        UIView.animate(withDuration: 0.5, animations: {
            self.transform = CGAffineTransform.identity
            self.frame = self.oldFrame
            self.coustemView?.frame = self.frame
            
        }) { (resBool) in
            self.isFullVideo = false
        }
    }
    
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        hr_player.bounds = layer.bounds;
    }
    
    
    
    
    
    
    
    
    //MARK:- ========== 数据处理区 ===========
    func HR_isURL(aURL : NSURL) -> Bool{
        
        let tempStr = String(describing: aURL)                  // 转换
        let str = "^((https|http|ftp|rtsp|mms)?:\\/\\/)[^\\s]+" // 正则
        
        var res = Bool()
        do {
            let temp =  try NSRegularExpression(pattern: str, options: .caseInsensitive)
            let matches = temp.matches(in: tempStr, options: .reportProgress, range: NSMakeRange(0, tempStr.characters.count))
            res = matches.count > 0 ? true : false
        } catch  {
            res = false
        }
        
        
        if !res {
            if (self.hr_VideoDelegate?.responds(to: #selector(hr_VideoDelegate?.HR_VideoDelegateResultsInfo(info:))))!{
                self.hr_VideoDelegate?.HR_VideoDelegateResultsInfo!(info: ["info":"Url 错误，请检查！"])
            }
        }
        
        return res
        
    }
    func HR_convertTime(aTime :CMTime ) -> String{ // 时间转换 为 字符串显示
        var totalSecond = 0.0;
        totalSecond = CMTimeGetSeconds(aTime);   // 获取 精准秒
    
        let dd = NSDate(timeIntervalSince1970: totalSecond)
        
        let formatter = DateFormatter()
        if  totalSecond/3600 >= 1 {
            formatter.dateFormat = "HH:mm:ss"
        } else {
            formatter.dateFormat = "mm:ss"
        }
        return formatter.string(from: dd as Date);
    }
    
    func getSystemVolumSlider() -> UISlider{
        var volmSlider : UISlider?
        
        if volmSlider == nil {
            let volumeView = MPVolumeView(frame: CGRect(x: 10, y: 50, width: 200, height: 4))
            for tempView in volumeView.subviews {
                if tempView.description == "MPVolumeSlider" {
                    volmSlider = tempView as? UISlider
                    break
                }
            }
        }
        
        return volmSlider!
    }
    
    
    
    
    
    
    
    //MARK:-  ========== 监听 ===========
    /** Single line comment spreading
     * HenryGao
     * 写点说明。。。。。 监听 播放、缓存
     **/
    fileprivate func dismissObserver(){
        
        if palyerItems != nil {
            palyerItems?.removeObserver(self, forKeyPath: "status")
            palyerItems?.removeObserver(self, forKeyPath: "loadedTimeRanges")
        }
        if  hr_layer != nil {
        }
    
    }
    fileprivate func setOberver(){
        // 结束监听 ----  Items
        palyerItems?.addObserver(self, forKeyPath: "status", options: .new, context: nil)
        palyerItems?.addObserver(self, forKeyPath: "loadedTimeRanges", options: .new, context: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(moviePlayDidEnd(aNoF:)), name: .AVPlayerItemDidPlayToEndTime, object: nil)
        
        // 控制 播放进度  ------ Palyer
        hr_layer?.addPeriodicTimeObserver(forInterval: CMTimeMake(Int64(1.0), Int32(1.0)), queue: DispatchQueue.main, using: {
            time in
            CMTimeShow(time)
            
            let tempcurrTime = self.HR_convertTime(aTime: time)   //设置 播放进度
            
            self.coustemView?.playTime.text = tempcurrTime
            self.coustemView?.playProgress.hr_progress.progress = Float(CMTimeGetSeconds(time) / CMTimeGetSeconds((self.palyerItems?.duration)!))
            
        })
        
        
    
    
    }
    
    
    
    
    
    
    
    
    
    

}



