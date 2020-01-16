//
//  Test.swift
//  CareemAssignment
//
//  Created by Waqas Naseem on 09/10/2019.
//  Copyright © 2019 Waqas Naseem. All rights reserved.
//

//import UIKit
//
//class NetworkCarUseCase: NSObject, CarUseCase {
//    private let url = "https://fake-poi-api.mytaxi.com"
//    private let disposebag = DisposeBag()
//    
//    func getCars(with request: TaxiRequest) -> Single<[Taxi]> {
//        return .create { single in
//            AF.request(self.url, parameters: request)
//                .validate()
//                .responseDecodable { (response: DataResponse<TaxiResponse>) in
//                    print(response.debugDescription)
//                    switch response.result {
//                    case .failure(let error):
//                        single(.error(CarAPIError.server(error)))
//                    case .success(let taxiResponse) where taxiResponse.poiList.isEmpty:
//                        single(.error(CarAPIError.notFound))
//                    case .success(let taxiResponse):
//                        single(.success(taxiResponse.poiList))
//                    }
//            }
//            return Disposables.create()
//        }
//    }
//    
//    typealias SuccessHandler = ([Taxi]) -> Void
//    typealias FailureHandler = (Error) -> Void
//    
//    @objc
//    func getCars(with request: TaxiRequest, success: @escaping SuccessHandler, failure: @escaping FailureHandler) {
//        getCars(with: request)
//            .subscribe { (single: SingleEvent<[Taxi]>) in
//                switch single {
//                case .error(let error): failure(error)
//                case .success(let taxies): success(taxies)
//                }
//            }.disposed(by: disposebag)
//    }
//}
