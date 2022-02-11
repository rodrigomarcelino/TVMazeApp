//
//  ShowsService.swift
//  TVMazeApp
//
//  Created by Digao on 09/02/22.
//

import Foundation
import Promise

class ShowsService {
    let baseUrl = "https://api.tvmaze.com"
    
    public func getShowsPerPage(page: Int) -> Promise<[ShowModel]> {
        let uri = baseUrl + "/shows?page=\(page)"
        let request = RequestModel(url: uri, method: RequestMethod.get)
        return BaseService.request(request: request, object: [ShowModel].self)
    }
    
    public func searchShows(searchText: String) -> Promise<[SearchShowModel]> {
        let uri = baseUrl + "/search/shows?q=" + searchText
        let request = RequestModel(url: uri, method: RequestMethod.get)
        return BaseService.request(request: request, object: [SearchShowModel].self)
    }
    
    public func getShowEpisodes(showId: Int) -> Promise<[EpisodeModel]> {
        let uri = baseUrl + "/shows/\(showId)/episodes"
        let request = RequestModel(url: uri, method: RequestMethod.get)
        return BaseService.request(request: request, object: [EpisodeModel].self)
    }
}
