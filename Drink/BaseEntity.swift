//
//  BaseEntity.swift
//  Drink
//
//  Created by sourceinn on 2018/5/15.
//  Copyright © 2018年 sourceinn. All rights reserved.
//

import Foundation
class BaseEntity<T>:Codable where T:Codable{
    
}
struct Student: Codable {
    let name:String = "111"
    let drinkName:String = "222"
    let ice:String = "333"
    let sugar:String = "444"
    let price:String = "555"
}
