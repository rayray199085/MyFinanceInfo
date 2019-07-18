//
//  SCCompanyStatementDataView.swift
//  MyFinanceInfo
//
//  Created by Stephen Cao on 18/7/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit
import Charts

class SCCompanyStatementDataView: UIView {
    var date: [String]?
    private var circleColors = [UIColor]()
    private lazy var lineChart = LineChartView(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: UIScreen.screenWidth() - 10, height: (UIScreen.screenWidth() - 10) * 0.75)))
    
    var item: SCCompanyStatementItem?{
        didSet{
            guard let values = item?.values,
                  let chartLabel = item?.name else{
                return
            }
            
            var dataEntries = [ChartDataEntry]()
            for (index,value) in values.enumerated() {
                let entry = ChartDataEntry.init(x: Double(index), y: value)
                dataEntries.append(entry)
                circleColors.append(InfoCommon.tinColor)
            }
            let xValues = date ?? []
            lineChart.xAxis.valueFormatter = IndexAxisValueFormatter(values: xValues)
            
            let chartDataSet = LineChartDataSet(entries: dataEntries, label: chartLabel)
            chartDataSet.colors = [.darkGray]
            chartDataSet.circleColors = circleColors
            chartDataSet.circleHoleColor = .red
            chartDataSet.circleRadius = 6
            chartDataSet.circleHoleRadius = 2
            chartDataSet.drawValuesEnabled = false
            
            chartDataSet.drawFilledEnabled = true
            let gradientColors = [UIColor.darkGray.cgColor, UIColor.white.cgColor] as CFArray
            let colorLocations:[CGFloat] = [1.0, 0.0]
            let gradient = CGGradient.init(colorsSpace: CGColorSpaceCreateDeviceRGB(),
                                           colors: gradientColors, locations: colorLocations)
            chartDataSet.fill = Fill.fillWithLinearGradient(gradient!, angle: 90.0)
            
            chartDataSet.highlightColor = UIColor.darkGray
            chartDataSet.highlightLineWidth = 2
            chartDataSet.highlightLineDashLengths = [4, 2]
            
            let chartData = LineChartData(dataSets: [chartDataSet])
            lineChart.data = chartData
        }
    }
    
    
    @IBOutlet weak var chartView: UIView!{
        didSet{
            chartView.addSubview(lineChart)
            
            lineChart.delegate = self
            lineChart.leftAxis.drawGridLinesEnabled = false
            lineChart.xAxis.drawGridLinesEnabled = false
            lineChart.rightAxis.enabled = false
            lineChart.scaleYEnabled = true
            lineChart.doubleTapToZoomEnabled = true
            lineChart.dragEnabled = true
            lineChart.dragDecelerationEnabled = true
            lineChart.dragDecelerationFrictionCoef = 0.9
            lineChart.xAxis.labelPosition = .bottom
            lineChart.legend.textColor = InfoCommon.tinColor
            lineChart.legend.form = .line
        }
    }
    
    class func dataView()->SCCompanyStatementDataView{
        let nib = UINib(nibName: "SCCompanyStatementDataView", bundle: nil)
        let v = nib.instantiate(withOwner: self, options: nil)[0] as! SCCompanyStatementDataView
        v.frame = UIScreen.main.bounds
        return v
    }
    
    @IBAction func clickDataMaskButton(_ sender: Any) {
        isHidden = true
        lineChart.highlightValues(nil)
        lineChart.fitScreen()
    }
    func showMarkerView(value: Double){
        let marker = BalloonMarker(color: UIColor(white: 180/255, alpha: 1),
                                   font: .boldSystemFont(ofSize: 12),
                                   textColor: .white,
                                   insets: UIEdgeInsets(top: 8, left: 8, bottom: 20, right: 8))
        marker.chartView = lineChart
        marker.minimumSize = CGSize(width: 80, height: 40)
        marker.setLabel(value.formatNumber())
        lineChart.marker = marker
    }
    
}
extension SCCompanyStatementDataView: ChartViewDelegate{
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry,
                            highlight: Highlight) {
        var chartDataSet = LineChartDataSet()
        chartDataSet = (chartView.data?.dataSets[0] as? LineChartDataSet)!
        let values = chartDataSet.entries
        let index = values.firstIndex(where: {$0.x == highlight.x})
        chartDataSet.circleColors = circleColors
        chartDataSet.circleColors[index!] = .red
        
        showMarkerView(value: item?.values[index!] ?? 0)
        chartView.data?.notifyDataChanged()
        chartView.notifyDataSetChanged()
    }
    
    func chartValueNothingSelected(_ chartView: ChartViewBase) {
        var chartDataSet = LineChartDataSet()
        chartDataSet = (chartView.data?.dataSets[0] as? LineChartDataSet)!
        chartDataSet.circleColors = circleColors

        chartView.data?.notifyDataChanged()
        chartView.notifyDataSetChanged()
    }
}
