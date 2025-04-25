//
//  LandingScreen+Models.swift
//  TechnologyAssisment
//
//  Created by Mashhood Qadeer on 25/04/2025.
//

import Foundation

// MARK: - NYTResponse Response
struct NYTResponse: Decodable {
  let status: String
  let copyright: String
  let numResults: Int
  let results: [NYTArticle]

  enum CodingKeys: String, CodingKey {
    case status, copyright
    case numResults = "num_results"
    case results
  }

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    status = try container.decodeIfPresent(String.self, forKey: .status) ?? "Unknown"
    copyright = try container.decodeIfPresent(String.self, forKey: .copyright) ?? ""
    numResults = try container.decodeIfPresent(Int.self, forKey: .numResults) ?? 0
    results = try container.decodeIfPresent([NYTArticle].self, forKey: .results) ?? []
  }
}

// MARK: - Article
struct NYTArticle: Decodable {
  let uri: String
  let url: String
  let id: Int
  let assetID: Int
  let source: String
  let publishedDate: String
  let updated: String
  let section: String
  let subsection: String
  let nytdsection: String
  let adxKeywords: String
  let column: String?
  let byline: String
  let type: String
  let title: String
  let abstract: String
  let desFacet: [String]
  let orgFacet: [String]
  let perFacet: [String]
  let geoFacet: [String]
  let media: [NYTMedia]
  let etaID: Int

  enum CodingKeys: String, CodingKey {
    case uri, url, id, source, column, byline, type, title, abstract, media
    case assetID = "asset_id"
    case publishedDate = "published_date"
    case updated, section, subsection, nytdsection
    case adxKeywords = "adx_keywords"
    case desFacet = "des_facet"
    case orgFacet = "org_facet"
    case perFacet = "per_facet"
    case geoFacet = "geo_facet"
    case etaID = "eta_id"
  }

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)

    uri = try container.decodeIfPresent(String.self, forKey: .uri) ?? ""
    url = try container.decodeIfPresent(String.self, forKey: .url) ?? ""
    id = try container.decodeIfPresent(Int.self, forKey: .id) ?? 0
    assetID = try container.decodeIfPresent(Int.self, forKey: .assetID) ?? 0
    source = try container.decodeIfPresent(String.self, forKey: .source) ?? ""
    publishedDate = try container.decodeIfPresent(String.self, forKey: .publishedDate) ?? ""
    updated = try container.decodeIfPresent(String.self, forKey: .updated) ?? ""
    section = try container.decodeIfPresent(String.self, forKey: .section) ?? ""
    subsection = try container.decodeIfPresent(String.self, forKey: .subsection) ?? ""
    nytdsection = try container.decodeIfPresent(String.self, forKey: .nytdsection) ?? ""
    adxKeywords = try container.decodeIfPresent(String.self, forKey: .adxKeywords) ?? ""
    column = try container.decodeIfPresent(String.self, forKey: .column)
    byline = try container.decodeIfPresent(String.self, forKey: .byline) ?? ""
    type = try container.decodeIfPresent(String.self, forKey: .type) ?? ""
    title = try container.decodeIfPresent(String.self, forKey: .title) ?? ""
    abstract = try container.decodeIfPresent(String.self, forKey: .abstract) ?? ""

    desFacet = try container.decodeIfPresent([String].self, forKey: .desFacet) ?? []
    orgFacet = try container.decodeIfPresent([String].self, forKey: .orgFacet) ?? []
    perFacet = try container.decodeIfPresent([String].self, forKey: .perFacet) ?? []
    geoFacet = try container.decodeIfPresent([String].self, forKey: .geoFacet) ?? []

    media = try container.decodeIfPresent([NYTMedia].self, forKey: .media) ?? []
    etaID = try container.decodeIfPresent(Int.self, forKey: .etaID) ?? 0
  }

  var mediaThumbnail: URL? {
        get{
            if let firstMedia = self.media.first as? NYTMedia,
               let standardThumbnailURLString = firstMedia.mediaMetadata.first(where: { $0.format == ThumbnailType.STANDARD.rawValue })?.url,
               let standardThumbnailURL = URL(string: standardThumbnailURLString) {
               return standardThumbnailURL
            }
            return nil
         }
  }
  
    enum ThumbnailType: String{
         case STANDARD = "Standard Thumbnail"
         case MEDIUM_THREE_BY_TWO_210 = "mediumThreeByTwo210"
         case MEDIUM_THREE_BY_TWO_440 = "mediumThreeByTwo440"
    }
    
    
}

// MARK: - Media
struct NYTMedia: Decodable {

  let type: String
  let subtype: String
  let caption: String
  let copyright: String
  let approvedForSyndication: Int
  let mediaMetadata: [NYTMediaMetadata]

  enum CodingKeys: String, CodingKey {
    case type, subtype, caption, copyright
    case approvedForSyndication = "approved_for_syndication"
    case mediaMetadata = "media-metadata"
  }

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    type = try container.decodeIfPresent(String.self, forKey: .type) ?? ""
    subtype = try container.decodeIfPresent(String.self, forKey: .subtype) ?? ""
    caption = try container.decodeIfPresent(String.self, forKey: .caption) ?? ""
    copyright = try container.decodeIfPresent(String.self, forKey: .copyright) ?? ""
    approvedForSyndication =
      try container.decodeIfPresent(Int.self, forKey: .approvedForSyndication) ?? 0
    mediaMetadata =
      try container.decodeIfPresent([NYTMediaMetadata].self, forKey: .mediaMetadata) ?? []
  }
}

// MARK: - Media Metadata
struct NYTMediaMetadata: Decodable {

  let url: String
  let format: String
  let height: Int
  let width: Int

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    url = try container.decodeIfPresent(String.self, forKey: .url) ?? ""
    format = try container.decodeIfPresent(String.self, forKey: .format) ?? ""
    height = try container.decodeIfPresent(Int.self, forKey: .height) ?? 0
    width = try container.decodeIfPresent(Int.self, forKey: .width) ?? 0
  }

  enum CodingKeys: String, CodingKey {
    case url, format, height, width
  }

}
