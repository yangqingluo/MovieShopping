//
//  YYHallNameView.swift
//  MovieSeat
//
//  Created by 7kers on 2018/11/4.
//  Copyright © 2018年 7kers. All rights reserved.
//

import UIKit

class YYHallNameView: UIView {
    var name: String? {
        didSet {
            self.setNeedsDisplay()
        }
    }
    lazy var hallLogo = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        self.addSubview(hallLogo)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        hallLogo.frame = self.bounds
    }

    override func draw(_ rect: CGRect) {
        guard let image = UIImage(named: "screenBg") else {
            return
        }
        UIGraphicsBeginImageContextWithOptions(image.size, false, 0.0)
        image.draw(at: .zero)
        
        let attributes = [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 9.0), NSAttributedStringKey.foregroundColor: UIColor.darkGray]
        let hallName = NSString(string: (self.name)!)
        let strSize = hallName.size(withAttributes: attributes)
        hallName.draw(at: CGPoint(x: (image.size.width - strSize.width) / 2.0, y: (image.size.height - strSize.height) / 2.0), withAttributes: attributes)
        guard let m_image = UIGraphicsGetImageFromCurrentImageContext() else {
            return
        }
        UIGraphicsEndImageContext()
        self.hallLogo.image = m_image
    }
}
