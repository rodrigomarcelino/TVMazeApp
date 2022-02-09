//
//  SeriesService.swift
//  TVMazeApp
//
//  Created by Digao on 09/02/22.
//

import Foundation
import Promise

class SeriesService {
    let baseUrl = "https://api.tvmaze.com/"
    public func getSeriesPerPage(page: Int) -> Promise<[ShowModel]> {
        let uri = baseUrl + "shows?page=" + "\(page)"
        let request = RequestModel(url: uri, method: RequestMethod.get)
        return BaseService.request(request: request, object: [ShowModel].self)
    }
}
