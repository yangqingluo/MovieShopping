//
//  YYSeat.swift
//  MovieSeat
//
//  Created by 7kers on 2018/11/4.
//  Copyright © 2018年 7kers. All rights reserved.
//

import UIKit

struct YYSeatModel: Decodable {
    var columnId: String? //座位列号
    var seatNo: String? //座位编号
    var st: String? //座位状态 N/表示可以购票 LK／座位已售出 E/表示过道
}

struct YYSeatsModel : Decodable {
    var columns: Array<YYSeatModel>?
    var rowId: String? //座位行号
    var rowNum: Int? //座位屏幕行，用于算座位frame
}
