//
//  Weather_Model.swift
//  WeatherProject
//
//  Created by Eyüphan Akkaya on 9.05.2023.
//

import Foundation



struct ListModel:Codable{
    let cod:String
    let message : Int
    let cnt : Int
    let list:[List]?
    let city:_City
}

struct List:Codable {
    let main:_Main
    let weather:[_Weather]
    let clouds:_Clouds
    let wind:_Wind
    let visibility:Int
    let pop:Double
    let sys:_Sys
    let dt_txt:String
}

struct _Main:Codable{
    let temp:Double
    let feelsLike:Double
    let tempMin:Double
    let tempMax:Double
    let pressure:Int
    let seaLevel:Int?
    let grndLevel:Int?
    let humidity:Int
    let tempKf:Double
    
    enum CodingKeys:String,CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
        case humidity
        case tempKf = "temp_kf"
    }
}
struct _Weather:Codable {
    let id:Int
    let main:String
    let description:String
    let icon:String
}
struct _Clouds:Codable{
    let all:Int
}
struct _Wind:Codable{
    let speed:Double
    let deg:Int
    let gust:Double?
}
struct _City:Codable{
    let id:Int
    let name:String
    let coord:_Coord
    let country:String
    let population:Int
    let timezone:Int
    let sunrise:Int
    let sunset:Int
}
struct _Coord:Codable{
    let lat:Double
    let lon:Double
}
struct _Sys:Codable {
    let pod:String
}

