//
//  GifImagesHeaderFooter.swift
//  SYRefreshExampleforSwift
//
//  Created by shusy on 2017/6/12.
//  Copyright © 2017年 SYRefresh. All rights reserved.
//

import UIKit

public class GifImagesHeaderFooter: RefreshView {
    private let imageView  = UIImageView(frame: .zero)
    var images =  Dictionary<SYRefreshViewState, Array<UIImage>>()
    var durations =  Dictionary<SYRefreshViewState, Double >()
    /// 创建一个GIF图片数组刷新控件
    /// - Parameters:
    ///   - orientation: 刷新控件的方向
    ///   - height: 刷新控件的高度
    ///   - contentMode: gif图片显示模式
    ///   - completion: 开始刷新之后回调
    public init(orientation:RefreshViewOrientation,height:CGFloat,contentMode:UIViewContentMode,completion:@escaping ()->Void){
        super.init(orientaton: orientation, height: height, completion: completion)
        addSubview(imageView)
        imageView.contentMode = contentMode
        imageView.clipsToBounds = true
    }
    
    /// 设置控件刷新状态
    ///
    /// - Parameters:
    ///   - state: 状态值
    ///   - images: 图片数组
     public func setRefreshState(state:SYRefreshViewState = .stateIdle,images:Array<UIImage>){
         setRefreshState(state: state, images: images, duration: Double(images.count)*0.1)
    }
    
    
    /// 设置控件刷新状态
    ///
    /// - Parameters:
    ///   - state: 状态值
    ///   - images: 图片数组
    ///   - duration: 动画时间
    public func setRefreshState(state:SYRefreshViewState = .stateIdle,images:Array<UIImage>,duration:TimeInterval){
        self.images[state] = images
        self.durations[state] = duration
    }
    
    override public func updateRefreshState(isRefreshing: Bool) {
    }
    /// 设置状态值
    /// - Parameter state: 状态值
    override func setState(state: SYRefreshViewState) {
        if state == .pulling || state == .refreshing {
            let images = self.images[state];
            var duration = 0.0
            if self.durations[state] != nil {
                duration = self.durations[state]!
            }else{
                duration = 2.5
            }
            if (images?.count==1) {
                imageView.image = images?.first;
            }else{
                imageView.animationImages = images
                imageView.animationDuration = duration
                imageView.animationRepeatCount = .max
                imageView.startAnimating()
            }
        }
    }
    
    /// 更新拖动的比例
    ///
    /// - Parameter progress: 0 - 1
    override public func updatePullProgress(progress: CGFloat) {
        if self.images.count == 0  { return }
        if self.durations.count == 0  { return }
        if (self.images.count>0) {
            let images = self.images[.stateIdle];
            if images?.count == 0 { return }
            if (self.state != .stateIdle || images?.count == 0) {return}
            imageView.stopAnimating()
            var index =  Int(CGFloat((images?.count)!) * progress)
            if (index >= (images?.count)!) { index = (images?.count)! - 1}
            imageView.image = images?[index];
        }
    }
    
    /// 布局控件位置
    override public func layoutSubviews() {
        super.layoutSubviews()
        var imageSize:CGSize = CGSize.zero
        if self.images.count > 0 {
            imageSize = (self.images[.stateIdle]?.first?.size)!
        }else{
            imageSize = CGSize(width: 40, height: 40)
        }
        imageView.frame.size = CGSize(width: imageSize.width, height: imageSize.height)
        imageView.center = CGPoint(x: bounds.midX, y: bounds.midY)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
