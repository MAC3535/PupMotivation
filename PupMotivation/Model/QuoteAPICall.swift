
import Foundation
import UIKit

// set up quote property for final API results
var quote = ""
var author = ""
var myQuoteSelection: String?
var quoteMissing = true


// set up json objects
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

// API call for quote
func getQuote(selection: String, completion: @escaping () -> Void) {
    let url = URL(string: "http://quotes.rest/qod.json?category=\(selection)")
    guard let unwrappedURL = url else {return}
    
    let request = URLRequest(url: unwrappedURL)
    let task = URLSession.shared.dataTask(with: request) { data, _, error in
        let decoder = JSONDecoder()
        guard let unwrappedDATA = data else {print("trouble with data"); return}
        do {
            // set up string and assign result to quote
            let answer = try decoder.decode(JSON.self, from: unwrappedDATA)
            for i in answer.contents.quotes {
                quote = i.quote
                author = i.author
            }
            quoteMissing = false
            completion()
        }
        catch {
            quoteMissing = true
            completion()
            print("trouble with quote api call", error.localizedDescription)
        }
    }
    task.resume()
}



