//
//  Sieve.swift
//  SieveOfErasthosthenes
//
//  Created by Daniel Jisoo Choi on 11/25/16.
//  Copyright © 2016 Daniel Jisoo Choi. All rights reserved.
//

import Foundation

class Sieve {
    
    private var isPrime = [Bool]()
    var primes = [Int]()
    
    var numberOfPrimes: Int {
        return primes.count
    }
    
    var upperBound: Int = 0 {
        didSet {
            primes = sieveOfErasthosthenes(for: upperBound)
        }
    }
    
    private func sieveOfErasthosthenes(for limit: Int) -> [Int] {
        
        guard limit > 1 else { return [] }
        
        isPrime = [Bool](repeating: true, count: limit+1)
        
        for i in 0..<2 {
            isPrime[i] = false
        }
        
        for i in 2..<isPrime.count where isPrime[i] {
            var j = i*i
            while j <= limit {
                print(j)
                isPrime[j] = false
                j += i
            }
        }
        
        let filteredPrimes = isPrime.enumerated()
            .filter { (_: Int, element: Bool) -> Bool in
                element
            }
            .map({ (index: Int, _: Bool) -> Int in
                index
            })
        
        return filteredPrimes
    }
}
