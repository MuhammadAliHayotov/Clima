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
            let task = session.dataTask(with: url, completionHandler: handle(data: response: error:))
            
            //starting the task
            task.resume()
        }
    }
    
    func handle(data:Data?, response:URLResponse?, error:Error?){
        if error != nil {
            print(error!)
            return
        }
        
        if let safeData = data {
            let dataString = String(data:safeData, encoding: .utf8)//we are getting data as a string
            print(dataString as Any)
            
        }
    }
}
