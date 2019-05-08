//
//  ProductTableViewController.swift
//  RXSwiftDemo
//
//  Created by kong on 2019/5/6.
//  Copyright © 2019 konglee. All rights reserved.
//

import UIKit
import RxSwift

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
    
    private func configSetting() {
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        tableView.register(UINib(nibName: "ProductCellTableViewCell", bundle: nil), forCellReuseIdentifier: identifier)
        tableView.tableFooterView = UIView()
        
        self.title = "希腊"
        self.view.backgroundColor = UIColor.white
    }
    
    private func setupData() {
        
        vm.fetchNew()
            .subscribeOn(MainScheduler.instance)
            .subscribe { event in
                guard let obj = event.element as? [Product] else {
                    return
                }
                self.dataArr = obj
                self.tableView.reloadData()

        }
            .disposed(by: self.bag)
    }
    
    deinit {
        print("RxSwift Resources total \(RxSwift.Resources.total)")
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
            fatalError("xib identifier error")
        }
        
        cell.selectionStyle = .none
        cell.bind(dataArr[indexPath.row])
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130.0
    }

}
