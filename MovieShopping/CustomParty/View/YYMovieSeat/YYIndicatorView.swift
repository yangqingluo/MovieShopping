//
//  YYIndicatorView.swift
//  MovieSeat
//
//  Created by 7kers on 2018/11/4.
//  Copyright © 2018年 7kers. All rights reserved.
//

import UIKit

class YYIndicatorView: UIView {
    var viewRatio: CGFloat = 0.0
    lazy var miniMe = UIView()
    var mapView: UIView!
    lazy var miniIndicator = UIView()
    var miniImageView: UIImageView?
    lazy var logoImageView = UIImageView(image: UIImage(named: "screenBg"))
    var myScrollview: UIScrollView!
    
    init() {
        super.init(frame: .zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(_ frame: CGRect, map: UIView, ratio: CGFloat, scrollview: UIScrollView) {
        super.init(frame: frame)
        self.viewRatio = ratio
        self.mapView = map
        self.myScrollview = scrollview
        self.isUserInteractionEnabled = false
    }
    
    override func didMoveToSuperview() {
        self.initUI()
    }
    
    func initUI() -> () {
        self.addSubview(miniMe)
        miniMe.backgroundColor = UIColor.init(white: 0.0, alpha: 0.4)
        miniMe.addSubview(logoImageView)
        
        let miniImageView = UIImageView(image:self.captureScreen(viewToCapture: self.mapView))
        miniImageView.backgroundColor = UIColor.clear
        self.miniImageView = miniImageView
        self.addSubview(miniImageView)
        
        miniIndicator.layer.borderWidth = 1;
        miniIndicator.layer.borderColor = UIColor.red.cgColor
        self.addSubview(miniIndicator)
    }
    
    func updateMiniIndicator() {
        self.setNeedsLayout()
    }
    
    @objc func updateMiniImageView() {
        self.miniImageView?.image = self.captureScreen(viewToCapture: self.mapView)
    }
    
    func captureScreen(viewToCapture: UIView?) -> UIImage? {
        let rect = viewToCapture?.bounds
        UIGraphicsBeginImageContextWithOptions((rect?.size)!, false, 0.0)
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        viewToCapture?.layer.render(in: context)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    @objc func indicatorHidden() {
        UIView.animate(withDuration: 0.25, animations: {[weak self]()  -> Void in
            self?.alpha = 0.5
        }, completion: {[weak self](finished: Bool) -> Void in
            self?.isHidden = true
        })
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.miniMe.frame = CGRect(x: -3, y: -3 * 3, width: self.width  + 2 * 3, height: self.height + 4 * 3)
        self.logoImageView.frame = CGRect(x: 2 * 3, y: 3, width: self.width - 4 * 3, height: 3)
        self.miniImageView?.frame = self.bounds
        
        //TODO: 座位数较少时定位不够精确
        self.miniIndicator.left = (self.myScrollview.contentOffset.x * self.width)  / self.myScrollview.contentSize.width
        self.miniIndicator.top = (self.myScrollview.contentOffset.y * self.height) / self.myScrollview.contentSize.height;

        if (self.miniIndicator.height == self.height && self.miniIndicator.width == self.width) {
            self.miniIndicator.left = 0;
            self.miniIndicator.top = 0;
        }
        
        if (self.mapView.width < self.myScrollview.width) {
            self.miniIndicator.left = 0;
            self.miniIndicator.width = self.width;
        }
        else {
            self.miniIndicator.width = (self.width * (self.myScrollview.width - self.myScrollview.contentInset.right) /  self.mapView.width);
            if (self.myScrollview.contentOffset.x < 0) {
                self.miniIndicator.width =  self.miniIndicator.width - abs(self.myScrollview.contentOffset.x * self.width)  / self.myScrollview.contentSize.width;
                self.miniIndicator.left = 0;
            }
            if (self.myScrollview.contentOffset.x > self.myScrollview.contentSize.width - YYScreenW + self.myScrollview.contentInset.right) {
                self.miniIndicator.width =  self.miniIndicator.width - (self.myScrollview.contentOffset.x - (self.myScrollview.contentSize.width - YYScreenW + self.myScrollview.contentInset.right)) * self.width  / self.myScrollview.contentSize.width;
            }
        }

        if (self.mapView.height <= self.myScrollview.height - YYSeatsColMargin) {
            self.miniIndicator.top = 0;
            self.miniIndicator.height = self.height;
        }
        else {
            self.miniIndicator.height = self.height *  (self.myScrollview.height - YYSeatsColMargin) /  self.mapView.height;
            if (self.myScrollview.contentOffset.y < 0) {
                self.miniIndicator.top = 0;
                self.miniIndicator.height =  self.miniIndicator.height - abs(self.myScrollview.contentOffset.y *  self.height) /  self.myScrollview.contentSize.height;
            }
            if (self.myScrollview.contentOffset.y > self.mapView.height - self.myScrollview.height + YYSeatsColMargin) {
                self.miniIndicator.height =  self.miniIndicator.height  - (self.myScrollview.contentOffset.y -  (self.mapView.height - self.myScrollview.height +  YYSeatsColMargin)) * self.height /  self.myScrollview.contentSize.height;
            }
        }
    }
}
