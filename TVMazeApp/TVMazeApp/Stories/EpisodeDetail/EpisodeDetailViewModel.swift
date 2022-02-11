//
//  EpisodeDetailViewModel.swift
//  TVMazeApp
//
//  Created by Digao on 11/02/22.
//

import Foundation
import RxCocoa
import Promise

class EpisodeDetailViewModel: NSObject {
    
    var episode: EpisodeModel
    
    init(episode: EpisodeModel) {
        self.episode = episode
    }
    
    func episodeInfo() -> String {
        let episodeNumber = episode.number ?? 0
        let episodeSeason = episode.season ?? 0
        return "Episode \(episodeNumber), Season \(episodeSeason)"
    }
    
}
