//
//  Covid19Data.swift
//  Covid-19App
//
//  Created by iosdev on 26.4.2020.
//  Copyright © 2020 Covid-19App. All rights reserved.
//

import Foundation

     struct Covid19Data: Codable {
         
         var data: [Country]
         
         var globalDeaths: Int{
             data.reduce(0){ agg,e in
                 agg + e.latest_data.deaths
             }
         }
         
         var globalRecovered: Int {
             data.reduce(0){ agg,e in
                 agg + e.latest_data.recovered
             }
         }
         
         var globalConfirmed: Int {
                data.reduce(0){ agg,e in
                    agg + e.latest_data.confirmed
                }
            }
         var globalCritical: Int {
             data.reduce(0){ agg,e in
                 agg + (e.latest_data.critical ?? 0)
             }
         }
     }

     struct Country: Codable {
         var coordinates: Coords
         var name: String
         let code: String
         var population: Int?
         var updated_at: String
         var today: Today
         var latest_data: LatestData
         var timeline: [Timeline]?
         var timelineU: [Timeline] {
                timeline ?? []
            }
         
        private enum Codingkeys: String, CodingKey {
             case coordinates = "coords"
             case name
             case code
             case population
             case updated_at = "lastUpdated"
             case today
             case latest_data = "latestData"
         }
     }

     struct Coords: Codable {
         var latitude: Double?
         var longitude: Double?
     }

     struct Today: Codable {
         var deaths: Int
         var confirmed: Int
     }

     struct LatestData: Codable {
         var deaths: Int
         var confirmed: Int
         var recovered: Int
         var critical: Int?
         var calculated: Calculated
         
         private enum Codingkeys: String, CodingKey {
             case deaths
             case confirmed
             case recovery
             case critical
         }
     }

     struct Calculated: Codable {
         var death_rate:Double?
         var recovery_rate: Double?
        
         private enum Codingkeys: String, CodingKey {
             case death_rate = "deathRate"
             case recovery = "recoveryRate"
         }
     }

     struct Timeline: Codable {
         
         var confirmed: Int
         var deaths: Int
         var recovered: Int
         
         private enum Codingkeys: String, CodingKey {
             case confirmed
             case deaths
             case recovered
         }
     }

     struct GlobalTimeline: Codable {
         var data: [Timeline]
         var _cacheHit: Bool
         
         private enum Codingkeys: String, CodingKey {
                case data
         }
    }

