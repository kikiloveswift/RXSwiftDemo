//
//  ViewController.swift
//  RXSwiftDemo
//
//  Created by konglee on 2019/5/4.
//  Copyright © 2019 konglee. All rights reserved.
//

import UIKit

final class ViewController: UITableViewController {
    
    private var dataArr = [String]()
    
    private let identifier = "reuseCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configSetting()
        setupData()
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configSetting() {
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: identifier)
        tableView.tableFooterView = UIView()
        self.title = "🌹"
    }
    
    func setupData() {
        dataArr = [
            "ProductTableViewController"
        ]
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return dataArr.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        cell.textLabel?.text = dataArr[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let appName: String = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String {
            
            let vcName = dataArr[indexPath.row]
            let classStringName: String = appName + "." + vcName
            if let toClass: UIViewController.Type = NSClassFromString(classStringName) as? UIViewController.Type {
                let toController: UIViewController = toClass.init()
                self.navigationController?.pushViewController(toController, animated: true)
            }
        }
    }
    
}

