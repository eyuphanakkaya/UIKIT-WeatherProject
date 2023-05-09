//
//  WeatherProvider.swift
//  WeatherProject
//
//  Created by Eyüphan Akkaya on 8.05.2023.
//

import Foundation

//https://api.openweathermap.org/data/2.5/forecast?lat=40.987969&lon=28.6054335&appid=3f95bd844fb336a3a0ba035d5bc08cf3
class WeatherProvider {
    private let apiKey = "3f95bd844fb336a3a0ba035d5bc08cf3"
    private let baseUrl = URL(string: "https://api.openweathermap.org/data/2.5/forecast?lat=40.987969&lon=28.6054335&appid=3f95bd844fb336a3a0ba035d5bc08cf3")
    private let jsonDecoder = JSONDecoder()
}
