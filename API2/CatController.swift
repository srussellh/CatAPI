//
//  CatController.swift
//  API2
//
//  Created by Bobba Kadush on 5/15/19.
//  Copyright © 2019 Bobba Kadush. All rights reserved.
//

import UIKit

class CatController {
    static let shared = CatController()
    
    func fetchMyCat(completion: @escaping (Cat?) -> Void) {
        guard let baseURL = URL(string: "https://api.thecatapi.com/v1/images/search") else {return}
//        let urlWithKey = baseURL.appendingPathComponent("api_key=93fd4773-e79f-48ef-bf61-64e804d40c12")
        let apiKeyQueryItem = URLQueryItem(name: "api_key", value: "93fd4773-e79f-48ef-bf61-64e804d40c12")
        //let request = URLRequest(url: baseURL)
        var component = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        component?.queryItems = [apiKeyQueryItem]
        guard let finalURL = component?.url else {return}
        print(finalURL)
        
        URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            if let error = error {
                print("We lost your Kitty: \(error.localizedDescription)")
            }
            guard let data = data else {return}
            do{
                let arrayCat = try JSONDecoder().decode([Cat].self, from: data)
                completion(arrayCat[0])
            }catch{
                print(error.localizedDescription)
                completion(nil)
                return
            }
        }.resume()
    }
    func fetchMyCatImage(cat: Cat, completion: @escaping(UIImage?) -> Void) {
        guard let imageURL = URL(string: cat.url) else {print("erro unraping cat"); return}
        print(cat.url)
        URLSession.shared.dataTask(with: imageURL) { (data, _, error) in
            if let error = error {
                print("your cat is too sneaky: \(error.localizedDescription)")
            }
            guard let data = data else {return}
            let image = UIImage(data: data)
            completion(image)
        }.resume()
    }
}
