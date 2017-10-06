//
//  ExpandableTableView.swift
//  elmenus Task
//
//  Created by Sameh Salama on 10/6/17.
//  Copyright © 2017 Da Blue Alien. All rights reserved.
//

import UIKit

class ExpandableTableView : UITableView, HeaderViewDelegate {
    
    var sectionOpen:Int = NSNotFound
    
    // MARK: HeaderViewDelegate
    func headerViewOpen(_ section: Int) {
        
        if self.sectionOpen != NSNotFound {
            headerViewClose(self.sectionOpen)
        }
        
        self.sectionOpen = section
        let numberOfRows = self.dataSource?.tableView(self, numberOfRowsInSection: section)
        var indexesPathToInsert:[IndexPath] = []
        
        for i in 0..<numberOfRows! {
            indexesPathToInsert.append(IndexPath(row: i, section: section))
        }
        
        if indexesPathToInsert.count > 0 {
            self.beginUpdates()
            self.insertRows(at: indexesPathToInsert, with: UITableViewRowAnimation.automatic)
            self.endUpdates()
        }

        self.scrollToRow(at: IndexPath(row: 0, section: section), at: .top, animated: true)
    }
    
    func headerViewClose(_ section: Int) {
        
        let numberOfRows = self.dataSource?.tableView(self, numberOfRowsInSection: section)
        var indexesPathToDelete:[IndexPath] = []
        self.sectionOpen = NSNotFound
        
        for i in 0..<numberOfRows! {
            indexesPathToDelete.append(IndexPath(row: i, section: section))
        }
        
        if indexesPathToDelete.count > 0 {
            self.beginUpdates()
            self.deleteRows(at: indexesPathToDelete, with: UITableViewRowAnimation.top)
            self.endUpdates()
        }

    }
    
}
