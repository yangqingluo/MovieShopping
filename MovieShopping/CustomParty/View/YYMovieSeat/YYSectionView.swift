//
//  YYSectionView.swift
//  MovieShopping
//
//  Created by NAVER on 2018/11/16.
//  Copyright © 2018年 yang. All rights reserved.
//

import UIKit

typealias SectionBlock = (NSArray, String?) -> Void

class YYSectionView: UIView {
    lazy var baseView = UIScrollView(frame: .zero)
    var seatView: YYSectionSeatView!
    lazy var rowView = YYSectionRowView()
    lazy var centerLine = YYCenterLineView()
    lazy var hallLogo = YYHallNameView()
    lazy var indicator = YYIndicatorView()
    var data: YYSection!
    lazy var selecetedArray = NSMutableArray()
    var blockProperty: SectionBlock?
    
    @objc init(frame: CGRect, data: YYSection, actionBlock: @escaping SectionBlock) {
        super.init(frame: frame)
        self.data = data
        self.blockProperty = actionBlock
        initScrollView()
        initSeatsView()
        initRowIndexView()
        initCenterLine()
        initHallLogo()
        self.initIndicator()
        startAnimation()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @objc func removeSelection(_ seat: YYSectionSeat) {
        if self.data.seats.contains(seat) {
            let index = self.data.seats.index(of: seat)!
            guard let btn = self.seatView.viewWithTag(YYSeatTag + index) else {
                return
            }
            self.seatBtnAction(btn as! YYSingleSeatView)
        }
    }
    
    func initScrollView() {
        baseView.frame = self.bounds
        baseView.decelerationRate = UIScrollViewDecelerationRateFast
        baseView.delegate = self
        baseView.showsHorizontalScrollIndicator = false
        baseView.showsVerticalScrollIndicator = false
        baseView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(baseView)
    }
    
    func initSeatsView() {
        seatView = YYSectionSeatView(data: data, maxWidth: self.width, block: {[weak self](btn: YYSingleSeatView) -> () in
            self?.seatBtnAction(btn)
        })
        seatView?.frame = CGRect.init(x: 0, y: 0, width: (seatView?.viewWidth)!, height: (seatView?.viewHeight)!)
        baseView.insertSubview(seatView!, at: 0)
        baseView.maximumZoomScale = YYSeatMaxW_H / (seatView?.btnWidth)!
        baseView.contentInset = UIEdgeInsetsMake(YYSeatsColMargin, 0.5 * (self.width - (seatView?.viewWidth)!), YYSeatsColMargin, 0.5 * (self.width - (seatView?.viewWidth)!))
    }
    
    func initRowIndexView() {
        rowView.width = 13.0
        rowView.height = seatView.height + 2.0 * YYSmallMargin
        rowView.top = -YYSmallMargin
        rowView.left = baseView.contentOffset.x + YYSeatMinW_H
        rowView.maxRow = seatView.maxRow
        rowView.rowData = seatView.rowData
        baseView.addSubview(rowView)
    }
    
    func initCenterLine() {
        centerLine.frame = CGRect.init(x: 0, y: -YYSmallMargin, width: seatView.width, height: seatView.height + 2 * YYSmallMargin)
        baseView.addSubview(centerLine)
    }
    
    func initHallLogo() {
        hallLogo.name = data.hall_name
        hallLogo.width = YYHallLogoW
        hallLogo.height = 20.0
        hallLogo.centerX = seatView.centerX
        hallLogo.top = baseView.contentOffset.y
        baseView.addSubview(hallLogo)
    }
    
    func initIndicator() {
        let maxWidth = 0.5 * seatView.width;
        let maxHeight = 0.5 * seatView.height;
        let ratio = seatView.width / maxWidth;
        
        let frame = CGRect(x: 3.0, y: 3 * 3.0, width: maxWidth, height: maxHeight)
        indicator = YYIndicatorView(frame, map: seatView, ratio: ratio, scrollview: baseView)
        self.addSubview(indicator)
    }
    
    func zoomRectInView(view: UIView, scale: CGFloat, center: CGPoint) -> CGRect {
        let width = view.width / scale
        let height = view.height / scale
        let zoomRect = CGRect(x: center.x - width * 0.5, y: center.y - height * 0.5, width: width, height: height)
        return zoomRect;
    }
    
    func startAnimation() {
        UIView.animate(withDuration: 0.5, delay: 0.2, options: .curveEaseOut, animations: {[weak self]() in
            let zoomRect = self?.zoomRectInView(view: (self?.baseView)!, scale: YYSeatNomarW_H / (self?.seatView?.btnHeight)!, center: CGPoint(x: 0.5 * (self?.seatView?.viewWidth)!, y: 0))
            self?.baseView.zoom(to: zoomRect!, animated: false)
            }, completion:nil)
    }
    
    func seatBtnAction(_ btn: YYSingleSeatView) -> Void {
        var errorStr: String?
        let seat = self.data.seats[btn.tag - YYSeatTag]
        if seat.status == 1 {
            if btn.isSelected {
                btn.isSelected = false
                if self.selecetedArray.contains(seat) {
                    self.selecetedArray.remove(seat)
                }
            }
            else {
                if self.selecetedArray.count >= self.data.maxCanBuy {
                    errorStr = "最多可选择\(self.data.maxCanBuy)个座位"
                }
                else {
                    btn.isSelected = true
                    self.selecetedArray.add(seat)
                }
            }
        }
        self.indicator.updateMiniImageView()
        self.cancelIndicatorHidden()
        self.goOnIndicatorHidden()
        self.blockProperty?(self.selecetedArray, errorStr)
        if self.baseView.maximumZoomScale - self.baseView.zoomScale < 0.1 {
            return
        }
        let maximumZoomScale = self.baseView.maximumZoomScale
        let zoomRect = self.zoomRectInView(view: self.baseView, scale: maximumZoomScale, center: btn.center)
        self.baseView.zoom(to: zoomRect, animated: true)
    }
    
    func cancelIndicatorHidden() {
        object_getClass(self)?.cancelPreviousPerformRequests(withTarget: self.indicator, selector: #selector(YYIndicatorView.indicatorHidden), object: nil)
    }
    
    func goOnIndicatorHidden() {
        if (!indicator.isHidden || baseView.isZoomBouncing) {
            
        }
        else {
            indicator.alpha = 1;
            indicator.isHidden = false
        }
        indicator.perform(#selector(YYIndicatorView.indicatorHidden), with: nil, afterDelay: 2.0)
    }
}

// MARK: UIScrollViewDelegate
extension YYSectionView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 更新索引条
        rowView.left = scrollView.contentOffset.x + YYSeatMinW_H
        
        //更新hallLogo
        hallLogo.top = scrollView.contentOffset.y;
        
        //更新indicator大小位置
        indicator.updateMiniIndicator()
        self.goOnIndicatorHidden()
        
        scrollView.setNeedsDisplay()
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.seatView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        self.cancelIndicatorHidden()
        rowView.height = seatView.height + 2 * YYSmallMargin
        centerLine.zoomScale = scrollView.zoomScale
        centerLine.frame = CGRect.init(x: 0, y: -YYSmallMargin, width: seatView.width, height: seatView.height + 2 * YYSmallMargin)
        hallLogo.centerX = seatView.centerX
        indicator.updateMiniIndicator()
        scrollView.setNeedsDisplay()
        self.scrollViewDidEndDecelerating(scrollView)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if (!decelerate) {
            self.scrollViewDidEndDecelerating(scrollView)
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.cancelIndicatorHidden()
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.goOnIndicatorHidden()
    }
}
