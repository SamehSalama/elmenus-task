//
//  HeaderView.swift
//  elmenus Task
//
//  Created by Sameh Salama on 10/6/17.
//  Copyright © 2017 Da Blue Alien. All rights reserved.
//

import UIKit

protocol HeaderViewDelegate {
    func headerViewOpen(_ section:Int)
    func headerViewClose(_ section:Int)
}

class HeaderView: UIView {
    
    var delegate:HeaderViewDelegate?
    var section:Int?
    var tableView:ExpandableTableView?
    
    required init(tableView:ExpandableTableView, section:Int){
        
        let height = tableView.delegate?.tableView!(tableView, heightForHeaderInSection: section)
        let frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: height!)
        
        super.init(frame: frame)
        
        self.tableView = tableView
        self.delegate = tableView
        self.section = section
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        let toggleButton = UIButton()
        toggleButton.addTarget(self, action: #selector(HeaderView.toggle(_:)), for: UIControlEvents.touchUpInside)
        toggleButton.backgroundColor = UIColor.clear
        toggleButton.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        self.addSubview(toggleButton)
    }
    
    func toggle(_ sender:AnyObject) {
        
        if self.tableView!.sectionOpen != self.section! {
            self.delegate?.headerViewOpen(self.section!)
        } else if self.tableView!.sectionOpen != NSNotFound {
            self.delegate?.headerViewClose(self.tableView!.sectionOpen)
        }
    }
}
