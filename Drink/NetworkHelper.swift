//
//  NetworkHelper.swift
//  Drink
//
//  Created by sourceinn on 2018/5/15.
//  Copyright © 2018年 sourceinn. All rights reserved.
//

import Foundation
import UIKit
class NetworkHelper{
    static let shared = NetworkHelper()
    static let url:String = "https://sheetdb.io/api/v1/5afa4cc2a8914"
    func fetchOrders(completion: @escaping ([OrderEntity]?) -> Void) {
        if let url = URL(string: NetworkHelper.url) {
            let task = URLSession.shared.dataTask(with: url) { (data, response , error) in
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                //print(String(data: data!, encoding: String.Encoding.utf8))
                if let data = data, let orderResults = try? decoder.decode([MyDecoder<OrderEntity>].self, from: data).flatMap{$0.base}{
                    completion(orderResults)
                } else {
                    completion(nil)
                }
            }
            task.resume()
        } else {
            completion(nil)
        }
    }
    
    func fetchDrinks(completion: @escaping ([DrinkEntity]?) -> Void) {
        if let url = URL(string: NetworkHelper.url+"?sheet=drinkList") {
            let task = URLSession.shared.dataTask(with: url) { (data, response , error) in
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                //print(String(data: data!, encoding: String.Encoding.utf8))
                if let data = data, let orderResults = try? decoder.decode([MyDecoder<DrinkEntity>].self, from: data).flatMap{$0.base}{
                    completion(orderResults)
                } else {
                    completion(nil)
                }
            }
            task.resume()
        } else {
            completion(nil)
        }
    }
    
    
    func create(data:OrderEntity, completion: @escaping ([String:Any]?) -> Void){
        let postData = PostData<OrderEntity>(data: [data])
        let url = URL(string: NetworkHelper.url)
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let jsonEncoder = JSONEncoder()
        do {
            let data = try jsonEncoder.encode(postData)
            let task = URLSession.shared.uploadTask(with: urlRequest, from: data, completionHandler: { (retData, res, err) in
                if let returnData = retData, let dic = (try? JSONSerialization.jsonObject(with: returnData)) as? [String:Any] {
                    completion(dic)
                } else {
                    completion(nil)
                }
            })
            task.resume()
        } catch {
            
        }
    }
    
    func update(name:String, data:OrderEntity,  completion: @escaping ([String:Any]?) -> Void){
        let postData = PostData<OrderEntity>(data: [data])
        
        let url = URL(string: NetworkHelper.url+"/name/"+name.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!)
        
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "PUT"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let jsonEncoder = JSONEncoder()
        do {
            let data = try jsonEncoder.encode(postData)
            let task = URLSession.shared.uploadTask(with: urlRequest, from: data, completionHandler: { (retData, res, err) in
                if let returnData = retData, let dic = (try? JSONSerialization.jsonObject(with: returnData)) as? [String:Any] {
                    completion(dic)
                } else {
                    completion(nil)
                }
            })
            task.resume()
        } catch {
            
        }
    }
    
    func delete(column:String, value:String, completion: @escaping ([String:Any]?) -> Void){
        let url = URL(string: NetworkHelper.url+"/"+column+"/"+value.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!)
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "DELETE"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let task = URLSession.shared.dataTask(with: urlRequest, completionHandler: { (retData, res, err) in
            if let returnData = retData, let dic = (try? JSONSerialization.jsonObject(with: returnData)) as? [String:Any] {
                completion(dic)
            } else {
                completion(nil)
            }
        })
        task.resume()
    }
    
    

}

