//
//  EpisodeModel.swift
//  TVMazeApp
//
//  Created by Digao on 10/02/22.
//

import Foundation

struct EpisodeModel: Codable {
    var id: Int?
    var url: String?
    var name: String?
    var season: Int?
    var number: Int?
    var type: String?
    var airdate: String?
    var airtime: String?
    var airstamp: String?
    var runtime: Int?
    var rating: RatingModel?
    var image: ImageModel?
    var summary: String?
}
