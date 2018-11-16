//
//  YYSectionSeat.swift
//  MovieShopping
//
//  Created by NAVER on 2018/11/16.
//  Copyright © 2018年 yang. All rights reserved.
//

import UIKit

typealias SeatBlock = (YYSingleSeatView) -> Void

class YYSectionSeatView: UIView {
    var data: YYSection!
    var rowData = NSMutableDictionary()
    var btnWidth: CGFloat = 30.0
    var btnHeight: CGFloat = 30.0
    var viewWidth: CGFloat = 0.0
    var viewHeight: CGFloat = 0.0
    var maxColumn: Int = 1
    var maxRow: Int = 1
    var blockProperty: SeatBlock?
    
    init(data: YYSection, maxWidth: CGFloat, block: @escaping SeatBlock) {
        super.init(frame: .zero)
        self.backgroundColor = UIColor.clear
        self.data = data
        self.blockProperty = block
        
        if data.regular {
            maxColumn = data.maxColumn
            maxRow = data.maxRow
        }
        else {
            maxColumn = Int(1 + CGFloat(data.maxLeftPx) / YYSeatPx)
            maxRow = Int(1 + CGFloat(data.maxTopPx) / YYSeatPx)
        }
        let view_w = maxWidth - 2.0 * YYSeatsRowMargin
        let btn_w = min(YYSeatMinW_H, view_w / CGFloat(maxColumn))
        self.btnWidth = btn_w
        self.btnHeight = btn_w
        self.viewWidth = CGFloat(maxColumn) * self.btnWidth
        self.viewHeight = CGFloat(maxRow) * self.btnHeight
        initSeatBtns()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func initSeatBtns() {
        for (i, item) in self.data.seats!.enumerated() {
            let seat = item as YYSectionSeat
            let btn = YYSingleSeatView()
            btn.tag = YYSeatTag + i
            if seat.status == 1 {
                btn.setImage(UIImage(named: "choosable"), for: .normal)
                btn.setImage(UIImage(named: "selected"), for: .selected)
            }
            else if seat.status == 0 {
                btn.setImage(UIImage(named: "sold"), for: .normal)
                btn.setImage(UIImage(named: "sold"), for: .selected)
            }
            var column: Int = seat.column - 1
            var row: Int = seat.row - 1
            if !self.data.regular {
                column = Int(CGFloat(seat.leftPx) / YYSeatPx)
                row = Int(CGFloat(seat.topPx) / YYSeatPx)
            }
            btn.frame = CGRect.init(x: CGFloat(column) * btnHeight, y: CGFloat(row) * btnHeight, width: btnWidth, height: btnHeight)
            self.addSubview(btn)
            let tap = UITapGestureRecognizer(target: self, action: #selector(seatBtnAction(gesture:)))
            btn.addGestureRecognizer(tap)
            if seat.rowName != nil && self.rowData[seat.rowName] == nil {
                self.rowData.setObject(row, forKey: seat.rowName as NSCopying)
            }
        }
    }
        
    @objc func seatBtnAction(gesture: UIGestureRecognizer) {
        guard let btn = gesture.view as? YYSingleSeatView else {
            return
        }
        self.blockProperty?(btn)
    }
}
