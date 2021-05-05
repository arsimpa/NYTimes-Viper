//
//  Article.swift
//  NYTimes-Viper
//
//  Created by Arsalan Khan on 03/05/2021.
//

import Foundation

// MARK: - ArticleResponse
struct ArticleResponse: Codable {
    let status: String
    let copyright: String
    let numResults: Int
    let results: [Article]
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case copyright = "copyright"
        case numResults = "num_results"
        case results = "results"
    }
}

// MARK: - Article
class Article: NSObject, Codable {
    
    internal init(uri: String, url: String, id: Int, assetId: Int, source: String, publishedDate: String, updated: String, section: String, subsection: String, nytdsection: String, adxKeywords: String, byline: String, type: String, title: String, abstract: String, desFacet: [String], orgFacet: [String], perFacet: [String], geoFacet: [String], media: [Media], etaId: Int) {
        self.uri = uri
        self.url = url
        self.id = id
        self.assetId = assetId
        self.source = source
        self.publishedDate = publishedDate
        self.updated = updated
        self.section = section
        self.subsection = subsection
        self.nytdsection = nytdsection
        self.adxKeywords = adxKeywords
        self.byline = byline
        self.type = type
        self.title = title
        self.abstract = abstract
        self.desFacet = desFacet
        self.orgFacet = orgFacet
        self.perFacet = perFacet
        self.geoFacet = geoFacet
        self.media = media
        self.etaId = etaId
    }
    
    let uri: String
    let url: String
    let id: Int
    let assetId: Int
    let source: String
    let publishedDate: String
    let updated: String
    let section: String
    let subsection: String
    let nytdsection: String
    let adxKeywords: String
    let byline: String
    let type: String
    @objc let title: String
    @objc let abstract: String
    let desFacet: [String]
    let orgFacet: [String]
    let perFacet: [String]
    let geoFacet: [String]
    let media: [Media]
    let etaId: Int
    
    enum CodingKeys: String, CodingKey {
        case uri = "uri"
        case url = "url"
        case id = "id"
        case assetId = "asset_id"
        
        case source = "source"
        case publishedDate = "published_date"
        case updated = "updated"
        case section = "section"
        
        case subsection = "subsection"
        case nytdsection = "nytdsection"
        case adxKeywords = "adx_keywords"
        case byline = "byline"
        
        case type = "type"
        case title = "title"
        case abstract = "abstract"
        case desFacet = "des_facet"
        
        case orgFacet = "org_facet"
        case perFacet = "per_facet"
        case geoFacet = "geo_facet"
        case media = "media"
        case etaId = "eta_id"
    }
}

// MARK: - Media
struct Media: Codable {
    let type: String
    let subtype: String
    let caption: String
    let copyright: String
    let approvedForSyndication: Int
    let mediaMetadata: [MediaMetadatum]
    
    enum CodingKeys: String, CodingKey {
        case type = "type"
        case subtype = "subtype"
        case caption = "caption"
        case copyright = "copyright"
        case approvedForSyndication = "approved_for_syndication"
        case mediaMetadata = "media-metadata"
    }
}

// MARK: - MediaMetadatum
struct MediaMetadatum: Codable {
    
    let url: String
    let format: String
    let height: Int
    let width: Int
}

enum MediaMetaDataFormat: String {
    case standard = "Standard Thumbnail"
    case mediumThreeByTwo210 = "mediumThreeByTwo210"
    case mediumThreeByTwo440 = "mediumThreeByTwo440"
}

