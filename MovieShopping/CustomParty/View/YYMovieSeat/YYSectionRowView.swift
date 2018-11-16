//
//  YYSectionRowView.swift
//  MovieShopping
//
//  Created by NAVER on 2018/11/16.
//  Copyright © 2018年 yang. All rights reserved.
//

import UIKit

class YYSectionRowView: UIView {
    var maxRow: Int = 1
    var rowData = NSDictionary() {
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
        let h = (self.height - 2 * YYSmallMargin) / CGFloat(self.maxRow)
        for (key, item) in self.rowData {
            let rowName = key as! NSString
            let row = item as! CGFloat
            let size = rowName.size(withAttributes: attributes)
            let point = CGPoint(x: (self.width - size.width) / 2.0, y: 10.0 + CGFloat(row) * h + 0.5 * (h - size.height))
            rowName.draw(at: point, withAttributes: attributes)
        }
    }

}
