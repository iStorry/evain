//
//  Items.swift
//  Evain
//
//  Created by Jatin on 2020/07/02.
//

import Foundation
import Combine
import AVKit

struct Fields {
    static var count = 30
    static var region = "JP"
    static var verify = ""
    static var signature = ""
}


protocol PlayerModel {
    var player: AVPlayer { get set }
    var replay: Bool { get set }
}

// MARK: - Main
struct Main: Codable {
    let statusCode: Int
    var items: [Item]
    let hasMore: Bool
    let maxCursor, minCursor: String
}

// MARK: - Item
struct Item: Codable, Identifiable {
    let id, desc: String
    let createTime: Int
    var video: Video
    let author: Author
    let music: Music
    let challenges: [Challenge]?
    let stats: Stats
    let originalItem, officalItem: Bool
    let textExtra: [TextExtra]?
    let secret, forFriend, digged: Bool
    let itemCommentStatus: Int
    let showNotPass, vl1: Bool
}

// MARK: - Author
struct Author: Codable {
    let id, uniqueID, nickname: String
    let avatarThumb, avatarMedium, avatarLarger: String
    let signature: String
    let verified: Bool
    let secUid: String
    let relation: Int
    let openFavorite: Bool

    enum CodingKeys: String, CodingKey {
        case id
        case uniqueID = "uniqueId"
        case nickname, avatarThumb, avatarMedium, avatarLarger, signature, verified, secUid, relation, openFavorite
    }
}

// MARK: - Challenge
struct Challenge: Codable {
    let id, title, desc: String
    let profileThumb, profileMedium, profileLarger, coverThumb: String
    let coverMedium, coverLarger: String
}

// MARK: - Music
struct Music: Codable {
    let id, title: String
    let playURL: String
    let coverThumb, coverMedium, coverLarge: String
    let authorName: String
    let original: Bool

    enum CodingKeys: String, CodingKey {
        case id, title
        case playURL = "playUrl"
        case coverThumb, coverMedium, coverLarge, authorName, original
    }
}

// MARK: - Stats
struct Stats: Codable {
    let diggCount, shareCount, commentCount, playCount: Int
}

// MARK: - TextExtra
struct TextExtra: Codable {
    let awemeID: String
    let start, end: Int
    let hashtagName, hashtagID: String
    let type: Int
    let userID: String
    let isCommerce: Bool

    enum CodingKeys: String, CodingKey {
        case awemeID = "awemeId"
        case start, end, hashtagName
        case hashtagID = "hashtagId"
        case type
        case userID = "userId"
        case isCommerce
    }
}

// MARK: - Video
struct Video: Codable {
    let id: ID
    let height, width, duration: Int
    let ratio: Ratio
    let cover, originCover, dynamicCover, playAddr: String
    let downloadAddr: String
    let shareCover: [String]
}

struct VideoData {
    var player: AVPlayer
    var replay: Bool
}

enum ID: String, Codable {
    case awesome = "awesome"
}

enum Ratio: String, Codable {
    case the720P = "720p"
}
