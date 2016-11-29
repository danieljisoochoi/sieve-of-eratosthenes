//
//  SieveOfEratosthenesTests.swift
//  SieveOfEratosthenesTests
//
//  Created by Daniel Jisoo Choi on 11/25/16.
//  Copyright © 2016 Daniel Jisoo Choi. All rights reserved.
//

import XCTest
@testable import SieveOfEratosthenes

class SieveOfEratosthenesTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testSieveZero() {
        // given
        let sieve1 = Sieve()
        let sieve2 = Sieve()
        let sieve3 = Sieve()
        
        // when
        sieve1.upperBound = 0
        sieve2.upperBound = 1
        sieve3.upperBound = -1
        
        // then
        XCTAssertEqual(sieve1.numberOfPrimes, 0)
        XCTAssertEqual(sieve2.numberOfPrimes, 0)
        XCTAssertEqual(sieve3.numberOfPrimes, 0)
        XCTAssertEqual(sieve1.primes, [])
        XCTAssertEqual(sieve2.primes, [])
        XCTAssertEqual(sieve3.primes, [])
    }
    
    func testSieveOne() {
        // given
        let sieve = Sieve()
        
        // when
        sieve.upperBound = 2
        
        // then
        XCTAssertEqual(sieve.numberOfPrimes, 1)
        XCTAssertEqual(sieve.primes, [2])
    }
    
    func testSieveAny() {
        // given
        let sieve = Sieve()
        
        // when
        sieve.upperBound = 10
        
        // then
        XCTAssertEqual(sieve.numberOfPrimes, 4)
        XCTAssertEqual(sieve.primes, [2,3,5,7])
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
