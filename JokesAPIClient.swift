//
//  JokesAPIClient.swift
//  Jokes
//
//  Created by Maitree Bain on 12/3/19.
//  Copyright © 2019 Maitree Bain. All rights reserved.
//

import Foundation
 
struct JokesAPIClient: Error { //conforming to ERror protocol
    
    //same file for now, move enum later
    enum NetworkError: Error {
        case badURL(String)
        case networkClientError(Error)
        case noResponse
        case noData
        case badStatus(Int)
        case decodingError(Error)
    }
    
    //introducing topics
    //enum - associated values
    //escaping closures
    //Result type is an enum - new in Swift 5, has a success or failure case, allows us to write better networking code and handling errors, also better VC logic.
    static func fetchJokes(completion: @escaping (Result<[Joke], NetworkError>) -> ()) {
        let endPointURLString = "https://official-joke-api.appspot.com/jokes/programming/ten"
        
        //creating a URL from the given endpoint string above
        guard let url = URL(string: endPointURLString) else {
            completion(.failure(.badURL(endPointURLString)))
            return
        }
        //make use of URLSession to (get back JSON data [GET Request] from the Jokes web API) perform the Network GET request to the Jokes web API
        
        //by default URLSession dataTask is suspended - meaning request is pending tp perform request you have to resume() the dataTask.
        let dataTask = URLSession.shared.dataTask(with: url) {(data, response, error) in
            
            //check for errors
            if let error = error {// if error is nil there was no network error
                completion(.failure(.networkClientError(error)))
            }
            
            //downcast to HTTPURLResponse to get access to the statusCode
            guard let urlResponse = response as? HTTPURLResponse else {
                //bad response network error
                completion(.failure(.noResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            //find out what the status code is:
            switch urlResponse.statusCode { //status code is an Int
            case 200...299:
                break
            default:
                completion(.failure(.badStatus(urlResponse.statusCode)))
            }
            
            //use data to create Joke Model
            
            do {
                let jokes = try JSONDecoder().decode([Joke].self, from: data)
                
                completion(.success(jokes))
            } catch {
                completion(.failure(.decodingError(error)))
            }
        }
        dataTask.resume()
        
    }
    
}
