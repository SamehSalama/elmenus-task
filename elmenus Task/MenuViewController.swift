//
//  MenuViewController.swift
//  elmenus Task
//
//  Created by Sameh Salama on 10/6/17.
//  Copyright © 2017 Da Blue Alien. All rights reserved.
//

import UIKit
import SVProgressHUD

class MenuViewController: UIViewController {


    //MARK: - IBOutlets
    @IBOutlet weak var menuTableView: ExpandableTableView!

    //MARK: - Properties
    var categoriesArray:[Category] = []
    let tableViewSectionHeight:CGFloat = 50
    let tableViewHeaderLabelPadding:CGFloat = 8

    //MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.automaticallyAdjustsScrollViewInsets = false

        self.navigationItem.title = "Categories"
        self.navigationController?.navigationBar.barTintColor = .white
        self.navigationController?.navigationBar.tintColor = elmenusColor

        self.menuTableView.dataSource = self
        self.menuTableView.delegate = self

        self.menuTableView.estimatedRowHeight = 104
        self.menuTableView.rowHeight = UITableViewAutomaticDimension

        self.getMenu()
    }

    //MARK: - Communications
    func getMenu() {

        SVProgressHUD.show()

        let networkManager = NetworkManager()

        networkManager.requestCompletionHandler = ({(JSON: Any?) -> Void in
            DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async {

                if let responseJSON = JSON as? [String:Any] {
                    if let categories = responseJSON["categories"] as? [[String:Any]] {
                        self.categoriesArray = Parser.parse(categories: categories)
                    }
                }

                DispatchQueue.main.async(execute: {
                    SVProgressHUD.dismiss()
                    if JSON != nil {
                        self.menuTableView.reloadData()
                    }
                    else {
                        HelperFunctions.alertWithSingleAction(presentingViewController: self, alertTitle: "Error!", alertMessage: "something went wrong.", actionTitle: "close", actionHandler: nil)
                    }

                })
            }
        })

        networkManager.errorHandler = ({(error: Any?, statusCode: Int) -> Void in
            DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async {
                DispatchQueue.main.async(execute: {
                    SVProgressHUD.dismiss()
                    HelperFunctions.alertWithSingleAction(presentingViewController: self, alertTitle: "Error!", alertMessage: "something went wrong.", actionTitle: "close", actionHandler: nil)
                })
            }
        })
        
        networkManager.getMenu()
    }

    //MARK: - Custom Functions
    func itemCellLikeButtonAction(sender: UIButton) {

        let item = self.categoriesArray[self.menuTableView.sectionOpen].items[sender.tag]
        HelperFunctions.alertWithSingleAction(presentingViewController: self, alertTitle: "I Like", alertMessage: item.name, actionTitle: "OK", actionHandler: nil)
    }

}


extension MenuViewController: UITableViewDataSource, UITableViewDelegate {

    //MARK: - UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.categoriesArray.count

    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.menuTableView.sectionOpen != NSNotFound && section == self.menuTableView.sectionOpen ? self.categoriesArray[section].items.count : 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let itemCell = tableView.dequeueReusableCell(withIdentifier: "ItemTableViewCell") as! ItemTableViewCell

        let item = self.categoriesArray[indexPath.section].items[indexPath.row]
        itemCell.itemNameLabel.text = item.name
        itemCell.itemDescriptionLabel.text = item.description
        itemCell.itemLikeButton.tag = indexPath.row
        itemCell.itemLikeButton.addTarget(self, action: #selector(MenuViewController.itemCellLikeButtonAction(sender:)), for: .touchUpInside)

        return itemCell
    }


    //MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return self.tableViewSectionHeight
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        let headerView = HeaderView(tableView: self.menuTableView, section: section)
        headerView.backgroundColor = .white


        let label = UILabel(frame: CGRect(x: self.tableViewHeaderLabelPadding, y: 0, width: tableView.bounds.width - (self.tableViewHeaderLabelPadding * 2), height: self.tableViewSectionHeight - 1))
        label.text = self.categoriesArray[section].name
        label.textAlignment = NSTextAlignment.left
        label.textColor = elmenusColor

        let lineView = UIView(frame: CGRect(x: 0, y: label.bounds.height - 1, width: label.bounds.width, height: 1))
        lineView.backgroundColor = elmenusColor.withAlphaComponent(0.2)
        label.addSubview(lineView)


        headerView.addSubview(label)

        return headerView
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

    


}
