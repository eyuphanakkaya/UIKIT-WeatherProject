//
//  Deneme.swift
//  WeatherProject
//
//  Created by Eyüphan Akkaya on 9.05.2023.
//

import Foundation

struct Coord:Codable {
    let lon:String
    let lat:String
}
struct Weather:Codable {
    let id:Int
    let main:String
    let description:String
    let icon:String
}




/*"coord":{
 "lon":28.4517,
 "lat":41.004
},
"weather":[
 {
    "id":804,
    "main":"Clouds",
    "description":"overcast clouds",
    "icon":"04d"
 }
],
"base":"stations",
"main":{
 "temp":286.35,
 "feels_like":285.63,
 "temp_min":286.23,
 "temp_max":286.48,
 "pressure":1020,
 "humidity":73,
 "sea_level":1020,
 "grnd_level":1020
},
"visibility":10000,
"wind":{
 "speed":8.06,
 "deg":43,
 "gust":9.19
},
"clouds":{
 "all":100
},
"dt":1683615012,
"sys":{
 "type":1,
 "id":6970,
 "country":"TR",
 "sunrise":1683600912,
 "sunset":1683652208
},
"timezone":10800,
"id":742266,
"name":"Kumburgaz",
"cod":200
}*/
