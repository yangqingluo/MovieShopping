//
//  YYCenterLineView.swift
//  MovieSeat
//
//  Created by 7kers on 2018/11/4.
//  Copyright © 2018年 7kers. All rights reserved.
//

import UIKit

class YYCenterLineView: UIView {
    var centerLineBtn: UIButton?
    var zoomScale: CGFloat = 1.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        self.isUserInteractionEnabled = false
        self.initCenterLineBtn()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func initCenterLineBtn() {
//        let btn = UIButton(type: .custom)
//        btn.setTitle("银幕中央", for: .normal)
//        btn.titleLabel?.font = UIFont.systemFont(ofSize: 8)
//        btn.setTitleColor(UIColor.darkGray, for: .normal)
//        btn.isUserInteractionEnabled = false
//        btn.layer.masksToBounds = true
//        btn.layer.borderWidth = 0.5
//        btn.layer.cornerRadius = 2
//        btn.backgroundColor = UIColor.groupTableViewBackground
//        btn.layer.borderColor = UIColor.darkGray.cgColor
//        self.addSubview(btn)
//        self.centerLineBtn = btn
    }
    
    override func draw(_ rect: CGRect) {
//        // TODO: 用贝塞尔曲线直接画图的话会在缩放时略微虚化
////        UIColor.lightGray.setStroke()
////        var path = UIBezierPath()
////        path.lineWidth = 1
////        let lengths: [CGFloat] = [4, 2]
////        path.setLineDash(lengths, count: 2, phase: 0)
////        path.move(to: CGPoint(x: 0.5 * self.width, y: 0))
////        path.addLine(to: CGPoint(x: 0.5 * self.width, y: self.height + 5))
////        path.stroke()
////
////        let widthR:CGFloat = 60.0, heightR:CGFloat = 30.0
////        UIColor.red.setStroke()
////        let pathRect = UIEdgeInsetsInsetRect(CGRect.init(x: self.centerX - widthR, y: self.centerY - heightR, width: 2 * widthR, height: 2 * heightR),  UIEdgeInsetsMake(1, 1, 1, 1))
////        path = UIBezierPath(roundedRect: pathRect, cornerRadius: 1)
////        path.setLineDash(lengths, count: 2, phase: 0)
////        path.lineWidth = 0.1
////        path.stroke()
//
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        context.setLineWidth(1.0)
        context.setStrokeColor(UIColor.lightGray.cgColor)
        context.setLineDash(phase: 0, lengths: [6, 3])
        context.move(to: CGPoint(x: 0.5 * self.width, y: 0))
        context.addLine(to: CGPoint(x: 0.5 * self.width, y: self.height))
        context.strokePath()
        
//        context.setStrokeColor(UIColor.red.cgColor)
//        let widthR:CGFloat = 60.0 * zoomScale, heightR:CGFloat = 30.0 * zoomScale
//        let pathRect = UIEdgeInsetsInsetRect(CGRect.init(x: 0.5 * self.width - widthR, y: 0.5 * self.height - heightR, width: 2 * widthR, height: 2 * heightR),  UIEdgeInsetsMake(1, 1, 1, 1))
//        context.setLineDash(phase: 0, lengths: [2, 2])
//        context.setLineJoin(.round)
//        context.addRect(pathRect)
//        context.strokePath()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        centerLineBtn?.frame = CGRect(x: 0, y: -15, width: 50, height: 15)
        centerLineBtn?.centerX = 0.5 * self.width
    }
    
    override var frame: CGRect {
        didSet {
            self.setNeedsDisplay()
        }
    }
}
