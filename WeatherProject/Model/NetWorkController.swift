//
//  NetWorkController.swift
//  WeatherProject
//
//  Created by Eyüphan Akkaya on 8.05.2023.
//

import Foundation

struct NetWorkController {
    private static var baseUrl = "api.openweathermap.org"
    private static var apiKey = "3f95bd844fb336a3a0ba035d5bc08cf3"


    
    enum Endpoint {
        case cityId(path: String = "/data/2.5/weather" ,id: Int)
        
        var url: URL? {
            var components = URLComponents()
            components.scheme = "https"
            components.host = baseUrl
            components.path = path
            components.queryItems = queryItems
            
            
            return components.url
        }
        
        private var path :String {
            switch self {
            case .cityId(path: let path, _):
                return path
            }
        }
       private var queryItems : [URLQueryItem] {
           var queryItems = [URLQueryItem]()
            switch self {
            case .cityId(_,let id):
                queryItems.append(URLQueryItem(name: "id", value: String(id)))
            }
           queryItems.append(URLQueryItem(name: "appin", value: apiKey))
           return queryItems
        }
        
    }
    
     static func fetchWeather(for cityId:Int = 746234,_ completion:@escaping (WeatherMain) ->Void) {
        if let url = Endpoint.cityId(id: cityId).url {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    print(error)
                }
                if let data = data {
                    do{
                        let weather = try JSONDecoder().decode(WeatherMain.Main.self, from: data)
                        //completion(weather)
                    }catch let error {
                        print(error)
                    }
                }
            }.resume()
        }
    }

}
