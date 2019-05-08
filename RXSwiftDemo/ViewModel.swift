//
//  ViewModel.swift
//  RXSwiftDemo
//
//  Created by kong on 2019/5/7.
//  Copyright © 2019 konglee. All rights reserved.
//

import UIKit
import RxSwift

final class ViewModel {
    
    func fetchNew() -> Observable<Any> {
        
        return Observable.create { (subscribe) -> Disposable in
            
            let decoder = JSONDecoder()
            
            // request data
            let path = Bundle.main.url(forResource: "product.json", withExtension: nil)
            guard let urlPath = path,
                let data = try? Data(contentsOf: urlPath, options: .mappedIfSafe),
                let json = try? decoder.decode([Product].self, from: data) else {
                    subscribe.onError(NSError(domain: "com.error", code: 500, userInfo: nil))
                    return Disposables.create()
            }
            subscribe.onNext(json)
//            subscribe.onCompleted()
            return Disposables.create()
        }
    }
}
