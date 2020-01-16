//
//  BaseViewModel.swift
//  CareemAssignment
//
//  Created by Waqas Naseem on 06/10/2019.
//  Copyright © 2019 Waqas Naseem. All rights reserved.
//

import UIKit

public class BaseViewModel {
    
    public weak var delegate : ViewModelDelegate?
       private var ready:Bool = false
       private var loading:Bool = false
       
       public func load() {
           self.loading = true
       }
       
       public func load(with delegate: ViewModelDelegate) {
           self.delegate = delegate
           self.load()
       }
       
       @discardableResult
       public func isReady(_ shouldNotifyDelegate: Bool = true)->Bool {
           if ready && shouldNotifyDelegate {
               self.makeReady()
           }
           return ready
       }

       public func isLoading() -> Bool {
           return loading
       }
       
       public func makeReady() {
           self.ready = true
           self.loading = false
           self.delegate?.onViewModelReady(self)
       }
       
       public func reset() {
           self.ready = false
           self.loading = false
       }
       
       public func throwError(with error:NetworkError) {
           //In some cases we are receving errors from background threads.
           //We need to make sure we use main thread since we are going to interact with UI
           Run.onMainThread {
               self.loading = false
               self.delegate?.onViewModelError(self, error: error)
           }
       }
}

public protocol ViewModelDelegate : class {
    func onViewModelReady(_ viewModel:BaseViewModel)
    func onViewModelError(_ viewModel:BaseViewModel, error:NetworkError)
}
