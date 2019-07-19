//
//  SCCompanyHistoricalPriceView.swift
//  MyFinanceInfo
//
//  Created by Stephen Cao on 19/7/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit
import Charts

class SCCompanyHistoricalPriceView: UIView {
    private lazy var candleStickView = CandleStickChartView(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: UIScreen.screenWidth() - 10, height: UIScreen.screenWidth() - 10)))
    
    var historyViewModels: [SCCompanyHistoricalPriceViewModel]?{
        didSet{
            let dataEntries1 = (0..<(historyViewModels?.count ?? 0)).map { (i) -> CandleChartDataEntry in

                let high = historyViewModels?[i].high ?? 0
                let low = historyViewModels?[i].low ?? 0
                let open = historyViewModels?[i].open ?? 0
                let close = historyViewModels?[i].close ?? 0
                return CandleChartDataEntry(x: Double(i),
                                            shadowH: high,
                                            shadowL: low,
                                            open: open,
                                            close: close)
            }
            var xValues = [String]()
            for viewModel in historyViewModels ?? []{
                xValues.append(viewModel.date ?? "")
            }
            candleStickView.xAxis.valueFormatter = IndexAxisValueFormatter(values: xValues)
            
            let chartDataSet = CandleChartDataSet(entries: dataEntries1, label: "Historical Price")
            
            chartDataSet.increasingColor = InfoCommon.increasingPriceColor
            chartDataSet.decreasingColor = InfoCommon.decreasingPriceColor
            chartDataSet.shadowColor = .darkGray
            
            chartDataSet.highlightColor = UIColor.darkGray
            chartDataSet.highlightLineWidth = 2
            chartDataSet.highlightLineDashLengths = [4, 2]
            
            let chartData = CandleChartData(dataSets: [chartDataSet])
            candleStickView.data = chartData
        }
    }
    class func historicalPriceView()->SCCompanyHistoricalPriceView{
        let nib = UINib(nibName: "SCCompanyHistoricalPriceView", bundle: nil)
        let v = nib.instantiate(withOwner: self, options: nil)[0] as! SCCompanyHistoricalPriceView
        v.frame = UIScreen.main.bounds
        return v
    }
    @IBAction func clickHistoricalPriceMaskButton(_ sender: Any) {
        dismiss {}
        candleStickView.highlightValues(nil)
        candleStickView.fitScreen()
    }
    @IBOutlet weak var chartView: UIView!{
        didSet{
            chartView.addSubview(candleStickView)
            
            candleStickView.xAxis.drawGridLinesEnabled = false
            candleStickView.rightAxis.enabled = false
            candleStickView.scaleYEnabled = true
            candleStickView.doubleTapToZoomEnabled = true
            candleStickView.dragEnabled = true
            candleStickView.dragDecelerationEnabled = true
            candleStickView.dragDecelerationFrictionCoef = 0.9
            candleStickView.xAxis.labelPosition = .bottom
            candleStickView.legend.textColor = UIColor.white
            candleStickView.legend.font = .boldSystemFont(ofSize: 12)
            candleStickView.legend.form = .line
            candleStickView.leftAxis.labelTextColor = .white
            candleStickView.xAxis.labelTextColor = .white
            candleStickView.xAxis.labelRotationAngle = -30
        }
    }
    
}
extension SCCompanyHistoricalPriceView{
    func show(completion:@escaping ()->()){
        addPopHorizontalAnimation(fromValue: UIScreen.screenWidth() * 3 / 2, toValue: UIScreen.screenWidth() / 2, springBounciness: 8, springSpeed: 8, delay: 0) { (_, _) in
            completion()
        }
    }
    func dismiss(completion:@escaping ()->()){
        addPopHorizontalAnimation(fromValue: UIScreen.screenWidth() / 2, toValue: UIScreen.screenWidth() * 3 / 2, springBounciness: 8, springSpeed: 8, delay: 0) { (_, _) in
            completion()
        }
    }
}
