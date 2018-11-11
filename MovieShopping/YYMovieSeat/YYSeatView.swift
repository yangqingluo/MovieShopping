//
//  YYSeatView.swift
//  MovieSeat
//
//  Created by 7kers on 2018/11/4.
//  Copyright © 2018年 7kers. All rights reserved.
//

import UIKit

typealias ActionBlock = (YYSeatButton, NSMutableDictionary) -> Void

class YYSeatView: UIView {
    var btnWidth: CGFloat = 0.0
    var btnHeight: CGFloat = 0.0
    var viewWidth: CGFloat = 0.0
    var viewHeight: CGFloat = 0.0
    lazy var allAvailableSeats = NSMutableDictionary()//所有可选的座位
    var blockProperty: ActionBlock?
    
    init(seatsArray: NSArray, maxNomarWidth: CGFloat, block: @escaping ActionBlock) {
        super.init(frame: .zero)
        self.backgroundColor = UIColor.clear
        blockProperty = block
        let seats = seatsArray[0] as! YYSeats
        var count = (seats.columns.count)
        if count % 2 == 0 {
            count += 1
        }
        var view_w = maxNomarWidth - 2.0 * YYSeatsRowMargin
        var btn_w = view_w / CGFloat(count)
        if btn_w > YYSeatMinW_H {
            btn_w = YYSeatMinW_H
            view_w = CGFloat(count) * btn_w
        }
        self.btnWidth = btn_w
        self.btnHeight = btn_w
        self.viewWidth = view_w
        self.viewHeight = CGFloat(seatsArray.count) * self.btnHeight
        self.initSeatBtns(seatsArray)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        for subView in self.subviews {
            if subView is YYSeatButton {
                let btn = subView as! YYSeatButton
                let col = btn.seats.columns.index(of: btn.seat)! //列
                let row = (btn.seats.rowNum.intValue) - 1 //行
                btn.frame = CGRect.init(x: CGFloat(col) * self.btnHeight, y: CGFloat(row) * self.btnHeight, width: self.btnWidth, height: self.btnHeight)
            }
        }
    }
    
    func initSeatBtns(_ seatsArray: NSArray) {
        //给可以用的座位绑定索引用来判断是否座位落单
        var seatIndex = 0;
        for (_, model) in seatsArray.enumerated() {
            let seats = model as! YYSeats
            for (_, column) in (seats.columns.enumerated()) {
                seatIndex += 1
                let btn = YYSeatButton()
                btn.seat = column
                btn.seats = seats
                if btn.seat.st == "N" {
                    btn.setImage(UIImage(named: "choosable"), for: .normal)
                    btn.setImage(UIImage(named: "xuanzhong"), for: .selected)
                    btn.index = seatIndex
                    self.allAvailableSeats.setObject(btn, forKey: String(seatIndex) as NSCopying)
                }
                else if btn.seat.st == "E" {
                    continue
                }
                else {
                    btn.setImage(UIImage(named: "sold"), for: .normal)
                    btn.isUserInteractionEnabled = false
                }
//                btn.addTarget(self, action:  #selector(seatBtnAction(btn:)), for: .touchUpInside)
                let tap = UITapGestureRecognizer(target: self, action: #selector(seatBtnAction(gesture:)))
                btn.addGestureRecognizer(tap)
                self.addSubview(btn)
            }
        }
    }
    
    @objc func seatBtnAction(gesture: UIGestureRecognizer) {
        guard let btn = gesture.view as? YYSeatButton else {
            return
        }
        btn.isSelected = !btn.isSelected
        if btn.isSelected {
            btn.seat.st = "LK"
        }
        else {
            btn.seat.st = "N"
        }
        self.blockProperty?(btn, self.allAvailableSeats)
    }
    
//    @objc func seatBtnAction(btn: YYSeatButton) {
//        btn.isSelected = !btn.isSelected
//        if btn.isSelected {
//            btn.seat.st = "LK"
//        }
//        else {
//            btn.seat.st = "N"
//        }
//        self.blockProperty?(btn, self.allAvailableSeats)
//    }
}
