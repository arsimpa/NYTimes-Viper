# NYTimes-Viper
Fetches most viewed articles from NYTimes.

# Design Architecture

The app uses VIPER architecture as a design pattern to manage and strcuture code. 
VIPER is a flavor of CLEAN.

So, What is VIPER architecture?

VIPER is a backronym for View, Interactor, Presenter, Entity, and Router.

This architecture is based on Single Responsibility Principle which leads to a clean architecture.
View: The responsibility of the view is to send the user actions to the presenter and shows whatever the presenter tells it.
Interactor: This is the backbone of an application as it contains the business logic.
Presenter: Its responsibility is to get the data from the interactor on user actions and after getting data from the interactor, it sends it to the view to show it. It also asks the router/wireframe for navigation.
Entity: It contains basic model objects used by the Interactor.
Router: It has all navigation logic for describing which screens are to be shown when. It is normally written as a wireframe.

# App Structure

App has been divided into Scenes and there are two scenes in the application:

1. **ArticleList** (VIPER)
2. **ArticleList** (VIPER)
3. **Search** (MVC)

# How to use Application

The application provided three actions to user:

1. Search the articles.
2. Change Settings i.e Period Settings and Dark Mode.
3. Change menu from side drawer.

1. For the demo purpose user is allowed to search in **Title** and **Abstract** of the article.

2. To change settings user can tap to top right button to open SettingsVC. Once done doing changes close the controller by dragging it down and it will apply the changes automatically. User can also transition between light and dark mode by simply changing the Switch. All views uses Dynamic colors and supports both Dark/Light mode.

3. User can also change Menu from left top bar button. For the purpose of demo only one dummy View controller has been added.

# Networking

For network calls Apples URLSession has been used. A Client is written on top of URLSession.
The HttpClient fully supports Dependency Injection(DI), a very core concept of VIPER. DI has many advantages as it provides easy way to Mocking of API requests.

# Interceptors

The concept of Interceptors has been used to modify a any request on the fly. You can merge multiple interceptors and create complex requests easily without modifying in Network client. The good thing is that interceptors are added on individual requests so you have the flexibility to decide which interceptor should adedd.

There are mainly two types of Interceptors used in app:

  1 . Request Adapter
  2.  Response Parser

  # 1 . Request Adapter:
  The purpose of this class is to modify any request on the runtime. Adapter used in app is **NYTimesAPIKeyInterceptor** which adds the Api-key to the request by 
  keeping all details encapsulated in the Adapter. The other purpose could adding access token to the requests when user is authorized. Best used for **Auth 2.0**. 
  
  Unit test has been written for it NYTimesRequestIntercptorTest.
  
  # 2. Response Parser
  The purpose is to behave as a funnel when response is received and do any modification before sending it down to the caller.
  

# Caching

For local caching of Data i.e Images in this application, a layer has been introdcued which downloads the images from server and saves into the Cache. The cache uses the LRU algorithm to purge the data when memory reaches at specified size. This solves the problem of app taking too much size.

The caching layer is fully capable of storing any type and for that a unit test has been written in **CacheTest.swift**.

The caching uses Apples default class **URLCache**.

Mock Classes has been added which makes Unit Testing very easy and manageable in iOS.

# Image Downloading

For Downloading image no third party has been used and it efficiently uses URLsession to download from specified destination. Simple to use extension has been provided on UIImageview which makes it very convenient to download images. Once the image is downloaded it gets stored in the local cache implement in the app, which improves the performance drastically.


# Run Unit

Unit tests have been provided for major chunks of the application i.e API Client, CacheTest, NYTimesRequestIntercptorTest, ArticleTest, SettingsTest, APITest.
Simply press "Command" + "U" to run all the tests.

# Run Application

To run the application simply press "Command" + "R"




