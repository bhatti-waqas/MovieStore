//
//  MoviesAPIDataStore.swift
//  CareemAssignment
//
//  Created by Waqas Naseem on 06/10/2019.
//  Copyright © 2019 Waqas Naseem. All rights reserved.
//

import UIKit

private enum SearchBodyParameters: String {
    case query, page,
    apiKey = "api_key"
}

struct MoviesAPIDataStore: MoviesDataStore {
    
    let network:Networking = AlamofireNetwork.shared
    let baseUrl: String = APIURLs.baseURL
    let translation:TranslationLayer = JSONTranslation()
    
    func searchMovies(with query: String, page: String, request: SearchAPIRequestModel, onCompletion: @escaping ResultHandler<SearchAPIResponseModel>) {
        
//        guard var parameter = try? translation.encode(withModel: request) else { onCompletion(.failure(.RequestFailed)); return  }
//        parameter.append(SearchBodyParameters.query, query)
//        parameter.append(SearchBodyParameters.page, page)
        let url = baseUrl.concat(urlPath: "search/movie")
        let dataRequest = CustomDataRequest(url: url)
        dataRequest.addQueryParameter(key: SearchBodyParameters.query, value: query)
        dataRequest.addQueryParameter(key: SearchBodyParameters.page, value: page)
        dataRequest.addQueryParameter(key: SearchBodyParameters.apiKey, value: APPKeys.APIKeys.themoviedb)
        
        //let router = RequestRouter.Search.get(parameters: parameter)
//        network.requestObject(router) { (response:DataResponseModel<SearchAPIResponseModel>) in
//            onCompletion(response.result)
//        }
        
        network.requestObject(dataRequest) { (response:DataResponseModel<SearchAPIResponseModel>) in
            onCompletion(response.result)
        }
        
    }
    

}
