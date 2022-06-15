//
//  WeatherManager.swift
//  Clima
//
//  Created by A253 on 13/06/22.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation
import CoreLocation


//create a protocol
//create it in the same file where the class exists
protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}


struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=08d047857b2e1e073f3ca56ced948860&units=metric"
    
    
    var delegate: WeatherManagerDelegate?
    
    
    func fetchWeather(cityName: String){
        let urlString = "\(weatherURL)&q=\(cityName)"//prepare the url (fetch the key)
        performRequest(urlString: urlString)//pass it to a performer
    }
    func fetchWeather(lat: CLLocationDegrees, lon: CLLocationDegrees){
        let urlString = "\(weatherURL)&lat=\(lat)&lon=\(lon)"//prepare the url (fetch the key)
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
                    //print(error!)
                    //if network issue or some other error, then process it in here according to our delegate
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    //get the data in JSON format and pass it to parser
                    if let weather = self.parseJSON(safeData){
                        self.delegate?.didUpdateWeather(self, weather: weather)//use protocol
                    }
                }
            }
            
            //starting the task
            task.resume()
        }
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do{
            //decode from JSON to Swift
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            
            let weather = WeatherModel(conditionID: id, cityName: name, temperature: temp)
            
            return weather

            
        } catch{
            //update error
            delegate?.didFailWithError(error: error)
            //in case of error return nil
            return nil
        }
    }
  
    
}
