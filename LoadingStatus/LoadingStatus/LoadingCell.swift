//
//  LoadingCell.swift
//  LoadingStatus
//
//  Created by zhi zhou on 2017/2/3.
//  Copyright © 2017年 zhi zhou. All rights reserved.
//

import UIKit

class LoadingCell: UITableViewCell {
    // MARK:- 属性
    /// cell frame
    fileprivate var cellFrame: CGRect?
    /// basic view
    fileprivate let basicView = UIView()
    /// loading view
    fileprivate let loadingView = UIImageView()
    
    // MARK:- 系统函数
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override var frame: CGRect {
        didSet {
            var newFrame = frame
            newFrame.size.height -= 10
            super.frame = newFrame
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor(red: 239/255.0, green: 239/255.0, blue: 239/255.0, alpha: 1.0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        cellFrame = CGRect(x: self.bounds.origin.x, y: self.bounds.origin.y, width: self.bounds.width, height: self.bounds.height)
        
        indicatorAnimate()
        
        basicView.frame = cellFrame!
        basicView.backgroundColor = .white
        self.addSubview(basicView)
        
        hollowOut()
    }

    // MARK:- 界面函数
    /// 镂空
    fileprivate func hollowOut() {
        let path = UIBezierPath(rect: cellFrame!)
        
        // 头像尺寸（正方形）
        let portraitSize: CGFloat = 38
        // 圆形 Path
        let circularPath = UIBezierPath(arcCenter: CGPoint(x: 10 + portraitSize * 0.5, y: 10 + portraitSize * 0.5), radius: portraitSize * 0.5, startAngle: 0, endAngle: CGFloat(M_PI) * 2, clockwise: false)
        path.append(circularPath)
        
        // 高度
        let rectanglePathHeight: CGFloat = 16
        
        // 昵称 Path
        let nickNameRect = CGRect(x: circularPath.bounds.maxX + 8, y: circularPath.bounds.midY - rectanglePathHeight * 0.5, width: 66, height: rectanglePathHeight)
        _ = createRectanglePath(path: path, rect: nickNameRect)
        
        // 内容区域 Path
        let firstLineRect = CGRect(x: circularPath.bounds.origin.x, y: circularPath.bounds.maxY + 10, width: self.bounds.width - circularPath.bounds.origin.x * 2, height: rectanglePathHeight)
        let firstLinePath = createRectanglePath(path: path, rect: firstLineRect)
        
        let secondLineRect = CGRect(x: firstLinePath.bounds.origin.x, y: firstLinePath.bounds.maxY + 8, width: firstLinePath.bounds.width * 2 / 3, height: rectanglePathHeight)
        let secondLinePath = createRectanglePath(path: path, rect: secondLineRect)
        
        let thirdLineRect = CGRect(x: secondLinePath.bounds.origin.x, y: secondLinePath.bounds.maxY + 8, width: firstLinePath.bounds.width * 0.5, height: rectanglePathHeight)
        _ = createRectanglePath(path: path, rect: thirdLineRect)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        basicView.layer.mask = shapeLayer
    }
    
    /// 创建长方形 Path
    fileprivate func createRectanglePath(path: UIBezierPath, rect: CGRect) -> UIBezierPath {
        let rectanglePath = UIBezierPath(rect: rect).reversing()
        path.append(rectanglePath)
        
        return rectanglePath
    }
    
    /// 过渡动画
    fileprivate func indicatorAnimate() {
        loadingView.frame = cellFrame!
        loadingView.image = UIImage(named: "Loading")
        self.addSubview(loadingView)
        
        DispatchQueue.global().async {
            let width = self.bounds.width
            let indicatorAnimate = CABasicAnimation(keyPath: "position")
            indicatorAnimate.fromValue = NSValue(cgPoint: CGPoint(x: -width, y: (self.loadingView.bounds.height) * 0.5))
            indicatorAnimate.toValue = NSValue(cgPoint: CGPoint(x: width * 2, y: (self.loadingView.bounds.height) * 0.5))
            indicatorAnimate.duration = 1.0
            indicatorAnimate.repeatCount = MAXFLOAT
            indicatorAnimate.isRemovedOnCompletion = false
            
            self.loadingView.layer.add(indicatorAnimate, forKey: nil)
        }
    }
    
}
