//
//  RoutersProtocol.swift
//  CareemAssignment
//
//  Created by Waqas Naseem on 06/10/2019.
//  Copyright © 2019 Waqas Naseem. All rights reserved.
//

import UIKit

import Alamofire

/// Protocol that allows us to implement a base URL for our application
public protocol URLRouter {
    static var basePath: String { get }
}

/// These are routes throughout the application.
/// Typically this is conformed to by methods routes.
public protocol Routable {
    typealias Parameters = [String : Any]
    var route: String {get set}
    var urlParams: String! {get set}
    init()
}

/// Allows a route to perform the `.get` method
public protocol Readable: Routable {}

/// Allows a route to perform the `.post` method
public protocol Creatable: Routable {}

/// Allows a route to perform the `.put` method
public protocol Updatable: Routable {}

/// Allows a route to perform the `.delete` method
public protocol Deletable: Routable {}

public extension Routable {

    /// Create instance of Object that conforms to Routable
    init(_ _arg: String = "") {
        self.init()
        urlParams = _arg
    }
    /// Allows a route to become a nested route
    func nestedRoute(args: String, child: RequestConverterProtocol) -> RequestConverter {

        return RequestConverter(
            method: child.method,
            //route: "\(self.route)/\(args)/\(child.route)",
            route: "\(self.route)/\(urlParams!)/\(child.route)",
            parameters: child.parameters
        )
    }

    /// Generate the URL string for generated nested routes
    func nestedRouteURL(parent: Routable, child: Routable) -> String {
        let nestedRoute = "\(parent.route)/\(parent.urlParams!)/" + child.route
        return nestedRoute
    }
}


public extension Readable {
    
    /// Method that allows route to return an object
    ///
    /// - Parameter params: Parameters of the object that is being returned
    /// - Returns: `URLRequestConvertible` object to play nicely with Alamofire
    /// ````
    /// Router.User.get(params: "2")
    ///````
    static func get(parameters: Parameters = [:]) -> RequestConverterProtocol {
        let temp = Self.init()
        return RequestConverter(method: .get, route: temp.route, parameters: parameters)
    }
    static func get(urlParams:String, parameters: Parameters = [:]) -> RequestConverterProtocol {
        let temp = Self.init()
        let route = "\(temp.route)/\(urlParams)"
        return RequestConverter(method: .get, route: route, parameters: parameters)
    }
}


/// Protocol that conforms to URLRequestConvertible to all Alamofire integration
public protocol RequestConverterProtocol:URLRequestConvertible {
    var method: HTTPMethod {get set}
    var route: String {get set}
    var parameters: Parameters {get set}
}

/// Converter object that will allow us to play nicely with Alamofire
public struct RequestConverter: RequestConverterProtocol {
    
    public var method: HTTPMethod
    public var route: String
    public var parameters: Parameters = [:]
    public var urlParams: String!
    /// Create a RequestConverter object
    ///
    /// - Parameters:
    ///   - method: Method to perform on router. Example: `.get`, `.post`, etc.
    ///   - route: Route endpoint on url.
    ///   - parameters: Optional dictionary to pass in objects. Used for `.post` and `.put`
    init(method: HTTPMethod, route: String, parameters: Parameters = [:]) {
        self.method = method
        self.route = route
        self.parameters = parameters
    }
    
    /// Required method to conform to the `URLRequestConvertible` protocol.
    ///
    /// - Returns: URLRequest object
    /// - Throws: An `Error` if the underlying `URLRequest` is `nil`.
    public func asURLRequest() throws -> URLRequest {
        let url = try Router.basePath.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(route))
        urlRequest.httpMethod = method.rawValue
        return try URLEncoding.default.encode(urlRequest, with: parameters)
    }
    
}

//Router.swift, Final Implementation file
struct Router: URLRouter {
    static var basePath: String {
        return APIURLs.baseURL
    }
}
