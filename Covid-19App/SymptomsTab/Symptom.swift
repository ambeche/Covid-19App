//
//  Symptom.swift
//  Covid-19App
//
//  Created by Rafe Ibrahim on 4.5.2020.
//  Copyright © 2020 Covid-19App. All rights reserved.
//

import Foundation

class SymptomSet {


    private(set) var fever: Bool
    private(set) var cough: Bool
    private(set) var breathingDifficulties: Bool
    private(set) var musclePain: Bool
    private(set) var soreThroat: Bool
    private(set) var chills: Bool
    private(set) var headache: Bool
    private(set) var lossTasteSmell: Bool
    private(set) var date: Date
    
    init (fever: Bool, cough: Bool, breathingDifficulties: Bool, musclePain: Bool, soreThroat: Bool, chills: Bool, headache: Bool, lossTasteSmell: Bool){
        self.fever = fever
        self.cough = cough
        self.breathingDifficulties = breathingDifficulties
        self.musclePain = musclePain
        self.soreThroat = soreThroat
        self.chills = chills
        self.headache = headache
        self.lossTasteSmell = lossTasteSmell
        self.date = Date()
    }
}
