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
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var primesCount: Int? {
        didSet {
            if let count = primesCount {
                primesCountLabel.text = "\(count) prime" + (count == 1 ? "" : "s")
            } else {
                primesCountLabel.text = nil
            }
        }
    }
    
    var defaultBackgroundColor = UIColor()
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
        activityIndicator.hidesWhenStopped = true
        
        defaultBackgroundColor = view.backgroundColor!

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
        activityIndicator.startAnimating()
        collectionView.backgroundColor = UIColor(white: 0.0, alpha: 0.1)
        guard let upperBound = textField.text else { return }
        if let limit = Int(upperBound) {
            DispatchQueue.global(qos: .background).async {
                self.sieve.upperBound = limit
                DispatchQueue.main.async {
                    self.primesCountLabel.isHidden = false
                    // remove any leading zeros
                    self.textField.text = String(limit)
                    self.primesCount = self.sieve.numberOfPrimes
                    self.collectionView.reloadData()
                    self.activityIndicator.stopAnimating()
                    self.collectionView.backgroundColor = self.defaultBackgroundColor
                }
            }
            
        } else {
            sieve.upperBound = 0
            primesCountLabel.isHidden = true
            primesCount = sieve.numberOfPrimes
            collectionView.reloadData()
            collectionView.backgroundColor = defaultBackgroundColor
        }
        
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
