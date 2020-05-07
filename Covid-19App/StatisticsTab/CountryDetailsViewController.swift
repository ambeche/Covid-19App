//
//  CountryDetailsViewController.swift
//  Covid-19App
//
//  Created by iosdev on 27.4.2020.
//  Copyright © 2020 Covid-19App. All rights reserved.
//
//  CountryDetailsViewController receives country specific data from StatisticsTableViewController
//  It then manipulates the data to dispaly details ofcountry specific statistics
//  Uses the charts library to plot line and bar charts of the infection rates

import UIKit
import Charts

class CountryDetailsViewController: UIViewController, ChartViewDelegate {
    
    var stats: Country?
    var lineChart = LineChartView()
    var barChart = BarChartView()
    
    @IBOutlet weak var lineChartView: UIView!
    
    @IBOutlet weak var barView: UIView!
    
    
    @IBOutlet weak var countryName: UILabel!
    
    @IBOutlet weak var critical: UILabel!
    
    @IBOutlet weak var recovered: UILabel!
    
    @IBOutlet weak var deaths: UILabel!
    
    @IBOutlet weak var confirmed: UILabel!
    
    @IBOutlet weak var todayDeaths: UILabel!
    
    @IBOutlet weak var todayConfirmed: UILabel!
    
    @IBOutlet weak var recoveryRate: UILabel!
    @IBOutlet weak var deathRate: UILabel!
    
    @IBOutlet weak var lastUpdated: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showCountryDetails()
        drawChart()
        lineChart.delegate = self
        barChart.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        barView.addSubview(barChart)
        lineChartView.addSubview(lineChart)
    }
    
    func showCountryDetails() {
        
      if let stats = stats,
        let countryName = countryName,
        let critical = critical,
        let recovered = recovered,
        let deaths = deaths,
        let confirmed = confirmed {
        countryName.text = stats.name
        critical.text = "\(stats.latest_data.critical ?? 0)"
        recovered.text = "\(stats.latest_data.recovered)"
        deaths.text = "\(stats.latest_data.deaths)"
        confirmed.text = "\(stats.latest_data.confirmed)"
        todayDeaths.text = "\(stats.today.deaths)"
        todayConfirmed.text = "\(stats.today.confirmed)"
        deathRate.text = "\(Double(round((stats.latest_data.calculated.death_rate ?? 0.0) * 100000)/100000))"
        recoveryRate.text = "\(Double(round((stats.latest_data.calculated.recovery_rate ?? 0.0) * 100000)/100000))"
        lastUpdated.text = "Last Updated \(stats.updated_at)"
      }
    }

//  Draws line and bar charts
    func drawChart(){
        var barEntries = [BarChartDataEntry]()
        var lineEntries = [ChartDataEntry]()
        
        guard let stats = stats else{
                       return
        }
        var i = 0
               
        for x in stats.timelineU.reversed() {
            i += 1
            lineEntries.append(ChartDataEntry( x:Double(i), y: Double(x.confirmed)))
            barEntries.append(BarChartDataEntry( x:Double(x.deaths), y: Double(x.recovered)))
            print(x.recovered)
        }
               
        let lineDataSet = LineChartDataSet(entries: lineEntries, label: "Spread Over Time")
        lineDataSet.label = NSLocalizedString("Spread Over Time", comment: "spread over time");
        let barDataSet = BarChartDataSet(entries: barEntries, label: "Recovery vs Deaths")
        barDataSet.label = NSLocalizedString("Recovery vs Deaths", comment: "recovery vs deaths");
        lineDataSet.colors = ChartColorTemplates.joyful()
        lineChart.frame = lineChartView.frame
        lineChart.center = CGPoint(x: 168, y:200)
        lineChart.animate(xAxisDuration: 4.0, yAxisDuration: 4.0, easingOption: .easeInBounce)
        lineChart.noDataText = NSLocalizedString("loading", comment:"loading");
        lineChart.chartDescription?.text = NSLocalizedString("Infection Timeline", comment: "Infection timeline");
        lineChart.chartDescription?.position = CGPoint(x: 220, y: 50)
        lineChart.chartDescription?.textColor = .systemBlue
        lineChart.chartDescription?.font = UIFont(name: "Helvetica", size: 20)!
        lineChart.xAxis.labelPosition = .bottomInside
        lineChart.data  = LineChartData( dataSet: lineDataSet)
        
        barDataSet.colors = ChartColorTemplates.material()
        barChart.frame = barView.frame
        barChart.center = CGPoint(x: 168, y:280)
        barChart.animate(xAxisDuration: 6.0, yAxisDuration: 6.0, easingOption: .easeInBounce)
        barChart.noDataText = "loading"
        barChart.chartDescription?.text = "Recovered Vs Deaths Over Time"
        barChart.chartDescription?.position = CGPoint(x: 320, y: 70)
        barChart.chartDescription?.textColor = .systemBlue
        barChart.chartDescription?.font = UIFont(name: "Helvetica", size: 20)!
        barChart.xAxis.labelPosition = .bottomInside
        barChart.xAxis.labelTextColor = .systemRed
        barChart.data  = BarChartData(dataSet: barDataSet)
        
    }
}
