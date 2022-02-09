//
//  BaseService.swift
//  TVMazeApp
//
//  Created by Digao on 05/02/22.
//

import Foundation
import UIKit
import Alamofire
import Promise

public class BaseService {
    private static var alamoFireManager: Session? = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 60
        configuration.timeoutIntervalForResource = 90
        let alamoFireManager = Alamofire.Session(configuration: configuration)
        return alamoFireManager
    }()

    public static func request<T: Codable>(request: RequestModel, object: T.Type) -> Promise<T> {
        return Promise { fulfill, reject in


        alamoFireManager?.request(request.url, method: httpMethod(request.method), parameters: request.params).responseData { response in
            URLCache.shared.removeAllCachedResponses()
            
            guard let data = response.data else {
//                reject(response.error!)
                return
            }

            do {
                let resultObj = try JSONDecoder().decode(object.self, from: data)

                fulfill(resultObj)
            } catch let decodeErr {
                reject(decodeErr)
            }
            }
        }
    }
}

extension BaseService {
    private static func httpMethod(_ method: RequestMethod) -> HTTPMethod {
        switch method {
        case .get:
            return .get
        case .post:
            return .post
        }
    }
}
