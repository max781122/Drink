//
//  MyDecoder.swift
//  Drink
//
//  Created by sourceinn on 2018/5/15.
//  Copyright © 2018年 sourceinn. All rights reserved.
//

import Foundation
struct MyDecoder<Base : Decodable> : Decodable {    
    let base: Base?
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        self.base = try? container.decode(Base.self)
    }
}
