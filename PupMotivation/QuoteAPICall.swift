//
//  QuoteAPICall.swift
//  PupMotivation
//
//  Created by Anthony Cortez on 1/5/23.
//

import Foundation

struct JSON: Decodable {
    var contents: Contents
}

struct Contents: Decodable {
    var quotes: [Quotes]
}

struct Quotes: Decodable {
    var quote: String
    var author: String
    var date: String
}


//var quoteFinal: Quotes?
var quote = ""
var myQuoteSelection: String?

func getQuote(selection: String, completion: @escaping () -> Void) {
    let url = URL(string: "http://quotes.rest/qod.json?category=\(selection)")
    guard let unwrappedURL = url else {return}
    
    let request = URLRequest(url: unwrappedURL)
    let task = URLSession.shared.dataTask(with: request) { data, _, error in
        let decoder = JSONDecoder()
        guard let unwrappedDATA = data else {print("troublw with data"); return}
        do {
            let answer = try decoder.decode(JSON.self, from: unwrappedDATA)
            for i in answer.contents.quotes {
                quote = i.quote
            }
            completion()
        }
        catch {
            print("trouble with quote api call", error.localizedDescription)
        }
    }
    task.resume()
}



