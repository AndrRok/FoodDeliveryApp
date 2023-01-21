//
//  NetworkManager.swift
//  FoodDeliveryApp
//
//  Created by ARMBP on 1/21/23.
//

import UIKit

class NetworkManager {
    
    static let shared           = NetworkManager()
    private let baseURL         = "https://run.mocky.io/v3/44d99074-251c-48ea-be9d-4878554bab85"
    
    private init() {}
    
    
    //MARK: - Load Data
    func getFoodList(completed: @escaping (Result<[Food], ErrorMessages>) -> Void) {
        let endpoint = baseURL
        
        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalidRequest))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy  = .convertFromSnakeCase
                decoder.dateDecodingStrategy = .iso8601
                let resultsFood            = try decoder.decode([Food].self, from: data)
                completed(.success(resultsFood))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        task.resume()
    }
    
    //MARK: - DownloadImage
    func downloadImage(from urlString: String, completed: @escaping(UIImage?)-> Void){

        guard let url = URL(string: urlString) else {
            completed(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            
            guard let self = self,
                  error == nil,
                  let response = response as? HTTPURLResponse, response.statusCode == 200,
                  let data = data,
                  let image = UIImage(data: data) else {
                completed(nil)
                return
            }
            completed(image)
        }
        task.resume()
    }
}

