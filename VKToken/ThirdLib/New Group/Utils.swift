//
//  Utils.swift
//  VKToken
//
//  Created by 李轶 on 2019/5/15.
//  Copyright © 2019 vankiachain. All rights reserved.
//

import Foundation
import TokenCore

func prettyPrintJSON(_ obj: JSONObject) -> String  {
    // fail fast in demo
    let encoded = try! JSONSerialization.data(withJSONObject: obj, options: .prettyPrinted)
    return String(data: encoded, encoding: .utf8)!
}
