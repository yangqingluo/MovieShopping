//
//  YYRowIndexView.swift
//  MovieSeat
//
//  Created by 7kers on 2018/11/4.
//  Copyright © 2018年 7kers. All rights reserved.
//

import UIKit

class YYRowIndexView: UIView {
    var indexsArray = NSArray() {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.darkGray.withAlphaComponent(0.5)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.width * 0.5
        self.layer.masksToBounds = true
    }
    
    override var frame: CGRect {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    override func draw(_ rect: CGRect) {
        let attributes = [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 10.0), NSAttributedStringKey.foregroundColor: UIColor.white]
        let h = (self.height - 2 * 10.0) / CGFloat(self.indexsArray.count)
        for (index, model) in self.indexsArray.enumerated() {
            let rowId = (model as! YYSeats).rowId as NSString
            let strSize = rowId.size(withAttributes: attributes)
            rowId.draw(at: CGPoint.init(x: (self.width - strSize.width) / 2.0, y: 10.0 + CGFloat(index) * h + 0.5 * (h - strSize.height)), withAttributes: attributes)
        }
    }

}
