//
//  PostData.swift
//  Drink
//
//  Created by sourceinn on 2018/5/16.
//  Copyright © 2018年 sourceinn. All rights reserved.
//

import Foundation
struct PostData<T>:Codable where T :Codable{
    var data:[T]
}

