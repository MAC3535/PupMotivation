//
//  dataJSON.swift
//  PupMotivation
//
//  Created by Anthony Cortez on 12/31/22.
//

import Foundation
var dogImage = ""
var myBreedSelection: String?

struct DogPic: Decodable {
    var message: String
}


func getDogPicture(breed: String, completion: @escaping () -> Void) {
    var stringURL: String
    
    if breed == "RANDOM" {
        stringURL = "https://dog.ceo/api/breeds/image/random"
    } else {
        stringURL = "https://dog.ceo/api/breed/\(breed.lowercased())/images/random"
    }
    
    let url = URL(string: stringURL)
    guard let unwrappedURL = url else {print("Trouble unwrapping dog URL"); return}
    
    let request = URLRequest(url: unwrappedURL)
    let task = URLSession.shared.dataTask(with: request) { data, _, error in
        let decoder = JSONDecoder()
        guard let unwrappedDATA = data else {print("troublw with data"); return}
        do {
            let answer = try decoder.decode(DogPic.self, from: unwrappedDATA)
            dogImage = answer.message
            let url = URL(string: answer.message)
            if let newURL = url {
                do {
                    let data = try Data(contentsOf: newURL)
                    dogPicture = data
                    completion()
                }
                catch {
                    print(error.localizedDescription)
                }
            }
        }
        catch {
            print("trouble with dog api call", error.localizedDescription)
        }
    }
    task.resume()
}
