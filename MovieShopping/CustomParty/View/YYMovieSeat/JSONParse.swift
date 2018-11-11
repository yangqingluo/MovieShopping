//
//  JSONParse.swift
//  MovieSeat
//
//  Created by naver on 2018/11/6.
//  Copyright © 2018 7kers. All rights reserved.
//

import UIKit

enum JSONError: Error {
    case message(String)
}

class JSONParse: NSObject {
    static func decode<T>(_ type: T.Type, param: [String: Any]) throws -> T where T: Decodable {
        guard let jsonData = self.getJsonData(with: param) else {
            throw JSONError.message("转换data失败")
        }
        guard let model = try? JSONDecoder().decode(type, from: jsonData) else {
            throw JSONError.message("转换模型失败")
        }
        return model
    }
    static func getJsonData(with param: Any)->Data? {
        if !JSONSerialization.isValidJSONObject(param) {
            return nil
        }
        guard let data = try? JSONSerialization.data(withJSONObject: param, options: []) else {
            return nil
        }
        return data
    }
}
