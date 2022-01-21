//
//  APIService.swift
//  newstest_Owen
//
//  Created by owenkao on 2022/1/21.
//
import Moya

class NewsRepository {
    private init() {}
    static func getNews() {
        let provider = MoyaProvider<News>()
        provider.request(.articles) { result in
            switch result {
            case .success(let value):
                print(value)
            case .failure(let error):
                print(error)
            }
        }
    }
}

enum News {
    static private let apiKey: String = "a5303f9195f04a13b7cb014c207223fc"
    case articles
}

extension News: TargetType {
    var baseURL: URL {
        return URL(string: "https://newsapi.org/v2")!
    }
    /* Using a switch statement in all of properties even though there only has a single case (.articles). Any new endpoint will require its own values for the different target properties. */
    var path: String {
        switch self {
        case .articles:
            return "/top-headlines"
        }
    }
    
    var method: Method {
        switch self {
        case .articles:
            return .get
        }
    }
    
    var task: Task {
          switch self {
          case .articles:
            return .requestParameters(
              parameters: [
                "country": "us",
                "apikey": News.apiKey],
              encoding: URLEncoding.default)
          }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }

    var validationType: ValidationType {
        return .successCodes
    }
    
}
