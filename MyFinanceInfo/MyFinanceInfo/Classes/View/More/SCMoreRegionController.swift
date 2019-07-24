//
//  SCMoreRegionController.swift
//  MyFinanceInfo
//
//  Created by Stephen Cao on 24/7/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit
import SCTableIndex
protocol SCMoreRegionControllerDelegate: NSObjectProtocol {
    func updatePreferredRegion(controller: SCMoreRegionController)
}
private let reuseIdentifier = "regions_cell"
class SCMoreRegionController: UIViewController {
    var selectedCountryCode = ""
    @IBOutlet weak var tableIndex: SCTableIndex!
    @IBOutlet weak var tableView: UITableView!
    weak var delegate: SCMoreRegionControllerDelegate?
    /***
     ae ar at au be bg br ca ch cn co cu cz de eg fr gb gr hk hu id ie il in it jp kr lt lv ma mx my ng nl no nz ph pl pt ro rs ru sa se sg si sk th tr tw ua us ve za .
     */
    private let regions = [["code": "ae", "name": "The United Arab Emirates"],
                           ["code": "ar", "name": "The Argentine Republic"],
                           ["code": "at", "name": "The Republic of Austria"],
                           ["code": "au", "name": "The Commonwealth of Australia"],
                           ["code": "be", "name": "The Kingdom of Belgium"],
                           ["code": "bg", "name": "The Republic of Bulgaria"],
                           ["code": "br", "name": "The Federative Republic of Brazil"],
                           ["code": "ca", "name": "Canada"],
                           ["code": "ch", "name": "The Swiss Confederation"],
                           ["code": "cn", "name": "The People's Republic of China"],
                           ["code": "co", "name": "The Republic of Colombia"],
                           ["code": "cu", "name": "The Republic of Cuba"],
                           ["code": "cz", "name": "The Czech Republic"],
                           ["code": "de", "name": "The Federal Republic of Germany"],
                           ["code": "eg", "name": "The Arab Republic of Egypt"],
                           ["code": "fr", "name": "The French Republic"],
                           ["code": "gb", "name": "The United Kingdom of Great Britain and Northern Ireland"],
                           ["code": "gr", "name": "The Hellenic Republic"],
                           ["code": "hk", "name": "The Hong Kong Special Administrative Region of China"],
                           ["code": "hu", "name": "Hungary"],
                           ["code": "id", "name": "The Republic of Indonesia"],
                           ["code": "ie", "name": "Ireland"],
                           ["code": "il", "name": "The State of Israel"],
                           ["code": "in", "name": "The Republic of India"],
                           ["code": "it", "name": "The Italian Republic"],
                           ["code": "jp", "name": "Japan"],
                           ["code": "kr", "name": "The Republic of Korea"],
                           ["code": "lt", "name": "The Republic of Lithuania"],
                           ["code": "lv", "name": "The Republic of Latvia"],
                           ["code": "ma", "name": "The Kingdom of Morocco"],
                           ["code": "mx", "name": "The United Mexican States"],
                           ["code": "my", "name": "Malaysia"],
                           ["code": "ng", "name": "The Federal Republic of Nigeria"],
                           ["code": "nl", "name": "The Kingdom of the Netherlands"],
                           ["code": "no", "name": "The Kingdom of Norway"],
                           ["code": "nz", "name": "New Zealand"],
                           ["code": "ph", "name": "The Republic of the Philippines"],
                           ["code": "pl", "name": "The Republic of Poland"],
                           ["code": "pt", "name": "The Portuguese Republic"],
                           ["code": "ro", "name": "Romania"],
                           ["code": "rs", "name": "The Republic of Serbia"],
                           ["code": "ru", "name": "The Russian Federation"],
                           ["code": "sa", "name": "The Kingdom of Saudi Arabia"],
                           ["code": "se", "name": "The Kingdom of Sweden"],
                           ["code": "sg", "name": "The Republic of Singapore"],
                           ["code": "si", "name": "The Republic of Slovenia"],
                           ["code": "sk", "name": "The Slovak Republic"],
                           ["code": "th", "name": "The Kingdom of Thailand"],
                           ["code": "tr", "name": "The Republic of Turkey"],
                           ["code": "tw", "name": "The Republic of China"],
                           ["code": "ua", "name": "Ukraine"],
                           ["code": "us", "name": "The United States of America"],
                           ["code": "ve", "name": "The Bolivarian Republic of Venezuela"],
                           ["code": "za", "name": "The Republic of South Africa"],
    ]
    
    @objc private func clickBackButton(){
        let prevCountryCode = (UserDefaults.standard.object(forKey: InfoCommon.regionKey) as? String) ?? "us"
        let currentCountryCode = selectedCountryCode
        if currentCountryCode != "" && prevCountryCode != currentCountryCode{
            UserDefaults.standard.set(currentCountryCode, forKey: InfoCommon.regionKey)
            delegate?.updatePreferredRegion(controller: self)
        
            NotificationCenter.default.post(name: NSNotification.Name(InfoCommon.SCNewsCountryCodeHasChanged), object: nil)
        }
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", fontSize: 16, target: self, action: #selector(clickBackButton), isBack: true)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "SCMoreRegionCell", bundle: nil), forCellReuseIdentifier: reuseIdentifier)
        
        tableIndex.delegate = self
        tableIndex.initialFont = UIFont.boldSystemFont(ofSize: 13)
        tableIndex.initialTextColor = InfoCommon.tinColor
        
        var codeList = [String]()
        for country in regions{
            codeList.append(country["code"] ?? "")
        }
        tableIndex.setView(codeList)
    }
    
    
}
extension SCMoreRegionController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return regions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! SCMoreRegionCell
            cell.countryNameLabel.text = regions[indexPath.row]["name"]
        cell.countryCodeLabel.text = "Country code: \(regions[indexPath.row]["code"] ?? "")"
            return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let tableIndexWidth: CGFloat = 20
        let margin: CGFloat = 3
        let codeLabelHeight: CGFloat = 18
        var height = margin
        let countryName = regions[indexPath.row]["name"]
        height += countryName?.heightWithConstrainedWidth(width: UIScreen.screenWidth() - 2 * margin - tableIndexWidth, font: UIFont.boldSystemFont(ofSize: 15)) ?? 0
        height += margin + codeLabelHeight
        height += margin * 4
        return height 
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCountryCode = regions[indexPath.row]["code"] ?? "us"
    }
}
extension SCMoreRegionController: SCTableIndexDelegate{
    func scTableIndexReturnInitialText(_ strInitial: String, index: Int) {
        tableView.scrollToRow(at: IndexPath(row: index, section: 0), at: .top, animated: true)
    }
}
