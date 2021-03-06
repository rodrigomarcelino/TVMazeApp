//
//  ShowModel.swift
//  TVMazeApp
//
//  Created by Digao on 05/02/22.
//

import Foundation

struct ShowModel: Codable {
    var id: Int?
    var url: String?
    var name: String?
    var type: String?
    var language: String?
    var genres: [String]?
    var status: String?
    var runtime: Int?
    var averageRuntime: Int?
    var premiered: String?
    var ended: String?
    var officialSite: String?
    var schedule: ScheduleModel?
    var rating: RatingModel?
    var weight: Int?
    var network: NetworkModel?
    var externals: ExternalsModel?
    var image: ImageModel?
    var summary: String?
    var updated: Int32?
}

struct ScheduleModel: Codable {
    var time: String?
    var days: [String]?
}

struct RatingModel: Codable {
    var average: Double?
}

struct NetworkModel: Codable {
    var id: Int?
    var name: String?
    var country: CountryModel?
}

struct CountryModel: Codable {
    var name: String?
    var code: String?
    var timezone: String?
}

struct ExternalsModel: Codable {
    var tvrage: Int32?
    var thetvdb: Int32?
    var imdb: String?
}

struct ImageModel: Codable {
    var medium: String?
    var original: String?
}
    
