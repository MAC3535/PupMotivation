//
//  dataJSON.swift
//  PupMotivation
//
//  Created by Anthony Cortez on 12/31/22.
//

import Foundation
import UIKit

var dogImage = ""
var myBreedSelection: String?

struct DogPic: Decodable {
    var message: String
}


func getDogPicture(breed: String, completion: @escaping () -> Void) {
    var answerBreed: String
    var stringURL: String
    // remove space from breed and lowercase for API use
    answerBreed = breed.lowercased()
    let finalBreed = String(answerBreed.filter { !" \n\t\r".contains($0) })
    
    print(finalBreed)
    if breed == "RANDOM" {
        stringURL = "https://dog.ceo/api/breeds/image/random"
    } else if breeds.contains(breed) == false {
        stringURL = "https://dog.ceo/api/breed/\(finalBreed)/images/random"
    } else {
        stringURL = "https://dog.ceo/api/breed/\(finalBreed)/images/random"
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
