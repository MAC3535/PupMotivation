//
//  ViewController.swift
//  PupMotivation
//
//  Created by Anthony Cortez on 12/28/22.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet private var appTitle: UILabel!
    @IBOutlet private var slogan: UILabel!
    @IBOutlet private var categorycollectionView: UICollectionView!
    @IBOutlet private var selectedCategory: UILabel!
    @IBOutlet private var dogBreedCollectionView: UICollectionView!
    @IBOutlet private var selectedBreed: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categorycollectionView.delegate = self
        categorycollectionView.dataSource = self
        
        dogBreedCollectionView.delegate = self
        dogBreedCollectionView.dataSource = self
    
        slogan.text = "Daily quotes delivered with a touch of cute."
        selectedCategory.text = "Please select Category"
        selectedBreed.text = "Please select a Dog Breed"
    }
    
    @IBAction func goButtonPressed(sender: UIButton) {
        guard let unwrappedBreed = myBreedSelection else {return}
        guard let unwrappeedQuote = myQuoteSelection else {return}
        
        getDogPicture(breed: unwrappedBreed) {
            // handle error where dog API data is missisng
            if dogMissing == true {
                DispatchQueue.main.async {
                    self.dogMissingError()
                }
            } else {
                getQuote(selection: unwrappeedQuote) {
                    // handle errer where quote API data is missing
                    if quoteMissing == true {
                        DispatchQueue.main.async {
                            self.dogMissingError()
                        }
                    } else {
                        DispatchQueue.main.async {
                            self.performSegue(withIdentifier: "toQuoteView", sender: self)
                        }
                    }
                    
                }
            }
        }
    }
    
    // set up alert for dog breed search
    func searchForDogBreed() {
        
        let userChoiceController = UIAlertController(title: "SEARCH", message: "Please enter dog breed bellow.", preferredStyle: .alert)
        userChoiceController.addTextField()
        
        let submittedBreed = UIAlertAction(title: "SUBMIT", style: .default) { [weak self, weak userChoiceController] action in
            guard let answer = userChoiceController?.textFields?[0].text else {return}
            self?.submit(answer)
        }
        userChoiceController.addAction(submittedBreed)
        present(userChoiceController, animated: true)
    }
    
    func submit(_ answer: String) {
        selectedBreed.text = "Breed: \(answer.uppercased())"
        myBreedSelection = answer
    }
    
    // set up dog breed error handling
    func dogMissingError() {
        let ac = UIAlertController(title: "SORRY", message: "Please try another dog breed.", preferredStyle: .alert)
        let done = UIAlertAction(title: "OK", style: .default)
        
        ac.addAction(done)
        present(ac, animated: true)
    }
   
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == dogBreedCollectionView {
            return breeds.count
        }
        
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = categorycollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CategoryCell
        cell.categoryLabel.text = categories[indexPath.row].uppercased()
        
        if collectionView == dogBreedCollectionView {
            let cellTwo = dogBreedCollectionView.dequeueReusableCell(withReuseIdentifier: "cellTwo", for: indexPath) as! DogBreedCell
            cellTwo.breedLabel.text = breeds[indexPath.row].uppercased()
            return cellTwo
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == dogBreedCollectionView {
            if indexPath.row == 7 {
                searchForDogBreed()
            } else {
                selectedBreed.text = "Breed: \(breeds[indexPath.row].uppercased())"
                myBreedSelection = breeds[indexPath.row]
            }
           
        } else {
            selectedCategory.text = "Category: \(categories[indexPath.row].uppercased())"
            myQuoteSelection = categories[indexPath.row]
        }
    }
    
}

