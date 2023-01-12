//
//  QuoteViewController.swift
//  PupMotivation
//
//  Created by Anthony Cortez on 12/31/22.
//

import UIKit

var dogPicture: Data?

class QuoteViewController: UIViewController {
    @IBOutlet private var picture: UIView!
    @IBOutlet private var quoteLabel: UILabel!
    @IBOutlet private var realPicture: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let answer = dogPicture else {return}
        realPicture.image = UIImage(data: answer)
        quoteLabel.text = """
        \(quote)
        - \(author)
        """
        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(navButtonPressed))
    }

    @objc func navButtonPressed() {
        print(quote)
    }
}
