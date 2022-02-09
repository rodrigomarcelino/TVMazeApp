//
//  RequestModel.swift
//  TVMazeApp
//
//  Created by Digao on 08/02/22.
//

import Foundation

public class RequestModel {
    public let url: String
    public let method: RequestMethod
    public var params: [String: Any]?
    public var headers: [String: String]?

    public init(url: String,
                method: RequestMethod,
                params: [String: Any]? = nil,
                headers: [String: String]? = nil)
    {
        self.url = url
        self.method = method
        self.params = params
        self.headers = headers
    }
}

public enum RequestMethod {
    case get
    case post
}
