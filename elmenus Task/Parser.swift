//
//  Parser.swift
//  elmenus Task
//
//  Created by Sameh Salama on 10/5/17.
//  Copyright © 2017 Da Blue Alien. All rights reserved.
//

import Foundation

class Parser {

    class func parse(categories:[[String:Any]]) -> [Category] {

        var categoriesArray:[Category] = []

        for aCategory in categories {
            if let category = self.parse(category: aCategory) {
                categoriesArray.append(category)
            }
        }

        return categoriesArray
    }

    class func parse(category:[String:Any]) -> Category? {

        guard let id = category["id"] as? Int,
            let name = category["name"] as? String,
            let items = category["items"] as? [[String:Any]]
            else {return nil}

        return Category(id: id, name: name, items: self.parse(items: items))
    }

    class func parse(items:[[String:Any]]) -> [Item] {
        var itemsArray:[Item] = []
        for anItem in items {
            if let item = self.parse(item: anItem) {
                itemsArray.append(item)
            }
        }
        return itemsArray
    }

    class func parse(item:[String:Any]) -> Item? {

        guard let id = item["id"] as? Int,
            let name = item["name"] as? String,
            let description = item["description"] as? String
            else {return nil}

        return Item(id: id, name: name, description: description)
    }
}
