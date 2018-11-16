//
//  YYSingleSeatView.swift
//  MovieShopping
//
//  Created by NAVER on 2018/11/16.
//  Copyright © 2018年 yang. All rights reserved.
//

import UIKit

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
