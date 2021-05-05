//
//  Settings.swift
//  NYTimes-ViperTests
//
//  Created by Arsalan Khan on 05/05/2021.
//

import XCTest
@testable import NYTimes_Viper

class APITest: XCTestCase {

    var client:  HttpClient!
    let mockSession = MockURLSession()
    
    override func setUp() {
        client = HttpClient(baseUrl: BASE_URL, session: mockSession)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testBaseUrl() {
                
        XCTAssertFalse(BASE_URL.isEmpty)
        XCTAssertEqual(BASE_URL, "https://api.nytimes.com/")
    }
    
    func testGetArticlesWithExpectedURLHostAndPath() {
        
        let expectedData = "{}".data(using: .utf8)
        
        mockSession.nextData = expectedData
        
        let path = "svc/mostpopular/v2/viewed/7.json"
                
        client.request(path: path, method: .get, params: [:]) { (data, err) in  }
        
        var url = BASE_URL.replacingOccurrences(of: "https://", with: "")
        url.removeLast()
        
        XCTAssertEqual(mockSession.lastURL?.host, url)
        XCTAssertEqual(mockSession.lastURL?.path, "/" + path)
    }
    
    func testGetArticlesWithExpectedData() {
        
        let expectedData = expectedResponse.data(using: .utf8)
        
        mockSession.nextData = expectedData
        
        let path = "svc/mostpopular/v2/viewed/7.json"
        
        var actualData: Data?
        
        client.request(path: path, method: .get, params: [:]) { (data, err) in
            actualData = data as? Data
        }
        
        XCTAssertNotNil(actualData)
        XCTAssertEqual(actualData, expectedData)
    }
    
    func testGetarticlesWithParsedData() {
        
        var articlesResponse: ArticleResponse?
        
        let articlesExpectation = expectation(description: "articles")
        
        let worker = ArticleListFetchWorker(client: HttpClient(baseUrl: BASE_URL, session: URLSession.shared))
        worker.fetchArticles(.sevenDay) { (resp, err) in
            articlesResponse = resp
            articlesExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 10) { (err) in
            XCTAssertNotNil(articlesResponse)
        }
    }

}


let expectedResponse = """
                    {
                        "status": "OK",
                        "copyright": "Copyright (c) 2021 The New York Times Company.  All Rights Reserved.",
                        "num_results": 20,
                        "results": [
                            {
                                "uri": "nyt://article/1da25252-b37a-5df8-a733-25aed31bc8df",
                                "url": "https://www.nytimes.com/2021/04/28/nyregion/rudy-giuliani-trump-ukraine-warrant.html",
                                "id": 100000007651598,
                                "asset_id": 100000007651598,
                                "source": "New York Times",
                                "published_date": "2021-04-28",
                                "updated": "2021-05-04 15:19:08",
                                "section": "New York",
                                "subsection": "",
                                "nytdsection": "new york",
                                "adx_keywords": "Trump-Ukraine Whistle-Blower Complaint and Impeachment Inquiry;Trump, Donald J;Giuliani, Rudolph W;Justice Department",
                                "column": null,
                                "byline": "By William K. Rashbaum, Ben Protess, Maggie Haberman and Kenneth P. Vogel",
                                "type": "Article",
                                "title": "F.B.I. Searches Giuliani’s Home and Office, Seizing Phones and Computers",
                                "abstract": "Prosecutors obtained the search warrants as part of an investigation into whether Rudy Giuliani broke lobbying laws when he was President Donald J. Trump’s personal lawyer.",
                                "des_facet": [
                                    "Trump-Ukraine Whistle-Blower Complaint and Impeachment Inquiry"
                                ],
                                "org_facet": [
                                    "Justice Department"
                                ],
                                "per_facet": [
                                    "Trump, Donald J",
                                    "Giuliani, Rudolph W"
                                ],
                                "geo_facet": [],
                                "media": [
                                    {
                                        "type": "image",
                                        "subtype": "photo",
                                        "caption": "The search warrants mark a major development in the long-running investigation against Rudolph Giuliani.",
                                        "copyright": "Doug Mills/The New York Times",
                                        "approved_for_syndication": 1,
                                        "media-metadata": [
                                            {
                                                "url": "https://static01.nyt.com/images/2021/04/28/us/00ny-rudy-warrant-TOP-SWAP/00ny-rudy-warrant-TOP-SWAP-thumbStandard.jpg",
                                                "format": "Standard Thumbnail",
                                                "height": 75,
                                                "width": 75
                                            },
                                            {
                                                "url": "https://static01.nyt.com/images/2021/04/28/us/00ny-rudy-warrant-TOP-SWAP/00ny-rudy-warrant-TOP-SWAP-mediumThreeByTwo210.jpg",
                                                "format": "mediumThreeByTwo210",
                                                "height": 140,
                                                "width": 210
                                            },
                                            {
                                                "url": "https://static01.nyt.com/images/2021/04/28/us/00ny-rudy-warrant-TOP-SWAP/00ny-rudy-warrant-TOP-SWAP-mediumThreeByTwo440.jpg",
                                                "format": "mediumThreeByTwo440",
                                                "height": 293,
                                                "width": 440
                                            }
                                        ]
                                    }
                                ],
                                "eta_id": 0
                            },
                            {
                                "uri": "nyt://article/6ef0cca1-67d9-5aff-a55c-f1c6a9416b7f",
                                "url": "https://www.nytimes.com/2021/05/03/health/covid-herd-immunity-vaccine.html",
                                "id": 100000007725405,
                                "asset_id": 100000007725405,
                                "source": "New York Times",
                                "published_date": "2021-05-03",
                                "updated": "2021-05-04 15:42:24",
                                "section": "Health",
                                "subsection": "",
                                "nytdsection": "health",
                                "adx_keywords": "your-feed-science;Disease Rates;Coronavirus (2019-nCoV);Epidemics;Vaccination and Immunization;United States",
                                "column": null,
                                "byline": "By Apoorva Mandavilli",
                                "type": "Article",
                                "title": "Reaching ‘Herd Immunity’ Is Unlikely in the U.S., Experts Now Believe",
                                "abstract": "Widely circulating coronavirus variants and persistent hesitancy about vaccines will keep the goal out of reach. The virus is here to stay, but vaccinating the most vulnerable may be enough to restore normalcy.",
                                "des_facet": [
                                    "your-feed-science",
                                    "Disease Rates",
                                    "Coronavirus (2019-nCoV)",
                                    "Epidemics",
                                    "Vaccination and Immunization"
                                ],
                                "org_facet": [],
                                "per_facet": [],
                                "geo_facet": [
                                    "United States"
                                ],
                                "media": [
                                    {
                                        "type": "image",
                                        "subtype": "photo",
                                        "caption": "Vaccinations at the American Airlines Arena in Miami on Thursday. Though there is consensus among scientists and public health experts that the herd immunity threshold is not attainable, it may not be all bad news.",
                                        "copyright": "Saul Martinez for The New York Times",
                                        "approved_for_syndication": 1,
                                        "media-metadata": [
                                            {
                                                "url": "https://static01.nyt.com/images/2021/05/02/science/01VIRUS-HERDIMMUNITY1/01VIRUS-HERDIMMUNITY1-thumbStandard.jpg",
                                                "format": "Standard Thumbnail",
                                                "height": 75,
                                                "width": 75
                                            },
                                            {
                                                "url": "https://static01.nyt.com/images/2021/05/02/science/01VIRUS-HERDIMMUNITY1/01VIRUS-HERDIMMUNITY1-mediumThreeByTwo210.jpg",
                                                "format": "mediumThreeByTwo210",
                                                "height": 140,
                                                "width": 210
                                            },
                                            {
                                                "url": "https://static01.nyt.com/images/2021/05/02/science/01VIRUS-HERDIMMUNITY1/01VIRUS-HERDIMMUNITY1-mediumThreeByTwo440.jpg",
                                                "format": "mediumThreeByTwo440",
                                                "height": 293,
                                                "width": 440
                                            }
                                        ]
                                    }
                                ],
                                "eta_id": 0
                            },
                            {
                                "uri": "nyt://article/b9a3a1eb-05d5-5452-8062-811f3f74b4ec",
                                "url": "https://www.nytimes.com/2021/04/29/style/rachel-hollis-tiktok-video.html",
                                "id": 100000007699332,
                                "asset_id": 100000007699332,
                                "source": "New York Times",
                                "published_date": "2021-04-29",
                                "updated": "2021-04-30 09:33:56",
                                "section": "Style",
                                "subsection": "",
                                "nytdsection": "style",
                                "adx_keywords": "Social Media;Content Type: Personal Profile;Race and Ethnicity;Hollis, Rachel (1983- );Hollis Co",
                                "column": null,
                                "byline": "By Katherine Rosman",
                                "type": "Article",
                                "title": "Girl, Wash Your Timeline",
                                "abstract": "Rachel Hollis, the best-selling author and motivational speaker, built a blockbuster business sharing her “authentic” self. Then things got a little too real.",
                                "des_facet": [
                                    "Social Media",
                                    "Content Type: Personal Profile",
                                    "Race and Ethnicity"
                                ],
                                "org_facet": [
                                    "Hollis Co"
                                ],
                                "per_facet": [
                                    "Hollis, Rachel (1983- )"
                                ],
                                "geo_facet": [],
                                "media": [
                                    {
                                        "type": "image",
                                        "subtype": "photo",
                                        "caption": "Rachel Hollis at a New York City press appearance for her book &ldquo;Girl, Stop Apologizing&rdquo; in 2019.",
                                        "copyright": "Nicholas Hunt/Getty Images",
                                        "approved_for_syndication": 1,
                                        "media-metadata": [
                                            {
                                                "url": "https://static01.nyt.com/images/2021/04/29/fashion/28RACHELHOLLIS-1/28RACHELHOLLIS-1-thumbStandard.jpg",
                                                "format": "Standard Thumbnail",
                                                "height": 75,
                                                "width": 75
                                            },
                                            {
                                                "url": "https://static01.nyt.com/images/2021/04/29/fashion/28RACHELHOLLIS-1/28RACHELHOLLIS-1-mediumThreeByTwo210-v5.jpg",
                                                "format": "mediumThreeByTwo210",
                                                "height": 140,
                                                "width": 210
                                            },
                                            {
                                                "url": "https://static01.nyt.com/images/2021/04/29/fashion/28RACHELHOLLIS-1/28RACHELHOLLIS-1-mediumThreeByTwo440-v5.jpg",
                                                "format": "mediumThreeByTwo440",
                                                "height": 293,
                                                "width": 440
                                            }
                                        ]
                                    }
                                ],
                                "eta_id": 0
                            },
                            {
                                "uri": "nyt://article/8116b7ad-99b1-50fd-8751-b81056e2c00d",
                                "url": "https://www.nytimes.com/2021/05/03/business/bill-melinda-gates-divorce.html",
                                "id": 100000007743248,
                                "asset_id": 100000007743248,
                                "source": "New York Times",
                                "published_date": "2021-05-03",
                                "updated": "2021-05-05 09:08:40",
                                "section": "Business",
                                "subsection": "",
                                "nytdsection": "business",
                                "adx_keywords": "Philanthropy;Coronavirus (2019-nCoV);Divorce, Separations and Annulments;internal-storyline-no;Gates, Bill;Gates, Melinda;Gates, Bill and Melinda, Foundation;Microsoft Corp",
                                "column": null,
                                "byline": "By David Gelles, Andrew Ross Sorkin and Nicholas Kulish",
                                "type": "Article",
                                "title": "Bill and Melinda Gates Are Divorcing After 27 Years of Marriage",
                                "abstract": "The announcement raises questions about the fate of their fortune. The couple helped create the Giving Pledge, but much of his Microsoft money has not yet been donated.",
                                "des_facet": [
                                    "Philanthropy",
                                    "Coronavirus (2019-nCoV)",
                                    "Divorce, Separations and Annulments",
                                    "internal-storyline-no"
                                ],
                                "org_facet": [
                                    "Gates, Bill and Melinda, Foundation",
                                    "Microsoft Corp"
                                ],
                                "per_facet": [
                                    "Gates, Bill",
                                    "Gates, Melinda"
                                ],
                                "geo_facet": [],
                                "media": [
                                    {
                                        "type": "image",
                                        "subtype": "photo",
                                        "caption": "Bill and Melinda Gates in 2018. They &ldquo;no longer believe we can grow together as a couple in this next phase of our lives,&rdquo; they said in a statement.",
                                        "copyright": "Ludovic Marin/Agence France-Presse &mdash; Getty Images",
                                        "approved_for_syndication": 1,
                                        "media-metadata": [
                                            {
                                                "url": "https://static01.nyt.com/images/2021/05/05/business/03gates-02/03gates-02-thumbStandard.jpg",
                                                "format": "Standard Thumbnail",
                                                "height": 75,
                                                "width": 75
                                            },
                                            {
                                                "url": "https://static01.nyt.com/images/2021/05/05/business/03gates-02/03gates-02-mediumThreeByTwo210.jpg",
                                                "format": "mediumThreeByTwo210",
                                                "height": 140,
                                                "width": 210
                                            },
                                            {
                                                "url": "https://static01.nyt.com/images/2021/05/05/business/03gates-02/03gates-02-mediumThreeByTwo440.jpg",
                                                "format": "mediumThreeByTwo440",
                                                "height": 293,
                                                "width": 440
                                            }
                                        ]
                                    }
                                ],
                                "eta_id": 0
                            },
                            {
                                "uri": "nyt://article/f4f1565b-88f0-5e22-b890-adcdc3fdc06b",
                                "url": "https://www.nytimes.com/2021/04/29/arts/disaster-girl-meme-nft.html",
                                "id": 100000007734465,
                                "asset_id": 100000007734465,
                                "source": "New York Times",
                                "published_date": "2021-04-29",
                                "updated": "2021-05-01 12:02:08",
                                "section": "Arts",
                                "subsection": "",
                                "nytdsection": "arts",
                                "adx_keywords": "Nonfungible Tokens (NFTs);Virtual Currency;Auctions;Content Type: Personal Profile;Computers and the Internet;Philanthropy;Social Media;Photography;Art;Roth, Zoe (2000- )",
                                "column": null,
                                "byline": "By Marie Fazio",
                                "type": "Article",
                                "title": "The World Knows Her as ‘Disaster Girl.’ She Just Made $500,000 Off the Meme.",
                                "abstract": "Zoë Roth, now a college senior in North Carolina, plans to use the proceeds from this month’s NFT auction to pay off student loans and donate to charity.",
                                "des_facet": [
                                    "Nonfungible Tokens (NFTs)",
                                    "Virtual Currency",
                                    "Auctions",
                                    "Content Type: Personal Profile",
                                    "Computers and the Internet",
                                    "Philanthropy",
                                    "Social Media",
                                    "Photography",
                                    "Art"
                                ],
                                "org_facet": [],
                                "per_facet": [
                                    "Roth, Zoe (2000- )"
                                ],
                                "geo_facet": [],
                                "media": [
                                    {
                                        "type": "image",
                                        "subtype": "photo",
                                        "caption": "&ldquo;Disaster Girl&rdquo;",
                                        "copyright": "Dave Roth",
                                        "approved_for_syndication": 1,
                                        "media-metadata": [
                                            {
                                                "url": "https://static01.nyt.com/images/2021/04/30/multimedia/30xp-meme/29xp-meme-thumbStandard-v5.jpg",
                                                "format": "Standard Thumbnail",
                                                "height": 75,
                                                "width": 75
                                            },
                                            {
                                                "url": "https://static01.nyt.com/images/2021/04/30/multimedia/30xp-meme/29xp-meme-mediumThreeByTwo210-v5.jpg",
                                                "format": "mediumThreeByTwo210",
                                                "height": 140,
                                                "width": 210
                                            },
                                            {
                                                "url": "https://static01.nyt.com/images/2021/04/30/multimedia/30xp-meme/29xp-meme-mediumThreeByTwo440-v5.jpg",
                                                "format": "mediumThreeByTwo440",
                                                "height": 293,
                                                "width": 440
                                            }
                                        ]
                                    }
                                ],
                                "eta_id": 0
                            },
                            {
                                "uri": "nyt://article/11fb43c2-a754-5f02-aecf-cb7244acb75d",
                                "url": "https://www.nytimes.com/2021/04/19/well/mind/covid-mental-health-languishing.html",
                                "id": 100000007694130,
                                "asset_id": 100000007694130,
                                "source": "New York Times",
                                "published_date": "2021-04-19",
                                "updated": "2021-05-04 12:27:46",
                                "section": "Well",
                                "subsection": "Mind",
                                "nytdsection": "well",
                                "adx_keywords": "Mental Health and Disorders;Anxiety and Stress;Loneliness;Depression (Mental);Grief (Emotion);Psychology and Psychologists;Coronavirus (2019-nCoV);Quarantine (Life and Culture);Content Type: Service",
                                "column": null,
                                "byline": "By Adam Grant",
                                "type": "Article",
                                "title": "There’s a Name for the Blah You’re Feeling: It’s Called Languishing",
                                "abstract": "The neglected middle child of mental health can dull your motivation and focus — and it may be the dominant emotion of 2021.",
                                "des_facet": [
                                    "Mental Health and Disorders",
                                    "Anxiety and Stress",
                                    "Loneliness",
                                    "Depression (Mental)",
                                    "Grief (Emotion)",
                                    "Psychology and Psychologists",
                                    "Coronavirus (2019-nCoV)",
                                    "Quarantine (Life and Culture)",
                                    "Content Type: Service"
                                ],
                                "org_facet": [],
                                "per_facet": [],
                                "geo_facet": [],
                                "media": [
                                    {
                                        "type": "image",
                                        "subtype": "photo",
                                        "caption": "",
                                        "copyright": "Manshen Lo",
                                        "approved_for_syndication": 1,
                                        "media-metadata": [
                                            {
                                                "url": "https://static01.nyt.com/images/2021/04/16/well/00well-languishing/00well-languishing-thumbStandard-v2.png",
                                                "format": "Standard Thumbnail",
                                                "height": 75,
                                                "width": 75
                                            },
                                            {
                                                "url": "https://static01.nyt.com/images/2021/04/16/well/00well-languishing/00well-languishing-mediumThreeByTwo210-v2.png",
                                                "format": "mediumThreeByTwo210",
                                                "height": 140,
                                                "width": 210
                                            },
                                            {
                                                "url": "https://static01.nyt.com/images/2021/04/16/well/00well-languishing/00well-languishing-mediumThreeByTwo440-v2.png",
                                                "format": "mediumThreeByTwo440",
                                                "height": 293,
                                                "width": 440
                                            }
                                        ]
                                    }
                                ],
                                "eta_id": 0
                            },
                            {
                                "uri": "nyt://interactive/cba553d7-2ebc-597f-bd74-de3f617296e0",
                                "url": "https://www.nytimes.com/interactive/2014/upshot/dialect-quiz-map.html",
                                "id": 100000002615736,
                                "asset_id": 100000002615736,
                                "source": "New York Times",
                                "published_date": "2013-12-21",
                                "updated": "2020-11-03 18:17:18",
                                "section": "The Upshot",
                                "subsection": "",
                                "nytdsection": "the upshot",
                                "adx_keywords": "Language and Languages;English Language",
                                "column": null,
                                "byline": "By Josh Katz and Wilson Andrews",
                                "type": "Interactive",
                                "title": "How Y’all, Youse and You Guys Talk",
                                "abstract": "What does the way you speak say about where you’re from? Answer all the questions below to see your personal dialect map.",
                                "des_facet": [
                                    "Language and Languages",
                                    "English Language"
                                ],
                                "org_facet": [],
                                "per_facet": [],
                                "geo_facet": [],
                                "media": [
                                    {
                                        "type": "image",
                                        "subtype": "",
                                        "caption": "",
                                        "copyright": "",
                                        "approved_for_syndication": 0,
                                        "media-metadata": [
                                            {
                                                "url": "https://static01.nyt.com/images/2016/11/24/us/map-dialect/map-dialect-thumbStandard-v2.png",
                                                "format": "Standard Thumbnail",
                                                "height": 75,
                                                "width": 75
                                            },
                                            {
                                                "url": "https://static01.nyt.com/images/2016/11/24/us/map-dialect/map-dialect-mediumThreeByTwo210-v2.png",
                                                "format": "mediumThreeByTwo210",
                                                "height": 140,
                                                "width": 210
                                            },
                                            {
                                                "url": "https://static01.nyt.com/images/2016/11/24/us/map-dialect/map-dialect-mediumThreeByTwo440-v2.png",
                                                "format": "mediumThreeByTwo440",
                                                "height": 293,
                                                "width": 440
                                            }
                                        ]
                                    }
                                ],
                                "eta_id": 0
                            },
                            {
                                "uri": "nyt://article/72504172-8616-57f9-89d0-adf56297f66a",
                                "url": "https://www.nytimes.com/2021/04/29/us/politics/supreme-court-article-a.html",
                                "id": 100000007736902,
                                "asset_id": 100000007736902,
                                "source": "New York Times",
                                "published_date": "2021-04-29",
                                "updated": "2021-04-30 12:01:27",
                                "section": "U.S.",
                                "subsection": "Politics",
                                "nytdsection": "u.s.",
                                "adx_keywords": "Deportation;Immigration and Emigration;United States Politics and Government;English Language;Law and Legislation;Decisions and Verdicts;Illegal Immigration;Supreme Court (US)",
                                "column": null,
                                "byline": "By Adam Liptak",
                                "type": "Article",
                                "title": "A Sharp Divide at the Supreme Court Over a One-Letter Word",
                                "abstract": "In an immigration ruling that scrambled the usual alliances, the justices differed over the significance of the article “a.”",
                                "des_facet": [
                                    "Deportation",
                                    "Immigration and Emigration",
                                    "United States Politics and Government",
                                    "English Language",
                                    "Law and Legislation",
                                    "Decisions and Verdicts",
                                    "Illegal Immigration"
                                ],
                                "org_facet": [
                                    "Supreme Court (US)"
                                ],
                                "per_facet": [],
                                "geo_facet": [],
                                "media": [
                                    {
                                        "type": "image",
                                        "subtype": "photo",
                                        "caption": "The 6-3 decision featured unusual alliances between the Supreme Court Justices.",
                                        "copyright": "Erin Schaff/The New York Times",
                                        "approved_for_syndication": 1,
                                        "media-metadata": [
                                            {
                                                "url": "https://static01.nyt.com/images/2021/04/29/us/politics/29dc-scotus/merlin_186813225_10eb6d0e-5070-430a-b905-c8a47fc4dbc5-thumbStandard.jpg",
                                                "format": "Standard Thumbnail",
                                                "height": 75,
                                                "width": 75
                                            },
                                            {
                                                "url": "https://static01.nyt.com/images/2021/04/29/us/politics/29dc-scotus/merlin_186813225_10eb6d0e-5070-430a-b905-c8a47fc4dbc5-mediumThreeByTwo210.jpg",
                                                "format": "mediumThreeByTwo210",
                                                "height": 140,
                                                "width": 210
                                            },
                                            {
                                                "url": "https://static01.nyt.com/images/2021/04/29/us/politics/29dc-scotus/merlin_186813225_10eb6d0e-5070-430a-b905-c8a47fc4dbc5-mediumThreeByTwo440.jpg",
                                                "format": "mediumThreeByTwo440",
                                                "height": 293,
                                                "width": 440
                                            }
                                        ]
                                    }
                                ],
                                "eta_id": 0
                            },
                            {
                                "uri": "nyt://article/5e9387b7-a564-5256-a4c3-05e48c2993e3",
                                "url": "https://www.nytimes.com/2021/04/27/us/mario-gonzalez-alameda-police.html",
                                "id": 100000007733886,
                                "asset_id": 100000007733886,
                                "source": "New York Times",
                                "published_date": "2021-04-27",
                                "updated": "2021-04-28 15:42:17",
                                "section": "U.S.",
                                "subsection": "",
                                "nytdsection": "u.s.",
                                "adx_keywords": "Police Brutality, Misconduct and Shootings;Murders, Attempted Murders and Homicides;Gonzalez, Mario Arenales (d 2021);Alameda (Calif);Alameda County (Calif)",
                                "column": null,
                                "byline": "By Will Wright",
                                "type": "Article",
                                "title": "California Man Dies After Officers Pin Him to Ground for 5 Minutes",
                                "abstract": "The death of Mario Arenales Gonzalez came one day before a former Minneapolis officer was convicted of murdering George Floyd. Body camera footage was released on Tuesday.",
                                "des_facet": [
                                    "Police Brutality, Misconduct and Shootings",
                                    "Murders, Attempted Murders and Homicides"
                                ],
                                "org_facet": [],
                                "per_facet": [
                                    "Gonzalez, Mario Arenales (d 2021)"
                                ],
                                "geo_facet": [
                                    "Alameda (Calif)",
                                    "Alameda County (Calif)"
                                ],
                                "media": [
                                    {
                                        "type": "image",
                                        "subtype": "photo",
                                        "caption": "A screenshot from body camera footage of Mario Arenales Gonzalez, who died in police custody in Alameda, Calif., last week.",
                                        "copyright": "Alameda Police Department",
                                        "approved_for_syndication": 1,
                                        "media-metadata": [
                                            {
                                                "url": "https://static01.nyt.com/images/2021/04/27/us/27alameda-killing-02/27alameda-killing-02-thumbStandard.jpg",
                                                "format": "Standard Thumbnail",
                                                "height": 75,
                                                "width": 75
                                            },
                                            {
                                                "url": "https://static01.nyt.com/images/2021/04/27/us/27alameda-killing-02/27alameda-killing-02-mediumThreeByTwo210.jpg",
                                                "format": "mediumThreeByTwo210",
                                                "height": 140,
                                                "width": 210
                                            },
                                            {
                                                "url": "https://static01.nyt.com/images/2021/04/27/us/27alameda-killing-02/27alameda-killing-02-mediumThreeByTwo440.jpg",
                                                "format": "mediumThreeByTwo440",
                                                "height": 293,
                                                "width": 440
                                            }
                                        ]
                                    }
                                ],
                                "eta_id": 0
                            },
                            {
                                "uri": "nyt://article/3ef37c59-8926-555b-a0e2-202671d919ff",
                                "url": "https://www.nytimes.com/2021/04/29/world/middleeast/israel-mount-meron-stampede.html",
                                "id": 100000007738010,
                                "asset_id": 100000007738010,
                                "source": "New York Times",
                                "published_date": "2021-04-29",
                                "updated": "2021-05-05 10:21:11",
                                "section": "World",
                                "subsection": "Middle East",
                                "nytdsection": "world",
                                "adx_keywords": "Stampedes;Deaths (Fatalities);Israel;Mount Meron (Israel)",
                                "column": null,
                                "byline": "By Isabel Kershner, Eric Nagourney and Mike Ives",
                                "type": "Article",
                                "title": "Stampede at Israel Religious Celebration Kills at Least 45",
                                "abstract": "An estimated 100,000 people had gathered on Mount Meron to celebrate a religious holiday. Prime Minister Benjamin Netanyahu called it a “terrible disaster.”",
                                "des_facet": [
                                    "Stampedes",
                                    "Deaths (Fatalities)"
                                ],
                                "org_facet": [],
                                "per_facet": [],
                                "geo_facet": [
                                    "Israel",
                                    "Mount Meron (Israel)"
                                ],
                                "media": [
                                    {
                                        "type": "image",
                                        "subtype": "photo",
                                        "caption": "The stampede at the Lag b’Omer celebration early Friday was one of the worst civilian disasters in Israeli history.",
                                        "copyright": "Jack Guez/Agence France-Presse — Getty Images",
                                        "approved_for_syndication": 1,
                                        "media-metadata": [
                                            {
                                                "url": "https://static01.nyt.com/images/2021/05/29/world/29israel-stampede-6/29israel-stampede-6-thumbStandard.jpg",
                                                "format": "Standard Thumbnail",
                                                "height": 75,
                                                "width": 75
                                            },
                                            {
                                                "url": "https://static01.nyt.com/images/2021/05/29/world/29israel-stampede-6/29israel-stampede-6-mediumThreeByTwo210.jpg",
                                                "format": "mediumThreeByTwo210",
                                                "height": 140,
                                                "width": 210
                                            },
                                            {
                                                "url": "https://static01.nyt.com/images/2021/05/29/world/29israel-stampede-6/29israel-stampede-6-mediumThreeByTwo440.jpg",
                                                "format": "mediumThreeByTwo440",
                                                "height": 293,
                                                "width": 440
                                            }
                                        ]
                                    }
                                ],
                                "eta_id": 0
                            },
                            {
                                "uri": "nyt://article/5b1b49ec-c997-5eba-8588-ac46328fa739",
                                "url": "https://www.nytimes.com/2021/04/27/world/asia/India-delhi-covid-cases.html",
                                "id": 100000007729031,
                                "asset_id": 100000007729031,
                                "source": "New York Times",
                                "published_date": "2021-04-27",
                                "updated": "2021-04-29 10:40:23",
                                "section": "World",
                                "subsection": "Asia Pacific",
                                "nytdsection": "world",
                                "adx_keywords": "Coronavirus (2019-nCoV);Politics and Government;Disease Rates;Modi, Narendra;India;New Delhi (India);Delhi (India)",
                                "column": null,
                                "byline": "By Jeffrey Gettleman and Atul Loke",
                                "type": "Article",
                                "title": "‘This Is a Catastrophe.’ In India, Illness Is Everywhere.",
                                "abstract": "As India suffers the world’s worst coronavirus crisis, our New Delhi bureau chief describes the fear of living amid a disease spreading at such scale and speed.",
                                "des_facet": [
                                    "Coronavirus (2019-nCoV)",
                                    "Politics and Government",
                                    "Disease Rates"
                                ],
                                "org_facet": [],
                                "per_facet": [
                                    "Modi, Narendra"
                                ],
                                "geo_facet": [
                                    "India",
                                    "New Delhi (India)",
                                    "Delhi (India)"
                                ],
                                "media": [
                                    {
                                        "type": "image",
                                        "subtype": "photo",
                                        "caption": "A crematorium ground for Covid-19 victims in East Delhi, on Friday.",
                                        "copyright": "Atul Loke for The New York Times",
                                        "approved_for_syndication": 1,
                                        "media-metadata": [
                                            {
                                                "url": "https://static01.nyt.com/images/2021/04/26/world/00virus-india-dispatch-promo/00virus-india-dispatch-promo-thumbStandard.jpg",
                                                "format": "Standard Thumbnail",
                                                "height": 75,
                                                "width": 75
                                            },
                                            {
                                                "url": "https://static01.nyt.com/images/2021/04/26/world/00virus-india-dispatch-promo/merlin_186812691_eff259bb-dcaa-448c-a995-218b4b41f6de-mediumThreeByTwo210.jpg",
                                                "format": "mediumThreeByTwo210",
                                                "height": 140,
                                                "width": 210
                                            },
                                            {
                                                "url": "https://static01.nyt.com/images/2021/04/26/world/00virus-india-dispatch-promo/merlin_186812691_eff259bb-dcaa-448c-a995-218b4b41f6de-mediumThreeByTwo440.jpg",
                                                "format": "mediumThreeByTwo440",
                                                "height": 293,
                                                "width": 440
                                            }
                                        ]
                                    }
                                ],
                                "eta_id": 0
                            },
                            {
                                "uri": "nyt://article/9175e9f9-0ae6-56cd-8938-b59305e22912",
                                "url": "https://www.nytimes.com/2021/04/29/sports/football/nfl-draft-order-picks-tracker.html",
                                "id": 100000007734775,
                                "asset_id": 100000007734775,
                                "source": "New York Times",
                                "published_date": "2021-04-29",
                                "updated": "2021-04-30 09:17:37",
                                "section": "Sports",
                                "subsection": "N.F.L.",
                                "nytdsection": "sports",
                                "adx_keywords": "Draft and Recruitment (Sports);Football;National Football League",
                                "column": null,
                                "byline": "By The New York Times",
                                "type": "Article",
                                "title": "N.F.L. draft order and picks: Here are the first round results.",
                                "abstract": "Trevor Lawrence was taken with the first pick by the Jacksonville Jaguars.",
                                "des_facet": [
                                    "Draft and Recruitment (Sports)",
                                    "Football"
                                ],
                                "org_facet": [
                                    "National Football League"
                                ],
                                "per_facet": [],
                                "geo_facet": [],
                                "media": [
                                    {
                                        "type": "image",
                                        "subtype": "photo",
                                        "caption": "Trevor Lawrence was picked first by the Jacksonville Jaguars.",
                                        "copyright": "David J. Phillip/Associated Press",
                                        "approved_for_syndication": 1,
                                        "media-metadata": [
                                            {
                                                "url": "https://static01.nyt.com/images/2021/04/29/sports/29draft-tracker-lawrence/29draft-tracker-lawrence-thumbStandard.jpg",
                                                "format": "Standard Thumbnail",
                                                "height": 75,
                                                "width": 75
                                            },
                                            {
                                                "url": "https://static01.nyt.com/images/2021/04/29/sports/29draft-tracker-lawrence/29draft-tracker-lawrence-mediumThreeByTwo210.jpg",
                                                "format": "mediumThreeByTwo210",
                                                "height": 140,
                                                "width": 210
                                            },
                                            {
                                                "url": "https://static01.nyt.com/images/2021/04/29/sports/29draft-tracker-lawrence/29draft-tracker-lawrence-mediumThreeByTwo440.jpg",
                                                "format": "mediumThreeByTwo440",
                                                "height": 293,
                                                "width": 440
                                            }
                                        ]
                                    }
                                ],
                                "eta_id": 0
                            },
                            {
                                "uri": "nyt://article/89ba42b5-017e-5664-a8d7-007192100503",
                                "url": "https://www.nytimes.com/2021/04/27/well/eat/alcohol-covid-vaccine.html",
                                "id": 100000007722506,
                                "asset_id": 100000007722506,
                                "source": "New York Times",
                                "published_date": "2021-04-27",
                                "updated": "2021-05-04 01:03:14",
                                "section": "Well",
                                "subsection": "Eat",
                                "nytdsection": "well",
                                "adx_keywords": "Alcoholic Beverages;Content Type: Service;Immune System;Vaccination and Immunization;Coronavirus (2019-nCoV)",
                                "column": null,
                                "byline": "By Anahad O’Connor",
                                "type": "Article",
                                "title": "Can You Have Alcohol After the Covid Vaccine?",
                                "abstract": "Moderate drinking is unlikely to impair the immune response to the Covid vaccine, but heavy drinking might.",
                                "des_facet": [
                                    "Alcoholic Beverages",
                                    "Content Type: Service",
                                    "Immune System",
                                    "Vaccination and Immunization",
                                    "Coronavirus (2019-nCoV)"
                                ],
                                "org_facet": [],
                                "per_facet": [],
                                "geo_facet": [],
                                "media": [
                                    {
                                        "type": "image",
                                        "subtype": "photo",
                                        "caption": "",
                                        "copyright": "Tony Cenicola/The New York Times",
                                        "approved_for_syndication": 1,
                                        "media-metadata": [
                                            {
                                                "url": "https://static01.nyt.com/images/2021/05/04/well/askwell-wine/merlin_161506203_0c27f239-661f-4a08-8ee9-3149877e7a9f-thumbStandard.jpg",
                                                "format": "Standard Thumbnail",
                                                "height": 75,
                                                "width": 75
                                            },
                                            {
                                                "url": "https://static01.nyt.com/images/2021/05/04/well/askwell-wine/merlin_161506203_0c27f239-661f-4a08-8ee9-3149877e7a9f-mediumThreeByTwo210.jpg",
                                                "format": "mediumThreeByTwo210",
                                                "height": 140,
                                                "width": 210
                                            },
                                            {
                                                "url": "https://static01.nyt.com/images/2021/05/04/well/askwell-wine/merlin_161506203_0c27f239-661f-4a08-8ee9-3149877e7a9f-mediumThreeByTwo440.jpg",
                                                "format": "mediumThreeByTwo440",
                                                "height": 293,
                                                "width": 440
                                            }
                                        ]
                                    }
                                ],
                                "eta_id": 0
                            },
                            {
                                "uri": "nyt://article/43f5e547-5e90-54f6-866f-0dda9062a0ee",
                                "url": "https://www.nytimes.com/2021/04/29/style/cheugy.html",
                                "id": 100000007735714,
                                "asset_id": 100000007735714,
                                "source": "New York Times",
                                "published_date": "2021-04-29",
                                "updated": "2021-05-03 22:47:09",
                                "section": "Style",
                                "subsection": "",
                                "nytdsection": "style",
                                "adx_keywords": "Social Media;Slang;Millennial Generation;Language and Languages",
                                "column": null,
                                "byline": "By Taylor Lorenz",
                                "type": "Article",
                                "title": "What Is ‘Cheugy’? You Know It When You See It.",
                                "abstract": "Out of touch? Basic? A new term to describe a certain aesthetic is gaining popularity on TikTok.",
                                "des_facet": [
                                    "Social Media",
                                    "Slang",
                                    "Millennial Generation",
                                    "Language and Languages"
                                ],
                                "org_facet": [],
                                "per_facet": [],
                                "geo_facet": [],
                                "media": [
                                    {
                                        "type": "image",
                                        "subtype": "photo",
                                        "caption": "",
                                        "copyright": "@CheugLife",
                                        "approved_for_syndication": 0,
                                        "media-metadata": [
                                            {
                                                "url": "https://static01.nyt.com/images/2021/05/02/fashion/20CHEUGY-1/20CHEUGY-1-thumbStandard.jpg",
                                                "format": "Standard Thumbnail",
                                                "height": 75,
                                                "width": 75
                                            },
                                            {
                                                "url": "https://static01.nyt.com/images/2021/05/02/fashion/20CHEUGY-1/20CHEUGY-1-mediumThreeByTwo210.jpg",
                                                "format": "mediumThreeByTwo210",
                                                "height": 140,
                                                "width": 210
                                            },
                                            {
                                                "url": "https://static01.nyt.com/images/2021/05/02/fashion/20CHEUGY-1/20CHEUGY-1-mediumThreeByTwo440.jpg",
                                                "format": "mediumThreeByTwo440",
                                                "height": 293,
                                                "width": 440
                                            }
                                        ]
                                    }
                                ],
                                "eta_id": 0
                            },
                            {
                                "uri": "nyt://article/ebe52901-0154-59c4-80e2-63b07b9efc71",
                                "url": "https://www.nytimes.com/2021/04/27/business/media/new-york-post-kamala-harris.html",
                                "id": 100000007733783,
                                "asset_id": 100000007733783,
                                "source": "New York Times",
                                "published_date": "2021-04-27",
                                "updated": "2021-04-29 08:20:17",
                                "section": "Business",
                                "subsection": "Media",
                                "nytdsection": "business",
                                "adx_keywords": "News and News Media;Rumors and Misinformation;United States Politics and Government;Books and Literature;Illegal Immigration;Italiano, Laura (Journalist);Harris, Kamala D;Poole, Keith (Editor);New York Post;Fox News Channel",
                                "column": null,
                                "byline": "By Michael M. Grynbaum",
                                "type": "Article",
                                "title": "New York Post Reporter Who Wrote False Kamala Harris Story Resigns",
                                "abstract": "The front-page article in the Murdoch tabloid claimed that copies of a children’s book by the vice president were given to migrant children as part of a “welcome kit.”",
                                "des_facet": [
                                    "News and News Media",
                                    "Rumors and Misinformation",
                                    "United States Politics and Government",
                                    "Books and Literature",
                                    "Illegal Immigration"
                                ],
                                "org_facet": [
                                    "New York Post",
                                    "Fox News Channel"
                                ],
                                "per_facet": [
                                    "Italiano, Laura (Journalist)",
                                    "Harris, Kamala D",
                                    "Poole, Keith (Editor)"
                                ],
                                "geo_facet": [],
                                "media": [
                                    {
                                        "type": "image",
                                        "subtype": "photo",
                                        "caption": "A false story in The New York Post whipped around conservative media and elicited denunciations from leading Republicans.",
                                        "copyright": "Alastair Pike/Agence France-Presse — Getty Images",
                                        "approved_for_syndication": 1,
                                        "media-metadata": [
                                            {
                                                "url": "https://static01.nyt.com/images/2021/04/27/us/27nypost-new/27nypost-new-thumbStandard.jpg",
                                                "format": "Standard Thumbnail",
                                                "height": 75,
                                                "width": 75
                                            },
                                            {
                                                "url": "https://static01.nyt.com/images/2021/04/27/us/27nypost-new/27nypost-new-mediumThreeByTwo210.jpg",
                                                "format": "mediumThreeByTwo210",
                                                "height": 140,
                                                "width": 210
                                            },
                                            {
                                                "url": "https://static01.nyt.com/images/2021/04/27/us/27nypost-new/27nypost-new-mediumThreeByTwo440.jpg",
                                                "format": "mediumThreeByTwo440",
                                                "height": 293,
                                                "width": 440
                                            }
                                        ]
                                    }
                                ],
                                "eta_id": 0
                            },
                            {
                                "uri": "nyt://article/7806cc91-4a42-54a1-aed6-0be0b0c77163",
                                "url": "https://www.nytimes.com/2021/04/30/realestate/bentonville-arkansas-moving-incentive.html",
                                "id": 100000007637490,
                                "asset_id": 100000007637490,
                                "source": "New York Times",
                                "published_date": "2021-04-30",
                                "updated": "2021-05-02 10:13:03",
                                "section": "Real Estate",
                                "subsection": "",
                                "nytdsection": "real estate",
                                "adx_keywords": "Real Estate and Housing (Residential);Economic Conditions and Trends;Telecommuting;Fayetteville (Ark);Tulsa (Okla);Savannah (Ga);Hawaii",
                                "column": null,
                                "byline": "By Alyson Krueger",
                                "type": "Article",
                                "title": "Want to Move to Our Town? Here’s $10,000 and a Free Bike.",
                                "abstract": "With offers of cash, housing and a budding talent pool, smaller cities and states hope to get in on the ground floor of a new era for remote workers.",
                                "des_facet": [
                                    "Real Estate and Housing (Residential)",
                                    "Economic Conditions and Trends",
                                    "Telecommuting"
                                ],
                                "org_facet": [],
                                "per_facet": [],
                                "geo_facet": [
                                    "Fayetteville (Ark)",
                                    "Tulsa (Okla)",
                                    "Savannah (Ga)",
                                    "Hawaii"
                                ],
                                "media": [
                                    {
                                        "type": "image",
                                        "subtype": "photo",
                                        "caption": "Bentonville, Ark., city of roughly 55,000 in Northwest Arkansas, is best known as the home of Walmart&rsquo;s global headquarters. Now it&rsquo;s expanding its reach under the banner of the Life Works Here initiative, which awards selected remote workers $10,000 and a free bicycle for moving to the area.",
                                        "copyright": "Beth Hall for The New York Times",
                                        "approved_for_syndication": 1,
                                        "media-metadata": [
                                            {
                                                "url": "https://static01.nyt.com/images/2021/05/02/realestate/30incentives8/merlin_104933242_cb1449ca-8aed-4bbf-90a0-272061ee1579-thumbStandard.jpg",
                                                "format": "Standard Thumbnail",
                                                "height": 75,
                                                "width": 75
                                            },
                                            {
                                                "url": "https://static01.nyt.com/images/2021/05/02/realestate/30incentives8/merlin_104933242_cb1449ca-8aed-4bbf-90a0-272061ee1579-mediumThreeByTwo210.jpg",
                                                "format": "mediumThreeByTwo210",
                                                "height": 140,
                                                "width": 210
                                            },
                                            {
                                                "url": "https://static01.nyt.com/images/2021/05/02/realestate/30incentives8/merlin_104933242_cb1449ca-8aed-4bbf-90a0-272061ee1579-mediumThreeByTwo440.jpg",
                                                "format": "mediumThreeByTwo440",
                                                "height": 293,
                                                "width": 440
                                            }
                                        ]
                                    }
                                ],
                                "eta_id": 0
                            },
                            {
                                "uri": "nyt://article/4b4cc8c5-736c-502d-b00b-9e27bf0f1043",
                                "url": "https://www.nytimes.com/2021/04/27/dining/blaine-wetzel-willows-inn-lummi-island-abuse.html",
                                "id": 100000007694746,
                                "asset_id": 100000007694746,
                                "source": "New York Times",
                                "published_date": "2021-04-27",
                                "updated": "2021-04-29 18:05:21",
                                "section": "Food",
                                "subsection": "",
                                "nytdsection": "food",
                                "adx_keywords": "Restaurants;Discrimination;Workplace Hazards and Violations;Chefs;Race and Ethnicity;Sexual Harassment;#MeToo Movement;Homosexuality and Bisexuality;Asian-Americans;Wetzel, Blaine (Chef);Soto-Innes, Daniela;Willows Inn (Lummi Island, Wash, Restaurant);Lummi Island (Wash)",
                                "column": null,
                                "byline": "By Julia Moskin",
                                "type": "Article",
                                "title": "The Island Is Idyllic. As a Workplace, It’s Toxic.",
                                "abstract": "Globe-trotting diners flock to the Willows Inn’s serene Northwest setting. But former employees say faked ingredients, sexual harassment and an abusive kitchen are the real story.",
                                "des_facet": [
                                    "Restaurants",
                                    "Discrimination",
                                    "Workplace Hazards and Violations",
                                    "Chefs",
                                    "Race and Ethnicity",
                                    "Sexual Harassment",
                                    "#MeToo Movement",
                                    "Homosexuality and Bisexuality",
                                    "Asian-Americans"
                                ],
                                "org_facet": [
                                    "Willows Inn (Lummi Island, Wash, Restaurant)"
                                ],
                                "per_facet": [
                                    "Wetzel, Blaine (Chef)",
                                    "Soto-Innes, Daniela"
                                ],
                                "geo_facet": [
                                    "Lummi Island (Wash)"
                                ],
                                "media": [
                                    {
                                        "type": "image",
                                        "subtype": "photo",
                                        "caption": "Blaine Wetzel, chef and co-owner of the Willows Inn, denied allegations that his kitchen fails to live up to the ideals he broadcasts to the world.",
                                        "copyright": "Stuart Isett for The New York Times",
                                        "approved_for_syndication": 1,
                                        "media-metadata": [
                                            {
                                                "url": "https://static01.nyt.com/images/2021/04/27/us/27willows-promo/27willows-promo-thumbStandard-v2.jpg",
                                                "format": "Standard Thumbnail",
                                                "height": 75,
                                                "width": 75
                                            },
                                            {
                                                "url": "https://static01.nyt.com/images/2021/04/27/us/27willows-promo/27willows-promo-mediumThreeByTwo210-v2.jpg",
                                                "format": "mediumThreeByTwo210",
                                                "height": 140,
                                                "width": 210
                                            },
                                            {
                                                "url": "https://static01.nyt.com/images/2021/04/27/us/27willows-promo/27willows-promo-mediumThreeByTwo440-v2.jpg",
                                                "format": "mediumThreeByTwo440",
                                                "height": 293,
                                                "width": 440
                                            }
                                        ]
                                    }
                                ],
                                "eta_id": 0
                            },
                            {
                                "uri": "nyt://article/c4ffbb50-123d-5111-a9f1-a726c52b5f62",
                                "url": "https://www.nytimes.com/live/2021/05/03/world/covid-vaccine-coronavirus-cases/pfizer-covid-vaccine-teens",
                                "id": 100000007743148,
                                "asset_id": 100000007743148,
                                "source": "New York Times",
                                "published_date": "2021-05-03",
                                "updated": "2021-05-04 10:13:20",
                                "section": "Health",
                                "subsection": "",
                                "nytdsection": "health",
                                "adx_keywords": "internal-essential;Vaccination and Immunization;Coronavirus (2019-nCoV);Teenagers and Adolescence;Food and Drug Administration;Pfizer Inc;United States",
                                "column": null,
                                "byline": "By Noah Weiland, Sharon LaFraniere and Apoorva Mandavilli",
                                "type": "Article",
                                "title": "The F.D.A. is set to authorize the Pfizer-BioNTech vaccine for those 12-15 years old by early next week.",
                                "abstract": "The move opens up the U.S. vaccination campaign to millions more Americans.",
                                "des_facet": [
                                    "internal-essential",
                                    "Vaccination and Immunization",
                                    "Coronavirus (2019-nCoV)",
                                    "Teenagers and Adolescence"
                                ],
                                "org_facet": [
                                    "Food and Drug Administration",
                                    "Pfizer Inc"
                                ],
                                "per_facet": [],
                                "geo_facet": [
                                    "United States"
                                ],
                                "media": [
                                    {
                                        "type": "image",
                                        "subtype": "photo",
                                        "caption": "Thomas Gregory, 16, received a dose of the Pfizer coronavirus vaccine in Worcester, Mass., in April.",
                                        "copyright": "Joseph Prezioso/Agence France-Presse — Getty Images",
                                        "approved_for_syndication": 1,
                                        "media-metadata": [
                                            {
                                                "url": "https://static01.nyt.com/images/2021/06/03/world/03virus-briefing-pfizer-teens/03virus-briefing-pfizer-teens-thumbStandard.jpg",
                                                "format": "Standard Thumbnail",
                                                "height": 75,
                                                "width": 75
                                            },
                                            {
                                                "url": "https://static01.nyt.com/images/2021/06/03/world/03virus-briefing-pfizer-teens/03virus-briefing-pfizer-teens-mediumThreeByTwo210.jpg",
                                                "format": "mediumThreeByTwo210",
                                                "height": 140,
                                                "width": 210
                                            },
                                            {
                                                "url": "https://static01.nyt.com/images/2021/06/03/world/03virus-briefing-pfizer-teens/03virus-briefing-pfizer-teens-mediumThreeByTwo440.jpg",
                                                "format": "mediumThreeByTwo440",
                                                "height": 293,
                                                "width": 440
                                            }
                                        ]
                                    }
                                ],
                                "eta_id": 0
                            },
                            {
                                "uri": "nyt://article/1f2c54e5-3055-53cd-bfeb-162766c14199",
                                "url": "https://www.nytimes.com/live/2021/04/27/world/covid-vaccine-coronavirus-cases/cdc-new-mask-guidance",
                                "id": 100000007732188,
                                "asset_id": 100000007732188,
                                "source": "New York Times",
                                "published_date": "2021-04-27",
                                "updated": "2021-04-28 09:53:36",
                                "section": "Health",
                                "subsection": "",
                                "nytdsection": "health",
                                "adx_keywords": "internal-essential;Vaccination and Immunization;Masks;Coronavirus (2019-nCoV);your-feed-healthcare;Centers for Disease Control and Prevention",
                                "column": null,
                                "byline": "By Roni Caryn Rabin, Emily Anthes and Sheryl Gay Stolberg",
                                "type": "Article",
                                "title": "Vaccinated Americans don’t need masks outdoors in small groups or when biking and running, the C.D.C. says.",
                                "abstract": "Because the risk of infection is much lower outdoors, health officials also relaxed advice for those who haven’t gotten their shots, saying they could safely shed their masks for some outside activities.",
                                "des_facet": [
                                    "internal-essential",
                                    "Vaccination and Immunization",
                                    "Masks",
                                    "Coronavirus (2019-nCoV)",
                                    "your-feed-healthcare"
                                ],
                                "org_facet": [
                                    "Centers for Disease Control and Prevention"
                                ],
                                "per_facet": [],
                                "geo_facet": [],
                                "media": [
                                    {
                                        "type": "image",
                                        "subtype": "photo",
                                        "caption": "Masked and maskless pedestrians at the Long Beach boardwalk in New York this month.",
                                        "copyright": "Johnny Milano for The New York Times",
                                        "approved_for_syndication": 1,
                                        "media-metadata": [
                                            {
                                                "url": "https://static01.nyt.com/images/2021/04/27/us/27virus-briefing-masks-outdoors-cdc1/27virus-briefing-masks-outdoors-cdc1-thumbStandard.jpg",
                                                "format": "Standard Thumbnail",
                                                "height": 75,
                                                "width": 75
                                            },
                                            {
                                                "url": "https://static01.nyt.com/images/2021/04/27/us/27virus-briefing-masks-outdoors-cdc1/27virus-briefing-masks-outdoors-cdc1-mediumThreeByTwo210.jpg",
                                                "format": "mediumThreeByTwo210",
                                                "height": 140,
                                                "width": 210
                                            },
                                            {
                                                "url": "https://static01.nyt.com/images/2021/04/27/us/27virus-briefing-masks-outdoors-cdc1/27virus-briefing-masks-outdoors-cdc1-mediumThreeByTwo440.jpg",
                                                "format": "mediumThreeByTwo440",
                                                "height": 293,
                                                "width": 440
                                            }
                                        ]
                                    }
                                ],
                                "eta_id": 0
                            },
                            {
                                "uri": "nyt://article/427e3c26-3e35-545a-9d51-56d8fafa2bf9",
                                "url": "https://www.nytimes.com/2021/05/01/fashion/weddings/from-best-friends-to-platonic-spouses.html",
                                "id": 100000007692569,
                                "asset_id": 100000007692569,
                                "source": "New York Times",
                                "published_date": "2021-05-01",
                                "updated": "2021-05-03 15:25:47",
                                "section": "Fashion",
                                "subsection": "Love",
                                "nytdsection": "fashion",
                                "adx_keywords": "Marriages;Friendship",
                                "column": null,
                                "byline": "By Danielle Braff",
                                "type": "Article",
                                "title": "From Best Friends to Platonic Spouses",
                                "abstract": "Some people are taking their friendships to the next level by saying “I do” to marriages without sex.",
                                "des_facet": [
                                    "Marriages",
                                    "Friendship"
                                ],
                                "org_facet": [],
                                "per_facet": [],
                                "geo_facet": [],
                                "media": [
                                    {
                                        "type": "image",
                                        "subtype": "photo",
                                        "caption": "Jay Guercio, left, and Krystle Guercio, who have been friends since 2011, were married Nov. 14, 2020. The couple share a bed without any physical contact. ",
                                        "copyright": "Audrey Malone",
                                        "approved_for_syndication": 0,
                                        "media-metadata": [
                                            {
                                                "url": "https://static01.nyt.com/images/2021/05/02/fashion/weddings/02Platonic/oakImage-1619545737801-thumbStandard.jpg",
                                                "format": "Standard Thumbnail",
                                                "height": 75,
                                                "width": 75
                                            },
                                            {
                                                "url": "https://static01.nyt.com/images/2021/05/02/fashion/weddings/02Platonic/oakImage-1619545737801-mediumThreeByTwo210.jpg",
                                                "format": "mediumThreeByTwo210",
                                                "height": 140,
                                                "width": 210
                                            },
                                            {
                                                "url": "https://static01.nyt.com/images/2021/05/02/fashion/weddings/02Platonic/oakImage-1619545737801-mediumThreeByTwo440.jpg",
                                                "format": "mediumThreeByTwo440",
                                                "height": 293,
                                                "width": 440
                                            }
                                        ]
                                    }
                                ],
                                "eta_id": 0
                            }
                        ]
                    }
                    """
