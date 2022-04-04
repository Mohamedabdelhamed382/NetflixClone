//
//  YoutubeSearchResponse.swift
//  NetflixClone
//
//  Created by MOHAMED ABD ELHAMED AHMED on 01/04/2022.
//

import Foundation
import Foundation



struct YoutubeSearchResponse: Codable {
    let items: [VideoElement]
}


struct VideoElement: Codable {
    let id: IdVideoElement
}


struct IdVideoElement: Codable {
    let kind: String
    let videoId: String
}
