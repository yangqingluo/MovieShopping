//
//  YYSeatButton.swift
//  MovieSeat
//
//  Created by 7kers on 2018/11/4.
//  Copyright © 2018年 7kers. All rights reserved.
//

import UIKit

let YYScreenW = UIScreen.main.bounds.size.width //屏幕宽
let YYScreenH = UIScreen.main.bounds.size.height //屏幕高
let YYSeatsColMargin:CGFloat = 60.0 //座位图离上部分距离
let YYSeatsRowMargin:CGFloat = 40 //座位图离两边距离
let YYCenterLineY:CGFloat = 50 //中线离上部分距离
let YYSeatMinW_H:CGFloat = 10 //座位按钮最小宽高
let YYSeatNomarW_H:CGFloat = 25 //座位按钮默认开场动画宽高
let YYSeatMaxW_H:CGFloat = 40 //座位按钮最大宽高
let YYSmallMargin:CGFloat = 10 //默认最小间距
let YYLogoW:CGFloat = 100 //logo的宽度
let YYHallLogoW:CGFloat = 200 //halllogo的宽度
let YYSeatBtnScale:CGFloat = 0.85 //按钮内图标占按钮大小的比例
let YYMaxSelectedSeatsCount = 4 //限制最大选座数量
let YYExceededMaximumError = "选择座位已达到上限"//提示选择座位超过要求的上限

//func ==(p0:YYSeat, p1:YYSeat)->Bool{
//    return p0.columnId == p1.columnId && p0.seatNo == p1.seatNo && p0.st == p1.st
//}

class YYSeatButton: UIView {
    lazy var seat = YYSeat()
    lazy var seats = YYSeats()
    lazy var imageView = UIImageView()
    var index: Int = 0 //座位绑定索引，用于判断独坐
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
    
    public var isSeatAvailable: Bool {
        get { return self.seat.st == "N" }
    }
    
//    override var isHighlighted: Bool {
//        set {
//
//        }
//        get {
//            return false
//        }
//    }
    
    class func seatIsNearBySeatWithoutRoad(_ s1: YYSeatButton?, _ s2: YYSeatButton?) -> Bool {
        if s1 != nil && s2 != nil {
            let c1 = s1!.seats.columns.index(of: s1!.seat) ?? -1
            let c2 = s2!.seats.columns.index(of: s2!.seat) ?? -1
            let near = abs(c1 - c2) == abs(Int(s1!.seat.columnId)! - Int(s2!.seat.columnId)!)
            return s1!.seats.rowId == s2!.seats.rowId && near
        }
        return false
    }
    
    class func getNearBySeatsInSameRowForSeat(_ seat: YYSeatButton, _ allAvailableSeats: NSDictionary) -> NSArray {
        let result = NSMutableArray()
        result.add(seat)
        var idx = seat.index - 1
        var tmp = allAvailableSeats.object(forKey: String(idx))
        //left
        while seatIsNearBySeatWithoutRoad(tmp as? YYSeatButton, seat) {
            if (tmp != nil) {
                result.insert(tmp!, at: 0)
            }
            idx -= 1
            tmp = allAvailableSeats.object(forKey: String(idx))
        }
        idx = seat.index + 1;
        //right
        while seatIsNearBySeatWithoutRoad(tmp as? YYSeatButton, seat) {
            if (tmp != nil) {
                result.insert(tmp!, at: 0)
            }
            idx += 1
            tmp = allAvailableSeats.object(forKey: String(idx))
        }
        return result
    }
    
    class func verifyNearSeats(_ nearBySeats: NSArray, idx: Int) -> Bool {
        let count = nearBySeats.count
        return (idx == 0 && !(nearBySeats[count - 1] as! YYSeatButton).isSeatAvailable) || (idx == count - 1 && !(nearBySeats[0] as! YYSeatButton).isSeatAvailable)
    }
    
    // MARK: 判断座位旁边是否留下单个位置
    @objc class func verifySelectedSeats(allAvailableSeats: NSDictionary, seatsArray: NSArray) -> Bool {
        for (_, model) in allAvailableSeats.allValues.enumerated() {
            let btn = model as! YYSeatButton
            if btn.isSeatAvailable {
                let idx = btn.index
                let preBtn = allAvailableSeats[String(idx - 1)] as? YYSeatButton
                let nextBtn = allAvailableSeats[String(idx + 1)] as? YYSeatButton
                //判断是否在同一列，且状态为可选
                var isPreOK = preBtn != nil &&  preBtn?.seats.rowId == btn.seats.rowId && (preBtn?.isSeatAvailable)!
                var isNextOK = nextBtn != nil && nextBtn?.seats.rowId == btn.seats.rowId && (nextBtn?.isSeatAvailable)!
                let currentCol = btn.seats.columns.index(of: btn.seat) ?? -1
                if isPreOK {
                    let preCol = preBtn!.seats.columns.index(of: preBtn!.seat) ?? -1
                    isPreOK = abs(currentCol - preCol) == 1
                }
                if isNextOK {
                    let nextCol = nextBtn!.seats.columns.index(of: nextBtn!.seat) ?? -1
                    isNextOK = abs(currentCol - nextCol) == 1
                }
                if !isPreOK && !isNextOK {
                    let nearBySeats = getNearBySeatsInSameRowForSeat(btn, allAvailableSeats)
                    if nearBySeats.count == 2 || nearBySeats.count == 1 {
                        continue
                    }
                    if nearBySeats.count <= 5 {
                        let idx = nearBySeats.index(of: btn)
                        if verifyNearSeats(nearBySeats, idx: idx) {
                            continue
                        }
                    }
                    for model in seatsArray {
                        for s in (model as! YYSeats).columns {
                            let seat = s as! YYSeat
                            if (preBtn?.seat.seatNo == seat.seatNo) || (nextBtn?.seat.seatNo == seat.seatNo) {
                                return false
                            }
                        }
                    }
                }
            }
        }
        return true
    }
}
