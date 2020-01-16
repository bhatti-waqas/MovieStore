//
//  DataRequest.swift
//  CareemAssignment
//
//  Created by Waqas Naseem on 09/10/2019.
//  Copyright © 2019 Waqas Naseem. All rights reserved.
//

import UIKit
import Alamofire
class CustomDataRequest: URLRequestConvertible {
    
    public static let DefaultCachePolicy = URLRequest.CachePolicy.useProtocolCachePolicy
    public static let DefaultTimeOutIterval:TimeInterval = 60
    public var url:String
    public var method:HTTPMethod
    public var forceNetwork:Bool
    public var headers:[String : String]
    public var basicAuthentication:(username:String, password:String)?
    public var data:Data?
    public var addClientTypeHeader:Bool = true
    
    convenience init<T:Encodable>(url:String, method: HTTPMethod = .get, forceNetwork:Bool = false, object:T, headers: [String : String]? = nil) {
        let jsonData = try? JSONEncoder().encode(object)
        self.init(url: url, method: method, forceNetwork: forceNetwork, rawData: jsonData, headers: headers)
    }
    
//    convenience init(url:String, method: HTTPMethod = .get, forceNetwork:Bool = false, body:JSON, headers: [String : String]? = nil) {
//        self.init(url: url, method: method, forceNetwork: forceNetwork, rawData: (try? body.rawData()) ?? nil, headers: headers)
//    }
    
    convenience init(url:String, method: HTTPMethod = .get, forceNetwork:Bool = false, data:Data? = nil, headers: [String : String]? = nil) {
        self.init(url: url, method: method, forceNetwork: forceNetwork, rawData: data, headers: headers)
    }
    
    private init(url:String, method: HTTPMethod = .get, forceNetwork:Bool = false, rawData:Data? = nil, headers: [String : String]? = nil) {
        self.url = url
        self.method = method
        self.headers = headers ?? [:]
        self.data = rawData
        self.forceNetwork = forceNetwork
    }
    
    public func addQueryParameter<Key:RawRepresentable>(key:Key?, value:Int?) where Key.RawValue == String {
        addQueryParameter(key: key?.rawValue, value: value?.toString())
    }
    
    public func addQueryParameter<Key:RawRepresentable>(key:Key?, value:String?) where Key.RawValue == String {
        addQueryParameter(key: key?.rawValue, value: value)
    }
    
    public func addQueryParameter<Value:RawRepresentable>(key:String?, value:Value?) where Value.RawValue == String {
        addQueryParameter(key: key, value: value?.rawValue)
    }
    
    public func addQueryParameter<Key:RawRepresentable, Value:RawRepresentable>(key:Key?, value:Value?) where Key.RawValue == String, Value.RawValue == String {
        addQueryParameter(key: key?.rawValue, value: value?.rawValue)
    }
    
    public func addQueryParameter(key:String?, value:String?) {
        guard let value = value else {
            return
        }
        
        guard let key = key else {
            return
        }
        
        let queryString = key + "=" + value.escape()
        url = url + (url.contains("?") ? "&" : "?") + queryString
    }
    
    public func addQueryParameter(value:String?) {
        guard let value = value else { return }
        
        let queryString = value.escape()
        url = url + (url.contains("?") ? "&" : "?") + queryString
    }
    
    public func addHeader(key:String, value:String?) {
        guard let value = value else {
            return
        }
        headers[key] = value
    }
    
    func asURLRequest() throws -> URLRequest {
        guard let url = URL(string: self.url) else {
            throw AFError.invalidURL(url: self.url)
        }
        
        let ignoreCache:Bool = forceNetwork || method != .get
        let policy = ignoreCache ? URLRequest.CachePolicy.reloadIgnoringLocalAndRemoteCacheData : URLRequest.CachePolicy.returnCacheDataElseLoad
        
        guard var urlRequest = try? URLRequest(url: url, method: method) else {
            throw AFError.invalidURL(url: self.url)
        }
        
        urlRequest.cachePolicy = policy
        urlRequest.timeoutInterval = CustomDataRequest.DefaultTimeOutIterval
        
        if let data = self.data {
            urlRequest.httpBody = data
        }
        
        for header in headers {
            urlRequest.addValue(header.value, forHTTPHeaderField: header.key)
        }
        
//        if addClientTypeHeader {
//            urlRequest.addValue(AppConfig.Keys.ClientType.stringValue, forHTTPHeaderField: "Client-Type")
//        }
        
        
        return urlRequest
    }
    

}
