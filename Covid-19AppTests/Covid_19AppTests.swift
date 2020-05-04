//
//  Covid_19AppTests.swift
//  Covid-19AppTests
//
//  Created by iosdev on 16.4.2020.
//  Copyright © 2020 Covid-19App. All rights reserved.
//

import XCTest
@testable import Covid_19App

class Covid_19AppTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testSymptomSetConstruction() {
        let symptom1 = SymptomSet(fever: true, cough: false, breathingDifficulties: true, musclePain: false, soreThroat: true, chills: false, headache: true, lossTasteSmell: true)
        XCTAssert(symptom1.fever == true, "Incorrect fever value")
        XCTAssert(symptom1.cough == false, "Incorrect cough value")
        XCTAssert(symptom1.breathingDifficulties == true, "Incorrect breathingDifficulties value")
        XCTAssert(symptom1.musclePain == false, "Incorrect musclePain value")
        XCTAssert(symptom1.soreThroat == true, "Incorrect soreThroat value")
        XCTAssert(symptom1.chills == false, "Incorrect chills value")
        XCTAssert(symptom1.headache == true, "Incorrect headache value")
        XCTAssert(symptom1.lossTasteSmell == true, "Incorrect lossOfTasteOrSmell value")
    }
    
    func testPersonConstructionWithLegalValues() {
        let person1 = Person(name: "Andrew", email: "andrew@email.com", password: "123456", status: "Healthy")
        let person2 = Person(name: "Andrew", email: "andrew@email.com", password: "123456", status: "Healthy", age: 28, height: 176, weight: 100)
        XCTAssert(person1?.name == "Andrew", "Incorrect name value")
        XCTAssert(person1?.email == "andrew@email.com", "Incorrect email value")
        XCTAssert(person1?.password == "123456", "Incorrect password value")
        XCTAssert(person1?.status == "Healthy", "Incorrect status value")
        XCTAssert(person2?.name == "Andrew", "Incorrect name value")
        XCTAssert(person2?.email == "andrew@email.com", "Incorrect email value")
        XCTAssert(person2?.password == "123456", "Incorrect password value")
        XCTAssert(person2?.status == "Healthy", "Incorrect status value")
        XCTAssert(person2?.height == 176, "Incorrect height value")
        XCTAssert(person2?.weight == 100, "Incorrect weight value")
        XCTAssert(person2?.age == 28, "Incorrect age value")
    }
    
    func testPersonConstructionWithIllegalValues() {
        // illegal name value
        let person3 = Person(name: "", email: "andrew@email.com", password: "123456", status: "Healthy")
        XCTAssert(person3 == nil, "Succeeded in creating person instance with empty name")
        
        // illegal status value
        let person4 = Person(name: "Andrew", email: "andrew@email.com", password: "123456", status: "Alive")
        XCTAssert(person4 == nil, "Succeeded in creating person instance with status alive")
        
        // illegal password value
        let person5 = Person(name: "Andrew", email: "andrew@email.com", password: "123", status: "Healthy")
        XCTAssert(person5 == nil, "Succeeded in creating person instance with status alive")
        
        // illegal email value
        let person6 = Person(name: "Andrew", email: "", password: "123456", status: "Healthy")
        XCTAssert(person6 == nil, "Succeeded in creating person instance with empty email")
        
        // illegal height value
        let person7 = Person(name: "Andrew", email: "andrew@email.com", password: "123456", status: "Healthy", age: 28, height: 50, weight: 100)
        XCTAssert(person7 == nil, "Succeeded in creating person instance with height less than 100")
        
        // illegal weight value
        let person8 = Person(name: "Andrew", email: "andrew@email.com", password: "123456", status: "Healthy", age: 28, height: 50, weight: 10)
        XCTAssert(person8 == nil, "Succeeded in creating person instance with height less than 100")
        
        // illegal age value
        let person9 = Person(name: "Andrew", email: "andrew@email.com", password: "123456", status: "Healthy", age: 0, height: 50, weight: 100)
        XCTAssert(person9 == nil, "Succeeded in creating person instance with age less than 18")
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
