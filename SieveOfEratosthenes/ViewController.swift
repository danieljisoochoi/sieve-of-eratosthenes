//
//  ViewController.swift
//  SieveOfEratosthenes
//
//  Created by Daniel Jisoo Choi on 11/25/16.
//  Copyright © 2016 Daniel Jisoo Choi. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var primesCountLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var primesCount: Int? {
        didSet {
            if let count = primesCount {
                primesCountLabel.text = "\(count) prime" + (count == 1 ? "" : "s")
            } else {
                primesCountLabel.text = nil
            }
        }
    }
    
    let sieve = Sieve()
    let reuseIdentifier = "PrimeCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        navigationController?.navigationBar.titleTextAttributes =
        [
            NSFontAttributeName: UIFont(name: "Helvetica Neue", size: 20)!
        ]
        
        textField.delegate = self
        primesCountLabel.text = ""
        primesCountLabel.textColor = .gray

        addDoneButtonOnKeyboard()
    }
    
    // adds Done button on toolbar above number pad keyboard, that sends text in field
    // to sieve
    private func addDoneButtonOnKeyboard() {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        doneToolbar.barStyle       = UIBarStyle.default
        let flexSpace              = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem  = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(ViewController.doneButtonAction))
        
        var items = [UIBarButtonItem]()
        items.append(flexSpace)
        items.append(done)
        
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        textField.inputAccessoryView = doneToolbar
    }
    
    @objc private func doneButtonAction() {
        textField.resignFirstResponder()
        guard let upperBound = textField.text else { return }
        if let limit = Int(upperBound) {
            sieve.upperBound = limit
            primesCountLabel.isHidden = false
        } else {
            sieve.upperBound = 0
            primesCountLabel.isHidden = true
        }
        primesCount = sieve.numberOfPrimes
        collectionView.reloadData()
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sieve.numberOfPrimes
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PrimeCell
        
        //cell.backgroundColor = .blue
        cell.number.text = "\(sieve.primes[indexPath.item])"
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PrimeDetail" {
            guard let cell = sender as? PrimeCell else { return }
            guard let vc = segue.destination as? DetailViewController else { return }
            vc.number = cell.number.text ?? ""
        }
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
    }
    
}
