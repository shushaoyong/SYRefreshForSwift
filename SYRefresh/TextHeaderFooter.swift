//
//  RefreshTextHeader.swift
//  SYRefreshExample_swift
//
//  Created by shusy on 2017/6/8.
//  Copyright © 2017年 SYRefresh. All rights reserved.
//  代码地址: https://github.com/shushaoyong/SYRefreshForSwift

import UIKit

class TextHeaderFooter: RefreshView {
    private var accessoryView:AccessoryView //辅助试图
    private var textItem:TextItem //文本视图
    /// 创建一个刷新控件
    /// - Parameters:
    ///   - normalText: 默认状态提示文字
    ///   - pullingText: 拖拽到临界点松开即可刷新状态提示文字
    ///   - refreshingText: 刷新状态提示文字
    ///   - orientation: 刷新控件的方向
    ///   - height: 刷新控件的高度
    ///   - font:   提示文字字体
    ///   - color:  提示文字颜色
    ///   - completion: 开始刷新之后回调
    init(normalText:String,pullingText:String,refreshingText:String,orientation:RefreshViewOrientation,height:CGFloat,font:UIFont,color:UIColor,completion: @escaping ()->Void){
        self.accessoryView = AccessoryView(color: color)
        self.textItem = TextItem(normalText: normalText, pullingText: pullingText, refreshingText: refreshingText, font: font, color: color)
        super.init(orientaton: orientation, height: height, completion: completion)
        self.accessoryView.isLeftOrRightOrientation = self.isLeftOrRightOrientation() //传递刷新的方向
        layer.addSublayer(accessoryView.arrowLayer())
        addSubview(accessoryView.indicatorView)
        addSubview(textItem.label)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateRefreshState(isRefreshing: Bool) {
        accessoryView.updateRefreshState(isRefreshing: isRefreshing)
        textItem.updateRefreshState(isRefreshing: isRefreshing)
    }
    
    override func updatePullProgress(progress: CGFloat) {
        accessoryView.updatePullProgress(progress: progress, isFooter: isFooter)
        textItem.updatePullProgress(progress: progress)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        var contentW = bounds.width
        if  superview?.superview != nil {
            if (superview?.isKind(of: UIScrollView.self))! {
                contentW = (superview?.superview?.bounds.width)!
            }
        }
        var point = CGPoint(x: (contentW - textItem.label.bounds.width*0.65-8)*0.5, y: bounds.midY)
        var indicatorViewPoint = CGPoint(x: point.x-8, y: point.y)
        var labelCenter = CGPoint(x: (contentW+textItem.label.bounds.width*0.5+8)*0.5, y: bounds.midY)
        
        if isLeftOrRightOrientation() { //如果是水平刷新
            point = CGPoint(x: bounds.midX, y: bounds.midY-bounds.width*0.5)
            indicatorViewPoint = CGPoint(x: point.x, y: point.y)
            labelCenter = CGPoint(x: bounds.midX, y: bounds.midY)
        }
        UIView.performWithoutAnimation {
            accessoryView.arrowLayer().position = point
            accessoryView.indicatorView.center = indicatorViewPoint
            textItem.label.center = labelCenter
        }
    }

}