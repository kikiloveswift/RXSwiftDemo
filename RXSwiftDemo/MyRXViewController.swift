//
//  MyViewController.swift
//  RXSwiftDemo
//
//  Created by kong on 2019/5/5.
//  Copyright © 2019 konglee. All rights reserved.
//

import UIKit
import RxSwift

final class MyRXViewController: UIViewController {
    
    private let bag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        configSetting()
    }
    
    private func configSetting() {
        self.title = "RXMemory Manager"
        self.view.backgroundColor = UIColor.white
    }
    

}
