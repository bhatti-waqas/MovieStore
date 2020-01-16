//
//  Detectable.swift
//  CareemAssignment
//
//  Created by Waqas Naseem on 06/10/2019.
//  Copyright © 2019 Waqas Naseem. All rights reserved.
//
import Foundation
class Detectable<T> {
    
    typealias Subscriber = ((T) -> Void)
    
    private var subscriber : Subscriber?
    
    var value : T {
        didSet{
            subscriber?(value)
        }
    }
    
    init(_ value : T) {
        self.value = value
    }
    
    func bind(subscriber : @escaping Subscriber) {
        self.subscriber = subscriber
    }
}

