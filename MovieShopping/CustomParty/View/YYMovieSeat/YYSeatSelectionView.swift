//
//  YYSeatSelectionView.swift
//  MovieSeat
//
//  Created by 7kers on 2018/11/4.
//  Copyright © 2018年 7kers. All rights reserved.
//

import UIKit

typealias SelectionBlock = (NSArray, NSDictionary, String?) -> Void

class YYSeatSelectionView: UIView {
    var seatScrollView = UIScrollView(frame: .zero)
    lazy var selecetedSeats = NSMutableArray()
    var seatView: YYSeatView!
    lazy var hallLogo = YYHallNameView()
    lazy var centerLine = YYCenterLineView()
    lazy var rowindexView = YYRowIndexView()
    lazy var logoView = UIImageView(image: UIImage(named: "yy_logo"))
    lazy var indicator = YYIndicatorView()
    var blockProperty: SelectionBlock?
    
    @objc init(frame: CGRect, seatsArray: NSArray, hallName: String, actionBlock: @escaping SelectionBlock) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(red: 245.0/255.0, green: 245.0/255.0, blue: 245.0/255.0, alpha: 1.0)
        self.blockProperty = actionBlock
        self.initScrollView()
        self.initLogo()
        self.initSeatsView(seatsArray)
        self.initIndicator(seatsArray)
        self.initRowIndexView(seatsArray)
        self.initCenterLine(seatsArray)
        self.initHallLogo(hallName)
        self.startAnimation()//开场动画
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startAnimation() {
        UIView.animate(withDuration: 0.5, delay: 0.2, options: .curveEaseOut, animations: {[weak self]() in
            let zoomRect = self?.zoomRectInView(view: (self?.seatScrollView)!, scale: YYSeatNomarW_H / (self?.seatView?.btnHeight)!, center: CGPoint(x: 0.5 * (self?.seatView?.viewWidth)!, y: 0))
            self?.seatScrollView.zoom(to: zoomRect!, animated: false)
        }, completion:nil)
    }
    
    func initScrollView() {
        seatScrollView.frame = self.bounds
        seatScrollView.decelerationRate = UIScrollViewDecelerationRateFast
        seatScrollView.delegate = self
        seatScrollView.showsHorizontalScrollIndicator = false
        seatScrollView.showsVerticalScrollIndicator = false
        seatScrollView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(seatScrollView)
    }
    
    func initLogo() {
        logoView.backgroundColor = UIColor.groupTableViewBackground
        logoView.top = self.height - YYSeatsRowMargin
        logoView.width = YYLogoW
        logoView.height = YYSeatsRowMargin
        logoView.centerX = self.width * 0.5
        self.seatScrollView.insertSubview(logoView, at: 0)
    }
    
    func initRowIndexView(_ seatsArray: NSArray) {
        rowindexView.indexsArray = seatsArray
        rowindexView.width = 13.0
        rowindexView.height = (self.seatView?.height)! + 2.0 * YYSmallMargin
        rowindexView.top = -YYSmallMargin
        rowindexView.left = self.seatScrollView.contentOffset.x + YYSeatMinW_H
        self.seatScrollView.addSubview(rowindexView)
    }
    
    func initCenterLine(_ seatsArray: NSArray) {
        centerLine.frame = (self.seatView?.bounds)!
        self.seatScrollView.addSubview(centerLine)
    }
    
    func initHallLogo(_ name: String) {
        hallLogo.name = name
        hallLogo.width = YYHallLogoW
        hallLogo.height = 20.0
        hallLogo.centerX = (self.seatView?.centerX)!
        hallLogo.top = self.seatScrollView.contentOffset.y
        self.seatScrollView.addSubview(hallLogo)
    }
    
    func initIndicator(_ seatsArray: NSArray) {
        var ratio:CGFloat = 2.0
        let seats = seatsArray.firstObject as! YYSeats
        var count = seats.columns.count
        if count % 2 == 0 {
            count += 1
        }
        let miniMeIndicatorMaxHeight = self.height / 6.0
        var maxWidth = (self.width - 2 * YYSeatsRowMargin) * 0.5
        var currentMiniBtnW_H = maxWidth / CGFloat(count)
        var maxHeight = currentMiniBtnW_H * CGFloat(seatsArray.count)

        if (maxHeight >= miniMeIndicatorMaxHeight ) {
            currentMiniBtnW_H = miniMeIndicatorMaxHeight / CGFloat(seatsArray.count)
            maxWidth = currentMiniBtnW_H * CGFloat(count)
            maxHeight = miniMeIndicatorMaxHeight
            ratio = (self.width - 2 * YYSeatsRowMargin) / maxWidth
        }

        let frame = CGRect(x: 3.0, y: 3 * 3.0, width: maxWidth, height: maxHeight)
        indicator = YYIndicatorView(frame, map: self.seatView, ratio: ratio, scrollview: self.seatScrollView)
        self.addSubview(indicator)
    }
    
    func initSeatsView(_ seatsArray: NSArray) {
        seatView = YYSeatView(seatsArray: seatsArray, maxNomarWidth: self.width, block: {[weak self](btn : YYSeatButton, dic: NSMutableDictionary) -> () in
            self?.indicator.updateMiniImageView()
            var errorStr: String?
            if btn.isSelected {
                self?.selecetedSeats.add(btn)
                if (self?.selecetedSeats.count)! > YYMaxSelectedSeatsCount {
                    btn.isSelected = !btn.isSelected
                    self?.selecetedSeats.remove(btn)
                    errorStr = YYExceededMaximumError
                    self?.indicator.updateMiniImageView()
                }
            }
            else {
                if (self?.selecetedSeats.contains(btn))! {
                    self?.selecetedSeats.remove(btn)
                }
            }
            if self?.blockProperty != nil {
                self?.blockProperty?((self?.selecetedSeats)!, dic, errorStr)
            }
            if (self?.seatScrollView.maximumZoomScale)! - (self?.seatScrollView.zoomScale)! < 0.1 {
                return
            }
            let maximumZoomScale = self?.seatScrollView.maximumZoomScale;
            let zoomRect = self?.zoomRectInView(view: (self?.seatScrollView)!, scale: maximumZoomScale!, center: btn.center)
            self?.seatScrollView.zoom(to: zoomRect!, animated: true)
        })
        seatView?.frame = CGRect.init(x: 0, y: 0, width: (seatView?.viewWidth)!, height: (seatView?.viewHeight)!)
        seatScrollView.insertSubview(seatView!, at: 0)
        seatScrollView.maximumZoomScale = YYSeatMaxW_H / (seatView?.btnWidth)!
        seatScrollView.contentInset = UIEdgeInsetsMake(YYSeatsColMargin, 0.5 * (self.width - (seatView?.viewWidth)!), YYSeatsColMargin, 0.5 * (self.width - (seatView?.viewWidth)!))
    }

    func zoomRectInView(view: UIView, scale: CGFloat, center: CGPoint) -> CGRect {
        let width = view.width / scale
        let height = view.height / scale
        let zoomRect = CGRect(x: center.x - width * 0.5, y: center.y - height * 0.5, width: width, height: height)
        return zoomRect;
    }
    
    func cancelIndicator() {
        object_getClass(self)?.cancelPreviousPerformRequests(withTarget: self.indicator, selector: #selector(YYIndicatorView.indicatorHidden), object: nil)
    }
}

// MARK: UIScrollViewDelegate
extension YYSeatSelectionView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 更新logo
        if (scrollView.contentOffset.y <= scrollView.contentSize.height - self.height + YYSeatsColMargin + 15) {
            self.logoView.top = (self.seatView?.frame.maxY)! + 35.0
            self.logoView.centerX = (self.seatView?.centerX)!
        }
        else {
            self.logoView.top = scrollView.contentOffset.y + self.height - self.logoView.height
            self.logoView.centerX = (self.seatView?.centerX)!
        }
        
        //更新hallLogo
        self.hallLogo.top = scrollView.contentOffset.y;

        //更新中线
//        self.centerLine.height = (self.seatView?.frame.maxY)! + 2 * YYSmallMargin;
//
//        if (scrollView.contentOffset.y < -YYSeatsColMargin ) {
//            self.centerLine.top = (self.seatView?.top)! - YYSeatsColMargin + YYCenterLineY;
//        }
//        else {
//            self.centerLine.top = scrollView.contentOffset.y + YYCenterLineY;
//            self.centerLine.height = (self.seatView?.frame.maxY)! - scrollView.contentOffset.y - 2 * YYCenterLineY + YYSeatsColMargin;
//        }
        
        // 更新索引条
        self.rowindexView.left = scrollView.contentOffset.x + YYSeatMinW_H;

        //更新indicator大小位置
        self.indicator.updateMiniIndicator()
        if (!self.indicator.isHidden || self.seatScrollView.isZoomBouncing) {
            
        }
        else {
            self.indicator.alpha = 1;
            self.indicator.isHidden = false
        }
        scrollView.setNeedsDisplay()
    }

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.seatView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        self.cancelIndicator()
        self.centerLine.zoomScale = scrollView.zoomScale
        self.centerLine.width = (self.seatView?.width)!
        self.centerLine.height = (self.seatView?.height)!
        self.rowindexView.height = (self.seatView?.height)! + 2 * YYSmallMargin
        self.hallLogo.centerX = (self.seatView?.centerX)!
        self.logoView.centerX = (self.seatView?.centerX)!
        self.indicator.updateMiniIndicator()
        scrollView.setNeedsDisplay()
        self.scrollViewDidEndDecelerating(scrollView)
    }
    
//    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
//        self.hallLogo.centerX = (self.seatView?.centerX)!
//        self.hallLogo.top = scrollView.contentOffset.y
//        self.centerLine.centerX = (self.seatView?.centerX)!
//        self.centerLine.top = scrollView.contentOffset.y + YYCenterLineY
//        self.logoView.centerX = (self.seatView?.centerX)!
//        self.indicator.updateMiniIndicator()
//        self.scrollViewDidEndDecelerating(scrollView)
//    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if (!decelerate) {
            self.scrollViewDidEndDecelerating(scrollView)
        }
    }

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.cancelIndicator()
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.indicator.perform(#selector(YYIndicatorView.indicatorHidden), with: nil, afterDelay: 2.0)
    }
}
