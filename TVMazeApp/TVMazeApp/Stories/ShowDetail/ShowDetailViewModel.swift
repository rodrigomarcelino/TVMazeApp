//
//  ShowDetailViewModel.swift
//  TVMazeApp
//
//  Created by Digao on 10/02/22.
//

import Foundation
import RxCocoa
import Promise

class ShowDetailViewModel: NSObject {
    var viewState = ViewState()
    
    var showModel: ShowModel?
    var episodeList: [EpisodeModel]? = []
    
    let showsService = ShowsService()
    var episodesPerSeason: [Int: [EpisodeModel]] = [:]
    var seasonKeys: [Int] {
        episodesPerSeason.keys.sorted()
    }

    struct ViewState {
        let loading = BehaviorRelay<Bool>(value: false)
        let seviceSuccess = BehaviorRelay<Void>.init(value: ())
    }
    
    init(showModel: ShowModel) {
        self.showModel = showModel
    }
    
    func getEpisodes() {
        viewState.loading.accept(true)
        showsService.getShowEpisodes(showId: showModel?.id ?? 0).then { [self] result in
            self.episodeList = result
            if let episodeList = episodeList {
                let seasons = Set(episodeList.map { $0.season })
                seasons.forEach {
                    episodesPerSeason[$0 ?? 0] = []
                }
                episodeList.forEach {
                    episodesPerSeason[$0.season ?? 0]?.append($0)
                }
                self.viewState.seviceSuccess.accept(())
            }
        }.catch { _ in
            self.viewState.loading.accept(false)
            //TODO show empty view or error service
        }
    }
    
    func numberOfSections() -> Int {
        guard let episodeList = episodeList, episodeList.count > 0 else {
            return 0
        }
        let totalEpisodes = episodeList.count
        let lastEpisode = episodeList[totalEpisodes - 1]
        return lastEpisode.season ?? 0
    }
    
    func schedule() -> String {
        guard let show = showModel, let scheduleDay = show.schedule?.days?[0], let scheduleTime = show.schedule?.time else {
            return ""
        }
        return scheduleDay + ", " + scheduleTime
    }
}
