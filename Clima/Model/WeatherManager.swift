//
//  WeatherManager.swift
//  Clima
//
//  Created by A253 on 13/06/22.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=08d047857b2e1e073f3ca56ced948860&units=metric"
    
    func fetchWeather(cityName: String){
        let urlString = "\(weatherURL)&q=\(cityName)"//prepare the url (fetch the key)
        performRequest(urlString: urlString)//pass it to a performer
    }
    func performRequest(urlString: String){
        //TODO:
        /*
         1. Create a URL
         2. Create a URLSession
         3. Give the session a task
         4. Start the Task
         */
        
        //Creating a URL
        if let url = URL(string: urlString){
            //Creatinga URL Session
            let session = URLSession(configuration: .default)
            //giving the session a task
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    print(error!)
                    return
                }
                
                if let safeData = data {
                    //get the data in JSON format and pass it to parser
                    self.parseJSON(weatherData: safeData)
                }
            }
            
            //starting the task
            task.resume()
        }
    }
    
    func parseJSON(weatherData: Data){
        let decoder = JSONDecoder()
        do{
            //decode from JSON to Swift
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            print(decodedData.main.temp)
            print(decodedData.weather[0].weatherDescription)
        } catch{
            print(error)
        }
    }
    func getConditionName(weatherId: Int) -> String {
        switch weatherId {
        case 200...232:
            return "Thunderstorm"
        case 300...321:
            return "Drizzle"
        case 500...531:
            return "Rain"
        case 600...622:
            return "Snow"
        case 800:
            return "Clear"
        case 801...804:
            return "Clouds"
        default:
            return "ID is definitely around 700 or not found"
        }
    }
    
}
