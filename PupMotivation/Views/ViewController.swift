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
            getQuote(selection: unwrappeedQuote) {
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "toQuoteView", sender: self)
                }
            }
        }
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
            selectedBreed.text = "Breed: \(breeds[indexPath.row].uppercased())"
            myBreedSelection = breeds[indexPath.row]
        } else {
            selectedCategory.text = "Category: \(categories[indexPath.row].uppercased())"
            myQuoteSelection = categories[indexPath.row]
        }
    }
    
}

