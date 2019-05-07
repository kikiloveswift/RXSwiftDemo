//
//  ProductTableViewController.swift
//  RXSwiftDemo
//
//  Created by kong on 2019/5/6.
//  Copyright © 2019 konglee. All rights reserved.
//

import UIKit

import RxSwift
import SwiftyJSON

final class ProductTableViewController: UITableViewController {

    private var dataArr: [Product] = []
    
    private let identifier = "productCell"
    
    private let bag = DisposeBag()
    
    private let vm = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configSetting()
        setupData()
    }
    
    func configSetting() {
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        tableView.register(UINib(nibName: "ProductCellTableViewCell", bundle: nil), forCellReuseIdentifier: identifier)
        tableView.tableFooterView = UIView()
        
        self.title = "希腊"
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.view.backgroundColor = UIColor.white
    }
    
    func setupData() {
        
        vm.fetchNew()
            .take(1, scheduler: MainScheduler.instance)
            .subscribe { (event) in
                print("RxSwift Resources Count \(RxSwift.Resources.total)")
                guard let obj = event.element as? [Product] else {
                    return
                }
                self.dataArr = obj
                self.tableView.reloadData()

        }
            .disposed(by: self.bag)
    }
    
    

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? ProductCellTableViewCell else {
            return UITableViewCell()
        }
        
        cell.selectionStyle = .none
        cell.bind(dataArr[indexPath.row])
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130.0
    }

}
