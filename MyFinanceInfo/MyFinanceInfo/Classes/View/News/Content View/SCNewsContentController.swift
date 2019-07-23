//
//  SCNewsContentController.swift
//  MyFinanceInfo
//
//  Created by Stephen Cao on 23/7/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit
import GSKStretchyHeaderView
private let reuseIdentifier = "details_cell"
class SCNewsContentController: UIViewController {
    var viewModel: SCNewsArticleViewModel?
    private var stretchyHeader: SCStretchyHeaderView!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let imageHeight = UIScreen.screenWidth() * 0.56
        stretchyHeader = SCStretchyHeaderView.headerView(frame: CGRect(x: 0, y: 0, width: UIScreen.screenWidth(), height: imageHeight)) as? SCStretchyHeaderView
        
        stretchyHeader.stretchDelegate = self
        stretchyHeader.expansionMode = .immediate
        
        stretchyHeader.minimumContentHeight = 0
        stretchyHeader.maximumContentHeight = imageHeight
        stretchyHeader.contentShrinks = true
        stretchyHeader.contentExpands = false
        
        tableView.addSubview(stretchyHeader)
        
        stretchyHeader.newsImageView.setImage(urlString: viewModel?.imageUrlString, placeholderImage: UIImage(named: "empty_picture"))
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: "SCNewsDetailsCell", bundle: nil), forCellReuseIdentifier: reuseIdentifier)
    }
}
extension SCNewsContentController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! SCNewsDetailsCell
        cell.viewModel = viewModel
        cell.delegate = self
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel?.detailsRowHeight ?? 0
    }
}

extension SCNewsContentController: GSKStretchyHeaderViewStretchDelegate{
    func stretchyHeaderView(_ headerView: GSKStretchyHeaderView, didChangeStretchFactor stretchFactor: CGFloat) {
    }
}
extension SCNewsContentController: SCNewsDetailsCellDelegate{
    func didClickLinkButton(view: SCNewsDetailsCell) {
        let vc = SCNewsWebController()
        vc.urlString = viewModel?.link
        let nav = SCNavigationViewController(rootViewController: vc)
        present(nav, animated: true, completion: nil)
    }
}
