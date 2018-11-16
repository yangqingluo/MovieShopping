//
//  YYSingleSeatView.swift
//  MovieShopping
//
//  Created by NAVER on 2018/11/16.
//  Copyright © 2018年 yang. All rights reserved.
//

import UIKit

let YYScreenW = UIScreen.main.bounds.size.width //屏幕宽
let YYScreenH = UIScreen.main.bounds.size.height //屏幕高
let YYSeatsColMargin:CGFloat = 60.0 //座位图离上部分距离
let YYSeatsRowMargin:CGFloat = 40 //座位图离两边距离
let YYCenterLineY:CGFloat = 50 //中线离上部分距离
let YYSeatMinW_H:CGFloat = 10 //座位按钮最小宽高
let YYSeatNomarW_H:CGFloat = 30 //座位按钮默认开场动画宽高
let YYSeatMaxW_H:CGFloat = 40 //座位按钮最大宽高
let YYSmallMargin:CGFloat = 10 //默认最小间距
let YYLogoW:CGFloat = 100 //logo的宽度
let YYHallLogoW:CGFloat = 200 //halllogo的宽度
let YYSeatBtnScale:CGFloat = 0.85 //按钮内图标占按钮大小的比例
let YYMaxSelectedSeatsCount = 4 //限制最大选座数量
let YYSeatPx: CGFloat = 30.0
let YYSeatTag: Int = 1000

class YYSingleSeatView: UIView {
    lazy var imageView = UIImageView()
    
    open var isSelected: Bool = false {
        didSet {
            imageView.isHighlighted = isSelected
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let btnScale = YYSeatBtnScale;
        let btnW = self.width * btnScale;
        let btnH = self.height * btnScale;
        self.imageView.frame = CGRect(x: 0, y: 0, width:btnW, height:btnH)
        self.imageView.center = CGPoint(x: 0.5 * self.width, y: 0.5 * self.height)
    }

    func setImage(_ image: UIImage?, for state: UIControlState) {
        switch state {
        case .normal:
            imageView.image = image
        default:
            imageView.highlightedImage = image
        }
    }
}
