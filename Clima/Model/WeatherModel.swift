//
//  WeatherModel.swift
//  Clima
//
//  Created by A253 on 15/06/22.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation


struct WeatherModel {
    let conditionID: Int
    let cityName: String
    let temperature: Double
    
    //print out temperature with one decimal place
    var temperatureString: String {
        return String(format: "%.1f", temperature)
    }
    //computed property
    var conditionName: String {
        switch conditionID {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "ID is definitely around 700 or not found"
        }
    }
    
}
