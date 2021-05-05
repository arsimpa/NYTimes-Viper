//
//  ArticleTest.swift
//  NYTimes-ViperTests
//
//  Created by Arsalan Khan on 04/05/2021.
//

import XCTest
@testable import NYTimes_Viper

class ArticleTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testArticle() throws {
        
        let article = Article(uri: "nyt://article/1643bc57-7da3-5dd1-becd-263b5dddfe7b"
                              , url: "https://www.nytimes.com/2021/05/02/science/spacex-nasa-landing.html",
                              id: 100000007741092,
                              assetId: 100000007741092,
                              source: "New York Times",
                              publishedDate: "2021-05-02",
                              updated: "2021-05-03 03:32:28",
                              section: "Science",
                              subsection: "",
                              nytdsection: "science",
                              adxKeywords: "Private Spaceflight;Rocket Science and Propulsion;International Space Station;Space and Astronomy;Space Exploration Technologies Corp;National Aeronautics and Space Administration;Gulf of Mexico;Florida;Panama City (Panama)",
                              byline: "By Kenneth Chang",
                              type: "Article",
                              title: "SpaceX Makes First Nighttime Splashdown With Astronauts Since 1968",
                              abstract: "Crew-1, which launched to the space station in November, left the space station in the capsule called Resilience.",
                              desFacet:
                                ["Private Spaceflight",
                                 "Rocket Science and Propulsion",
                                 "International Space Station","Space and Astronomy"
                                ],
                              orgFacet:
                                ["Space Exploration Technologies Corp",
                                 "National Aeronautics and Space Administration"],
                              perFacet: [],
                              geoFacet:
                                ["Gulf of Mexico",
                                 "Florida",
                                 "Panama City (Panama)"],
                              media: [Media(type:"image",
                                            subtype: "photo",
                                            caption: "Support teams work around the SpaceX Crew Dragon Resilience spacecraft shortly after it landed off the coast of Panama City, Fla.",
                                            copyright: "Bill Ingalls/NASA, via Associated Press",
                                            approvedForSyndication: 1,
                                            mediaMetadata: [MediaMetadatum(url: "https://static01.nyt.com/images/2021/05/02/multimedia/02astronauts1/02astronauts1-thumbStandard.jpg",
                                                                           format: "Standard Thumbnail",
                                                                           height: 75,
                                                                           width: 75)])],
                              etaId: 0)
        
        XCTAssertNotNil(article)
        XCTAssertEqual(article.uri, "nyt://article/1643bc57-7da3-5dd1-becd-263b5dddfe7b")
        XCTAssertEqual(article.url, "https://www.nytimes.com/2021/05/02/science/spacex-nasa-landing.html")
        XCTAssertEqual(article.id, 100000007741092)
        XCTAssertEqual(article.assetId, 100000007741092)
        XCTAssertEqual(article.source, "New York Times")
        XCTAssertEqual(article.publishedDate, "2021-05-02")
        XCTAssertEqual(article.updated, "2021-05-03 03:32:28")
        XCTAssertEqual(article.section, "Science")
        
    }

}
